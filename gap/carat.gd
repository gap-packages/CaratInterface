#############################################################################
##
#W  carat.gd               Interface to Carat                   Franz G"ahler
##
#Y  Copyright (C) 1999,      Franz G"ahler,        ITAP, Stuttgart University
##
##  Input/Output routines for interfacing with Carat data files
##

#############################################################################
##
#F  CaratTmpFile( name ) . . . . . returns file 'name' in Carat tmp directory
##
DeclareGlobalFunction( "CaratTmpFile" );

#############################################################################
##
#F  CaratReadMatrixFile( filename )  . . . . . . . . . read Carat matrix file
##
DeclareGlobalFunction( "CaratReadMatrixFile" );

#############################################################################
##
##  A bravais record is a record with components
##
##  generators:   generators of the group
##  formspace:    basis of space of invariant forms (optional)
##  centerings:   basis of centering matrices (optional)
##  normalizer:   additional generators of normalizer in GL(n,Z) (optional)
##  centralizer:  additional generators of centralizer in GL(n,Z) (optional)
##  size:         size of the group
##

#############################################################################
##
#F  CaratReadBravaisFile( filename )  . . . . . . . . read Carat Bravais file
##
DeclareGlobalFunction( "CaratReadBravaisFile" );

#############################################################################
##
#F  CaratWriteMatrixFile( filename, data )  . write Carat matrix data to file
##
DeclareGlobalFunction( "CaratWriteMatrixFile" );

#############################################################################
##
#F  CaratWriteBravaisFile( filename, data )  write Carat Bravais rec. to file
##
DeclareGlobalFunction( "CaratWriteBravaisFile" );

#############################################################################
##
#F  CaratReadQtoZFile( filename ) . . . . . . . . read Carat QtoZ output file
##
DeclareGlobalFunction( "CaratReadQtoZFile" );

#############################################################################
##
#F  CaratReadBravaisInclusionsFile( filename ) . read Carat Bravais_incl file
##
DeclareGlobalFunction( "CaratReadBravaisInclusionsFile" );

#############################################################################
##
#F  CaratShowFile( filename )  . . . . . . . . . display contents of filename
##
DeclareGlobalFunction( "CaratShowFile" );

#############################################################################
##
#F  CaratCommand( cmd, args, outfile )  exec cmd with args, output to outfile
##
DeclareGlobalFunction( "CaratCommand" );

#############################################################################
##
#F  CaratHelp( command )  . . . . . . . display online help for Carat command
##
DeclareGlobalFunction( "CaratHelp" );





