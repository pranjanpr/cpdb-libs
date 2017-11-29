EXTRA_DIST = interface

BUILT_SOURCES = backend_interface.h frontend_interface.h

lib_LTLIBRARIES	= libcpdb-libs-frontend.la libcpdb-libs-common.la

libcpdb_libs_common_la_SOURCES = backend_interface.c frontend_interface.c common_helper.c
libcpdb_libs_common_la_CPPFLAGS  = $(GLIB_CFLAGS)
libcpdb_libs_common_la_CPPFLAGS += $(GIO_CFLAGS)
libcpdb_libs_common_la_CPPFLAGS += $(GIOUNIX_CFLAGS)

libcpdb_libs_common_la_LIBADD  = $(GLIB_LIBS)
libcpdb_libs_common_la_LIBADD += $(GIO_LIBS)
libcpdb_libs_common_la_LIBADD += $(GIOUNIX_LIBS)

libcpdb_libs_frontend_la_SOURCES = frontend_helper.c
libcpdb_libs_frontend_la_CPPFLAGS  = $(GLIB_CFLAGS)
libcpdb_libs_frontend_la_CPPFLAGS += $(GIO_CFLAGS)
libcpdb_libs_frontend_la_CPPFLAGS += $(GIOUNIX_CFLAGS)

libcpdb_libs_frontend_la_LIBADD  = -lcups -lpthread -lm -lcrypt
libcpdb_libs_frontend_la_LIBADD += $(GLIB_LIBS)
libcpdb_libs_frontend_la_LIBADD += $(GIO_LIBS)
libcpdb_libs_frontend_la_LIBADD += $(GIOUNIX_LIBS)

##INSTALL HEADERS
cpd_interface_headersdir = $(includedir)/cpd-interface-headers
cpd_interface_headers_HEADERS = backend_interface.h \
                                frontend_interface.h \
                                common_helper.h \
                                frontend_helper.h 

include_HEADERS = cpdb-libs-backend.h cpdb-libs-frontend.h 

backend_interface.c backend_interface.h: interface/org.openprinting.Backend.xml
	$(AM_V_GEN)gdbus-codegen --generate-c-code backend_interface \
    --interface-prefix org.openprinting \
    interface/org.openprinting.Backend.xml 

frontend_interface.c frontend_interface.h: interface/org.openprinting.Frontend.xml
	$(AM_V_GEN)gdbus-codegen --generate-c-code frontend_interface \
    --interface-prefix org.openprinting \
    interface/org.openprinting.Frontend.xml

genfiles = *_interface.*

clean-local:
	rm -f $(genfiles)
