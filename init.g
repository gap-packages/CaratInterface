#############################################################################
##
#W  init.g                 Interface to Carat                   Franz G"ahler
##
#Y  Copyright (C) 1999,      Franz G"ahler,        ITAP, Stuttgart University
##

DeclarePackage( "carat", "1.1", function()
  local path;
  # Carat is available only on UNIX
  if not ARCH_IS_UNIX() then
     return false;
  fi;  
  # test for existence of a compiled binary
  # since there are so many, we don't test for all, hoping for the best
  path := DirectoriesPackagePrograms( "carat" );
  if Filename( path, "Z_equiv" ) = fail then
     Info( InfoWarning, 1, "Package CARAT: The binaries must be compiled" );
     return false;
  fi;
  return true;
end );

DeclarePackageAutoDocumentation( "carat", "doc" );

ReadPkg( "carat", "gap/carat.gd" );    # low level Carat interface routines

