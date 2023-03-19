toolsdir = $(bindir)
tools_PROGRAMS = \
	print_frontend \
	pickle_test

print_frontend_SOURCES = print_frontend.c
print_frontend_LDADD = \
	-L../cpdb/.libs \
	../cpdb/libcpdb-frontend.la \
	../cpdb/libcpdb.la \
	$(GLIB_LIBS)
print_frontend_CFLAGS = \
	-Wno-unused-result \
	-I .. \
	$(GLIB_CFLAGS)

pickle_test_SOURCES = pickle_test.c
pickle_test_LDADD = \
	-L../cpdb/.libs \
	../cpdb/libcpdb-frontend.la \
	../cpdb/libcpdb.la \
	$(GLIB_LIBS)
pickle_test_CFLAGS = \
	-I .. \
	$(GLIB_CFLAGS)

# ================================
# Tests ("make test"/"make check")
# ================================

TESTdir = .

TEST_SCRIPTS = \
        run-tests.sh

TESTS = \
        run-tests.sh

EXTRA_DIST = \
        run-tests.sh
