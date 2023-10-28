#!/bin/bash

set -e -u

LOG=run-tests.log
FRONTEND=./cpdb-text-frontend
QUEUE=testprinter_cpdb_libs
FILE_TO_PRINT=/usr/share/cups/data/default-testpage.pdf
#CUPS_SPOOL_DIR=/var/spool/cups

export LD_LIBRARY_PATH=`pwd`/cpdb/.libs

cleanup() {
    # Show log
    cat $LOG
    # Remove the log file
    rm -f $LOG
    # Delete the printer
    lpadmin -x $QUEUE 2>/dev/null || :
}

trap cleanup 0 EXIT INT QUIT ABRT PIPE TERM

# Create the log file
rm -f $LOG
touch $LOG

# Run the test frontend with a session D-Bus and feed in commands.
( \
  sleep 1; \
  echo stop \
) | dbus-run-session -- $FRONTEND > $LOG 2>&1 &

# Give the frontend a maximum of 5 seconds to run and then kill it, to avoid
# the script getting stuck if stopping it fails.
i=0
FRONTEND_PID=$!
while kill -0 $FRONTEND_PID >/dev/null 2>&1; do
    i=$((i+1))
    if test $i -ge 5; then
	kill -KILL $FRONTEND_PID >/dev/null 2>&1 || true
	echo "FAIL: Frontend keeps running!"
	exit 1
    fi
    sleep 1
done

if grep -q "Stopping front end" $LOG; then
    echo "Frontend correctly shut down"
else
    echo "FAIL: Frontend not correctly stopped!"
    exit 1
fi

# Create the log file
rm -f $LOG
touch $LOG

# Create a test print queue (disabled, but accepting jobs)
#cupsctl --debug-logging
lpadmin -p $QUEUE -v file:/dev/null -m drv:///sample.drv/laserjet.ppd -o PageSize=Env10 2>/dev/null
cupsaccept $QUEUE

# Wait for CUPS to DNS-SD-broadcast the queue
sleep 5

# Run the demo with a session D-Bus and feed in commands, in parallel
# do a kill on the demo process after a timeout, for the case that the
# commands take too long or stopping the demo does not work. Ignore the
# error of the kill command if the demo gets stopped correctly.
( \
  sleep 5; \
  echo get-all-options $QUEUE CUPS; \
  sleep 2; \
  echo print-file $FILE_TO_PRINT $QUEUE CUPS; \
  sleep 1; \
  echo stop \
) | dbus-run-session -- $FRONTEND >> $LOG 2>&1

cat $LOG

echo

# Does the printer appear in the initial list of available printers?
echo "Initial listing of the printer:"
if ! grep '^Printer '$QUEUE'$' $LOG; then
    echo "FAIL: CUPS queue $QUEUE not listed!"
    exit 1
fi

echo

# Does the attribute "printer-resolution" appear in the list of options?
echo "Attribute listing of \"printer-resolution\":"
if ! grep 'printer-resolution' $LOG; then
    echo "FAIL: Attribute \"printer-resolution\" not listed!"
    exit 1
fi

echo

# Does the attribute "print-quality" appear in the list of options?
echo "Attribute listing of \"print-quality\":"
if ! grep 'print-quality' $LOG; then
    echo "FAIL: Attribute \"print-quality\" not listed!"
    exit 1
fi

echo

# Does the setting "na_number-10_4.125x9.5in" appear as a default setting?
echo "\"na_number-10_4.125x9.5in\" as a default setting:"
if ! grep 'DEFAULT: *na_number-10_4.125x9.5in' $LOG; then
    echo "Setting \"na_number-10_4.125x9.5in\" not listed as default!"
    exit 1
fi

echo

# Did the successful submission of a print job get confirmed?
echo "Confirmation message for job submission:"
if ! grep -i 'Document send succeeded' $LOG; then
    echo "No confirmation of job submission!"
    exit 1
fi

grep '\[Job [0-9]' /var/log/cups/error_log | tail -50

JOBNUM=
COUNT=1
echo "Trying to find the job ... "
while [ -z "$JOBNUM" ]; do
    # Find the job
    sleep 5
    echo "Attempt: $COUNT";
    echo "Jobs submitted:"
    lpstat -o $QUEUE
    echo "Jobs completed:"
    lpstat -W completed -o
    echo
    JOBNUM=`lpstat -o $QUEUE | tail -1 | cut -d ' ' -f 1 | cut -d - -f 2`
    COUNT=$(( $COUNT + 1 ))
    if test $COUNT -gt 20; then
	echo "Job not found!"
	exit 1
    fi
done

echo "SUCCESS!"

exit 0
