#############################################################################
##
#W  read.g                 Interface to Carat                   Franz G"ahler
##
#Y  Copyright (C) 1999,      Franz G"ahler,        ITAP, Stuttgart University
##

# location of Carat binaries
BindGlobal( "CARAT_BIN_DIR", DirectoriesPackagePrograms( "carat" ) );

# directory for temporary files created by interface routines
BindGlobal( "CARAT_TMP_DIR", DirectoryTemporary() );

ReadPkg( "carat", "gap/carat.gi" );    # low level Carat interface routines
ReadPkg( "carat", "gap/util.gi" );     # utility routines from CrystGap
ReadPkg( "carat", "gap/methods.gi" );  # methods for functions declared
                                       # in GAP library   

