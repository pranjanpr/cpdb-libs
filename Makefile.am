EXTRA_DIST = demo/*.c demo/Makefile README.md LICENSE.md COPYING CHANGES.md autogen.sh
AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I m4
SUBDIRS = cpdb po

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = cpdb-backend.pc cpdb-frontend.pc cpdb.pc

# ================================
# Tests ("make test"/"make check")
# ================================

TESTdir = demo

TEST_SCRIPTS = \
        demo/run-tests.sh

TESTS = \
        demo/run-tests.sh

EXTRA_DIST += \
        demo/run-tests.sh
