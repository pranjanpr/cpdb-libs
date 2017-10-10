# Frontend and Backend Libraries for Common Print Dialog

This repository hosts the code for frontend and backend libraries for the common printing dialog (CPD) project. These libraries allow the CPD frontend and backends to communicate with each other over the D-Bus.
The Frontend library also provides some extra functionality to deal with Printers, Settings, etc. in a high level manner.

## Background

The [Common Printing Dialog](https://wiki.ubuntu.com/CommonPrintingDialog) project aims to provide a uniform, GUI toolkit independent printing experience on Linux Desktop Environments.


## Dependencies

 - [CUPS](https://github.com/apple/cups/releases) : Version >= 2.2 
 
 Installing bleeding edge release from [here](https://github.com/apple/cups/releases). (Preferable!)
 
 OR

`sudo apt install cups libcups2-dev`

 - GLIB 2.0 :
`sudo apt install libglib2.0-dev`

 
## Build and installation


    $ ./autogen
    $ ./configure
    $ make
    $ sudo make install
    $ sudo ldconfig


Use the sample frontend client to check that the library and the installed backends work as expected:

## Testing the library

The project also includes a sample command line frontend (using the `cpdb-libs-frontend` API) that you can use to test whether the installed libraries and print backends work as expected.

    $ cd demo/
    $ make
    $ ./print_frontend

The list of printers from various printers should start appearing automatically. Type `help` to get the list of available commands. Make sure to stop the frontend using the `stop` command only.

The library also provides support for serializing a printer. Use the `pickle-printer` command to serialize it, and run the `pickle_test` executable after that to deserialize and test it.
    

## Using the libraries for devloping print backends and dialogs.

To develop a frontend client(Eg. a print dialog), use the `cpdb-libs-frontend` library.

pkg-config support: `pkg-config --cflags --libs cpdb-libs-frontend`.
Header file :  `cpdb-libs-frontend.h` 

Similarly, to develop a print backend, you need to use the `cpdb-libs-backend` library.
pkg-config support: `pkg-config --cflags --libs cpdb-libs-backend`.
Header file: `cpdb-libs-backend.h` in your code.