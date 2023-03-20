# CHANGES - Common Print Dialog Backends - Libraries - v2.0b4 - 2023-03-20

## CHANGES IN V2.0b4 (20th March 2023)

 - Added test script for `make test`/`make check`
   The script tools/run-tests.sh runs the `cpdb-text-frontend` text mode
   example frontend and stops it by supplying "stop" to its standard
   input.

 - Allow changing the backend info directory via env variable
   To make it possible to test backends which are not installed into
   the system, one can now set the environment variable
   CPDB_BACKEND_INFO_DIR to the directory where the backend info file
   for the backend is, for example in its source tree.

 - Install sample frontend with `make install`
   We use the sample frontend `cpdb-text-frontend` for several tests now,
   especially "make check" and also the autopkgtests in the
   Debian/Ubuntu packages. They are also useful for backend developers
   for manual testing.

 - Renamed develping/debug tools
   As we install the development and debugging tools now, they should
   be more easily identifiable as part of CPDB. Therefore they get
   `cpdb-`-prefixed names.

 - `cpdb-text-frontend`: Use larger and more easily adjustable string
   buffers

 - Fixed segfault in the frontend library
   `cpdbResurrectPrinterFromFile()`, when called with an invalid file
   name, caused a crash.


## CHANGES IN V2.0b3 (20th February 2023)

- Added functions to fetch all printer strings translations (PR #23)
  * Added `cpdbGetAllTranslations()` to synchronously fetch all
    printer string translations
  * Added `cpdbAcquireTranslations()` to asychronously fetch them.
  * Removed `get-human-readable-option`/`choice-name` methods
  * Removed `cpdb_async_obj_t` from `cpdb-frontend.h` as that is meant
    for internal use.


## CHANGES IN V2.0b2 (13th February 2023)

- Options groups: To allow better structuring of options in print
  dialogs, common options are categorized in groups, like media, print
  quality, color, finishing, ... This can be primarily done by the
  backends but the frontend library can do fallback/default
  assignments for options not assigned by the backend.

- Many print dialogs have a "Color" option group (usually shown on one
  tab), so also have one in cpdb-libs to match with the dialogs and
  more easily map the options into the dialogs.

- Add macros for new options and choices, also add "Color" group

- Synchronous printer fetching upon backend activation (PR #21) Made
  `cpdbConnectToDbus()` wait until all backends activate

- Backends will automatically signal any printer updates instead of
  the frontend having to manually ask them (PR #21)

- Add `printer-state-changed` signal (PR #21)
  * Changed function callback type definition for printer updates
  * Added callback to frontends for changes in printer state

- Translation support: Translations of option, choice, and group names
  are now supported, not only English human-readable strings. And
  Translations can be provided by the backends (also polling them from
  the print service) and by the frontend library.

- Use autopoint instead of gettextize

- Enable reconnecting to dbus (PR #14)

- Debug logging: Now backends forward their log messages to the
  frontend library for easier debugging.

- Use <glib/gi18n.h> instead of redefining macros (Issue #20)

- Add functions to free objects (PR #15)

- Remove hardcoded paths and follow XDG base dir specs (PR #14)

- Added javadoc comments to function declarations (PR #21)

- Build system: Let "make dist" also create .tar.bz2 and .tar.xz

- Add the dependency on libdbus to README.md
  libdbus-1-dev is needed to configure pkg-config variables for
  backends

- COPYING: Added Priydarshi Singh


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

