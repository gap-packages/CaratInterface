#############################################################################
##
#W  init.g                 Interface to Carat                   Franz G"ahler
##
#Y  Copyright (C) 1999,      Franz G"ahler,        ITAP, Stuttgart University
##

DeclareAutoPackage( "carat", "1.0", function()
  local path;
  # test for existence of a compiled binary
  path := DirectoriesPackagePrograms( "carat" );
  if Filename( path, "Z_equiv" ) = fail then
     Info( InfoWarning, 1, "Package CARAT: The binaries must be compiled" );
     return false;
  fi;
  return true;
end );

DeclarePackageAutoDocumentation( "carat", "doc" );

ReadPkg( "carat", "gap/carat.gd" );    # low level Carat interface routines

