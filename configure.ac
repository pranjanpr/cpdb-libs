#                                               -*- Autoconf -*- 
# Process this file with autoconf to produce a configure script. 
 
AC_PREREQ([2.69]) 
AC_INIT([cpdb-libs], [2.0.0], [https://github.com/OpenPrinting/cpdb-libs/issues], [cpdb-libs], [https://github.com/OpenPrinting/cpdb-libs])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_SRCDIR([cpdb/cpdb-frontend.h])
AM_INIT_AUTOMAKE([-Wall foreign])

: ${CFLAGS=""}

# Check for a C compiler 
AC_PROG_CC 

#Check for archiver
AM_PROG_AR

LT_INIT

PKG_CHECK_MODULES([GIO],[gio-2.0]) 
PKG_CHECK_MODULES([GIOUNIX],[gio-unix-2.0]) 
PKG_CHECK_MODULES([GLIB],[glib-2.0]) 

# Checks for header files. 
AC_CHECK_HEADERS([stdlib.h string.h unistd.h sys/stat.h]) 
 
# Checks for typedefs, structures, and compiler characteristics. 
AC_TYPE_SIZE_T 
 
# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([access
                getcwd
                mkdir])

# The info directory which will be read by the frontend
CPDB_BACKEND_INFO_DIR="$datadir/print-backends"
AC_SUBST([CPDB_BACKEND_INFO_DIR])

# The directory for the backend executables
CPDB_BACKEND_EXEC_DIR="$libdir/print-backends"
AC_SUBST([CPDB_BACKEND_EXEC_DIR])

# The directory for system wide config files
CPDB_SYSCONFDIR="$sysconfdir"
AC_SUBST([CPDB_SYSCONFDIR])

AC_CONFIG_FILES([Makefile
                 cpdb/Makefile
                 cpdb-backend.pc
                 cpdb-frontend.pc
                 cpdb.pc])

AC_OUTPUT
