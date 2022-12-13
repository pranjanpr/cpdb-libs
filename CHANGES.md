# CHANGES - Common Print Dialog Backends - Libraries - v2.0b1 - 2022-12-11

## CHANGES IN V2.0b1 (11th December 2022)

- Added interfaces to get human readable option and settings names
    
  Print attributes/options and their choices are usually defined in a
  machine-readable form which is more made for easy typing in a
  command line, not too long, no special characters, always in English
  and human-readable form for GUI (print dialogs), more verbose for
  easier understanding, with spaces and other special characters,
  translated, ...

  Older backends without human-readable strings can still be used. In
  such a case it is recommended that the dialog does either its own
  conversion or simply shows the machine-readable string as a last
  mean.

- Added get_media_size() function to retrieve media dimensions for a
  given "media" option value

- Support for media sizes to have multiple margin variants (like
  standard and borderless)

- Support for configurable user and system-wide default printers

- Acquire printer details asynchronously (non blocking)

- Made cpdb-libs completely CUPS-neutral

  Removed CUPS-specific functions from the frontend library functions
  and the dependency on libcups, renamed CUPS-base function and signal
  names

- Use "const" qualifiers on suitable function parameters

- DBG_LOG now includes error-message

- Renamed all API functions, data types and constants
    
  To make sure that the resources of libcpdb and libcpdb-frontend do
  not conflict with the ones of any other library used by a frontend
  or backend created with CPDB, all functions, data types, and
  constants of CPDB got renamed to be unique to CPDB.
    
  Here we follow the rules of CUPS and cups-filters (to get unique
  rules for all libraries by OpenPrinting): API functions are in
  camelCase and with "cpdb" prefix, data types all-lowercase, with '_'
  as word separator, and constants are all-uppercase, also with '_' as
  word separator, and with "CPDB_" prefix.

- Renamed and re-organized source files to make all more
  standards-conforming and naming more consistent.
    
- All headers go to /usr/include/cpdb now: Base API headers cpdb.h and
  cpdb-frontend.h, interface headers (and also part of the API)
  backend-interface.h and frontend-interface.h, and the convenience
  header files backend.h and frontend.h (include exactly the headers
  needed).
    
- Bumped soname of the libraries to 2.
    
- Check settings pointer for NULL before freeing it

- NULL check on input parameters for many functions

- Fixed incompatibility with newer versions of glib()

  glib.h cannot get included inside 'extern "C" { ... }'

- Corrected AC_INIT() in configure.ac: Bug report destination,
  directory for "make dist".

- README.md: Fixed typos and updated usage instructions

- Updated .gitignore

