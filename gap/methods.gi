#############################################################################
##
#W  methods.gi             Interface to Carat                   Franz G"ahler
##
#Y  Copyright (C) 1999,      Franz G"ahler,        ITAP, Stuttgart University
##
##  Methods for high level functions using Carat
##

#############################################################################
##
#M  BravaisGroup( grp )  . . . . . . . . . . . . . . . . Bravais group of grp
##
InstallMethod( BravaisGroup, 
    "with Carat function Bravais_grp",
    true, [ IsCyclotomicMatrixGroup ], 0,
function( grp )

    local grpfile, resfile, gen, data, res;

    # group must be integer and finite
    if not IsIntegerMatrixGroup( grp ) then
        Error( "grp must be an integer matrix group" );
    fi;
    if not IsFinite( grp ) then
        Error( "grp must be finite" );
    fi;

    # get temporary file names
    grpfile := CaratTmpFile( "grp" );  
    resfile := CaratTmpFile( "res" );

    # write Carat input to temporary file
    gen := GeneratorsOfGroup( grp );
    if gen = [] then
        gen := [ One(grp) ];
    fi;
    data := rec( generators := gen, size := Size( grp ) );
    CaratWriteBravaisFile( grpfile, data );

    # execute Carat program
    CaratCommand( "Bravais_grp", grpfile, resfile );

    # read back result, and remove temporary files
    data := CaratReadBravaisFile( resfile );
    RemoveFile( grpfile );
    RemoveFile( resfile );

    # convert result to appropriate format
    res := GroupByGenerators( data.generators, One( grp ) );
    if IsBound( data.size ) then
        SetSize( res, data.size );
    fi;
    return res;

end );


#############################################################################
##
#F  CaratBravaisInclusions( grp, opt ) . . . . .Bravais inclusions (internal)
##
CaratBravaisInclusions := function( grp, opt )

    local grpfile, resfile, gen, data, args, output, grps, str, res, g;

    # get temporary file names
    grpfile := CaratTmpFile( "grp" );  
    resfile := CaratTmpFile( "res" );

    # write Carat input to file
    gen := GeneratorsOfGroup( grp );
    if gen = [] then
        gen := [ One(grp) ];
    fi;
    data := rec( generators := gen, size := Size( grp ) );
    CaratWriteBravaisFile( grpfile, data );

    # execute Carat program
    args := Concatenation( grpfile, " -G", opt );
    CaratCommand( "Bravais_inclusions", args, resfile );

    # read Carat result from file, and remove temporary files
    data := CaratReadMultiBravaisFile( resfile );
    grps := data.groups;
    RemoveFile( grpfile );
    RemoveFile( resfile );

    # convert result into desired format
    res := List( grps, x -> GroupByGenerators( x.generators, One(grp) ) );
    for g in res do
        SetSize( g, grps[1].size );
    od;

    return res;

end;


#############################################################################
##
#M  BravaisSubgroups( grp ) . . . . Bravais subgroups of Bravais group of grp
##
InstallMethod( BravaisSubgroups, 
    "with Carat function Bravais_inclusions",
    true, [ IsCyclotomicMatrixGroup ], 0,
function( grp )
    if DimensionOfMatrixGroup( grp ) > 6 then
        Error( "sorry, only groups of dimension up to 6 are supported" );
    fi;
    return CaratBravaisInclusions( BravaisGroup( grp ), "" );
end );


#############################################################################
##
#M  BravaisSupergroups( grp ) . . Bravais supergroups of Bravais group of grp
##
InstallMethod( BravaisSupergroups, 
    "with Carat function Bravais_inclusions",
    true, [ IsCyclotomicMatrixGroup ], 0,
function( grp )
    if DimensionOfMatrixGroup( grp ) > 6 then
        Error( "sorry, only groups of dimension up to 6 are supported" );
    fi;
    return CaratBravaisInclusions( BravaisGroup( grp ), " -S" );
end );


#############################################################################
##
#F  CaratNormalizerInGLnZFunc( G, opt ) . . . . .  normalizer of G in GL(n,Z)
##
CaratNormalizerInGLnZFunc := function( grp, opt )

    local grpfile, resfile, gen, data, output, res, args;

    # group must be integer and finite
    if not IsIntegerMatrixGroup( grp ) then
        Error( "grp must be an integer matrix group" );
    fi;
    if not IsFinite( grp ) then
        Error( "grp must be finite" );
    fi;

    # get temporary files
    grpfile := CaratTmpFile( "grp" );  
    resfile := CaratTmpFile( "res" );

    # write input data
    gen := GeneratorsOfGroup(grp);
    if gen = [] then
        gen := [ One(grp) ];
    fi;
    data := rec( generators := gen, size := Size( grp ) );
    CaratWriteBravaisFile( grpfile, data );

    # execute Carat command
    args    := Concatenation( grpfile, opt );
    CaratCommand( "Normalizer", args, resfile );

    # read back the data
    data := CaratReadBravaisFile( resfile );
    RemoveFile( grpfile );
    RemoveFile( resfile );

    # construct result
    gen := Concatenation( data.generators, data.normalizer );
    res := GroupByGenerators( gen, One( grp ) );

    return res;

end;


#############################################################################
##
#M  NormalizerInGLnZ( G ) . . . Normalizer of integer matrix group in GL(n,Z)
##
InstallMethod( NormalizerInGLnZ, "with Carat function Normalizer",
    true, [ IsCyclotomicMatrixGroup ], 0, 
    G -> CaratNormalizerInGLnZFunc( G, "" ) );

InstallMethod( NormalizerInGLnZ, "with Carat function Normalizer",
    true, [ IsCyclotomicMatrixGroup and IsBravaisGroup ], 0, 
    NormalizerInGLnZBravaisGroup );

InstallMethod( NormalizerInGLnZ, "via Bravais group", 
    true, [ IsCyclotomicMatrixGroup and HasBravaisGroup ], 0,
    G -> Normalizer( NormalizerInGLnZ( BravaisGroup( G ) ), G ) );



#############################################################################
##
#M  NormalizerInGLnZBravaisGroup( G )  norm. of Bravais group of G in GL(n,Z)
##
InstallMethod( NormalizerInGLnZBravaisGroup, 
    "with Carat function Normalizer",
    true, [ IsCyclotomicMatrixGroup ], 0, 
function(G)
    local N;
    N := CaratNormalizerInGLnZFunc( G, " -b" );
    if HasBravaisGroup( G ) then
        SetNormalizerInGLnZ( BravaisGroup( G ), N );
    fi;
    return N;
end );


#############################################################################
##
#M  CentralizerInGLnZ( G ) . . . . . . . . . . . . . . Centralizer in GL(n,Z)
##
InstallMethod( CentralizerInGLnZ, "via NormalizerInGLnZ", 
    true, [ IsCyclotomicMatrixGroup ], 0,
function( G )
    local N;
    if HasBravaisGroup( G ) and not HasNormalizerInGLnZ( G ) then
        N := NormalizerInGLnZ( BravaisGroup( G ) );
    else
        N := NormalizerInGLnZ( G );
    fi;
    return Centralizer( N, G );
end );


#############################################################################
##
#M  RepresentativeAction( GL( n, Integers), G1, G2 )  . . . . . . . . . . . . 
#M                                   returns m in GL(n,Z) with m*G1*m^-1 = G2
##
InstallOtherMethod( RepresentativeActionOp, 
    "with Carat function Z_equiv", true, 
    [ IsNaturalGLnZ, IsCyclotomicMatrixGroup, IsCyclotomicMatrixGroup,
      IsFunction ], 0,

function( glnz, grp1, grp2, opr )

    local grp1file, grp2file, resfile, args, gen, data, input, line, res;

    # groups must be integer
    if not IsIntegerMatrixGroup( grp1 ) then
        Error( "grp1 must be an integer matrix group" );
    fi;
    if not IsIntegerMatrixGroup( grp2 ) then
        Error( "grp2 must be an integer matrix group" );
    fi;

    # groups must be finite
    if not IsFinite( grp1 ) then
        Error( "grp1 must be finite" );
    fi;
    if not IsFinite( grp2 ) then
        Error( "grp2 must be finite" );
    fi;

    # catch the trivial case
    if grp1 = grp2 then
        return IdentityMat( DimensionOfMatrixGroup( grp1 ) );
    fi;

    # get temporary file names
    grp1file := CaratTmpFile( "grp1" );  
    grp2file := CaratTmpFile( "grp2" );
    resfile  := CaratTmpFile( "res"  );

    # write Carat input to temporary files
    gen := GeneratorsOfGroup( grp1 );
    if gen = [] then
        gen := [ One(grp1) ];
    fi;
    data := rec( generators := gen, size := Size(grp1) );
    CaratWriteBravaisFile( grp1file, data );

    gen := GeneratorsOfGroup( grp2 );
    if gen = [] then
        gen := [ One(grp2) ];
    fi;
    data := rec( generators := gen, size := Size(grp2) );
    CaratWriteBravaisFile( grp2file, data );

    # execute Carat program
    args := Concatenation( grp2file, " ", grp1file );
    CaratCommand( "Z_equiv", args, resfile );

    # read back the result
    input := InputTextFile( resfile );
    line := CaratReadLine( input );
    if line = "the groups are not conjugated in GL_n(Z)\n" then
        res := fail;
    else
        res := CaratReadMatrix( input, line );        
    fi;
    CloseStream( input );

    # remove temporary files
    RemoveFile( grp1file );
    RemoveFile( grp2file );
    RemoveFile( resfile );

    return res;

end );


#############################################################################
##
#M  ZClassRepsQClass( grp )  . . . . . . . . . Z-class reps in Q-class of grp
##
InstallMethod( ZClassRepsQClass, 
    "with Carat function QtoZ",
    true, [ IsCyclotomicMatrixGroup ], 0,
function( grp )

    local grpfile, resfile, gen, data, output, str, res, g;

    # group must be rational and finite
    if not IsRationalMatrixGroup( grp ) then
        Error( "grp must be a rational matrix group" );
    fi;
    if not IsFinite( grp ) then
        Error( "grp must be finite" );
    fi;

    # get temporary file names
    grpfile := CaratTmpFile( "grp" );  
    resfile := CaratTmpFile( "res" );

    # write Carat input to file
    gen := GeneratorsOfGroup( grp );
    if gen = [] then
        gen := [ One(grp) ];
    fi;
    data := rec( generators := gen, size := Size(grp) );
    CaratWriteBravaisFile( grpfile, data );

    # execute Carat program
    CaratCommand( "QtoZ", grpfile, resfile );

    # read Carat result from file, and remove temporary files
    data := CaratReadMultiBravaisFile( resfile );
    RemoveFile( grpfile );
    RemoveFile( resfile );

    # convert result into desired format
    res := List( data.groups, x -> GroupByGenerators( x.generators ) );
    for g in res do
        SetSize( g, data.groups[1].size );
    od;

    return res;

end ); 


#############################################################################
##
#M  CaratCrystalFamilies . . . . . . . . . . .crystal family symbols in Carat
##
InstallValue( CaratCrystalFamilies, [ 
[ "1" ], 
[ "1,1", "1;1", "2-1", "2-2"],
[ "1,1,1", "1,1;1", "1;1;1", "2-1;1", "2-2;1", "3" ],
[ "1,1,1,1", "1,1,1;1", "1,1;1,1", "1,1;1;1", "1;1;1;1", "2-1',2-1'",
  "2-1,2-1", "2-1;1,1", "2-1;1;1", "2-1;2-1", "2-1;2-2", "2-2',2-2'",
  "2-2,2-2", "2-2;1,1", "2-2;1;1", "2-2;2-2", "3;1", "4-1", "4-1'",
  "4-2", "4-2'", "4-3", "4-3'" ],
[ "1,1,1,1,1", "1,1,1,1;1", "1,1,1;1,1", "1,1,1;1;1", "1,1;1,1;1",
  "1,1;1;1;1", "1;1;1;1;1", "2-1',2-1';1", "2-1,2-1;1", "2-1;1,1,1",
  "2-1;1,1;1", "2-1;1;1;1", "2-1;2-1;1", "2-1;2-2;1", "2-2',2-2';1",
  "2-2,2-2;1", "2-2;1,1,1", "2-2;1,1;1", "2-2;1;1;1", "2-2;2-2;1",
  "3;1,1", "3;1;1", "3;2-1", "3;2-2", "4-1';1", "4-1;1", "4-2';1",
  "4-2;1", "4-3';1", "4-3;1", "5-1", "5-2" ],
[ "1,1,1,1,1,1", "1,1,1,1,1;1", "1,1,1,1;1,1", "1,1,1,1;1;1", "1,1,1;1,1,1",
  "1,1,1;1,1;1", "1,1,1;1;1;1", "1,1;1,1;1,1", "1,1;1,1;1;1", "1,1;1;1;1;1",
  "1;1;1;1;1;1", "2-1',2-1',2-1'", "2-1',2-1';1,1", "2-1',2-1';1;1",
  "2-1',2-1';2-1", "2-1',2-1';2-2", "2-1,2-1,2-1", "2-1,2-1;1,1",
  "2-1,2-1;1;1", "2-1,2-1;2-1", "2-1,2-1;2-2", "2-1;1,1,1,1", "2-1;1,1,1;1",
  "2-1;1,1;1,1", "2-1;1,1;1;1", "2-1;1;1;1;1", "2-1;2-1;1,1", "2-1;2-1;1;1",
  "2-1;2-1;2-1", "2-1;2-1;2-2", "2-1;2-2',2-2'", "2-1;2-2,2-2", 
  "2-1;2-2;1,1", "2-1;2-2;1;1", "2-1;2-2;2-2", "2-2',2-2',2-2'",
  "2-2',2-2';1,1", "2-2',2-2';1;1", "2-2',2-2';2-2", "2-2,2-2,2-2",
  "2-2,2-2;1,1", "2-2,2-2;1;1", "2-2,2-2;2-2", "2-2;1,1,1,1", 
  "2-2;1,1,1;1", "2-2;1,1;1,1", "2-2;1,1;1;1", "2-2;1;1;1;1",
  "2-2;2-2;1,1", "2-2;2-2;1;1", "2-2;2-2;2-2", "3,3", "3;1,1,1", "3;1,1;1",
  "3;1;1;1", "3;2-1;1", "3;2-2;1", "3;3", "4-1';1,1", "4-1';1;1", "4-1';2-1",
  "4-1';2-2", "4-1;1,1", "4-1;1;1", "4-1;2-1", "4-1;2-2", "4-2';1,1", 
  "4-2';1;1", "4-2';2-1", "4-2';2-2", "4-2;1,1", "4-2;1;1", "4-2;2-1",
  "4-2;2-2", "4-3';1,1", "4-3';1;1", "4-3';2-1", "4-3';2-2", "4-3;1,1", 
  "4-3;1;1", "4-3;2-1", "4-3;2-2", "5-1;1", "5-2;1", "6-1", "6-2", "6-2'",
  "6-3", "6-3'", "6-4", "6-4'" ]
] );


#############################################################################
##
#M  CaratCrystalFamiliesFlat . . flat list of crystal family symbols in Carat
##
InstallValue( CaratCrystalFamiliesFlat, Flat( CaratCrystalFamilies ) ); 


#############################################################################
##
#M  BravaisGroupsCrystalFamily( symb ) . . . Bravais groups in crystal family
##
InstallGlobalFunction( BravaisGroupsCrystalFamily, function( symb )

    local resfile, outfile, input, command, program, output, 
          err, data, str, res, g;

    if not symb in CaratCrystalFamiliesFlat then
        Error("invalid crystal family symbol - please consult Carat manual");
    fi;

    # get temporary file name
    resfile := CaratTmpFile( "res" );
    outfile := CaratTmpFile( "out" );

    input := InputTextString( Concatenation( symb, "\ny\n", resfile, "\na\n"));

    # find executable
    command := "Bravais_catalog";
    program := Filename( CARAT_BIN_DIR, command );    
    if program = fail then
        Error( Concatenation( "Carat program ", command, " not found." ) );
    fi;

    # execute command
    output := OutputTextFile( outfile, false );
    err    := Process( DirectoryCurrent(), program, input, output, [ ] );
    CloseStream( output );

    # did it work?
    if err = 2  then                   # we used wrong arguments
        CaratShowFile( resfile );      # contains usage advice
    fi;
    if err < 0  then
        Error( Concatenation( "Carat program ", command,
                              " failed with error code ", String(err) ) );
    fi;

    # read Carat result from file, and remove temporary file
    data := CaratReadMultiBravaisFile( resfile );
    RemoveFile( resfile );

    # convert result into desired format
    res := List( data.groups, x -> GroupByGenerators( x.generators ) );
    for g in res do
        SetSize( g, data.groups[1].size );
    od;

    return res;

end ); 

