gap> G := Group( [ [ [ -1, 0, 0 ], [ 0, -1, 0 ], [ 0, 0, 1 ] ],
>               [ [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, -1 ] ], 
>               [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ],
>               [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ] ] );
<matrix group with 4 generators>

gap> Size( G );
24

gap> BravaisGroup( G );
<matrix group of size 48 with 3 generators>

gap> L := BravaisSubgroups( G );
[ Group([ [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ], 
      [ [ 0, 1, 0 ], [ 0, 0, -1 ], [ 1, 0, 0 ] ] ]), 
  Group([ [ [ -1, 0, 0 ], [ 0, -1, 0 ], [ 0, 0, -1 ] ] ]), 
  Group([ [ [ 0, -1, 0 ], [ -1, 0, 0 ], [ 0, 0, -1 ] ], 
      [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ] ]), 
  <matrix group of size 16 with 3 generators>, 
  Group([ [ [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, -1 ] ], 
      [ [ 1, 0, 0 ], [ 0, -1, 0 ], [ 0, 0, 1 ] ] ]), 
  <matrix group of size 12 with 4 generators>, 
  <matrix group of size 8 with 3 generators>, 
  <matrix group of size 8 with 3 generators> ]

gap> List( L, IsBravaisGroup );
[ true, true, true, true, true, true, true, true ]

gap> BravaisSupergroups( G );
[ Group([ [ [ 0, 1, 0 ], [ 1, 0, 0 ], [ 0, 0, 1 ] ], 
      [ [ 0, 1, 0 ], [ 0, 0, -1 ], [ 1, 0, 0 ] ] ]) ]

gap> G = NormalizerInGLnZBravaisGroup( G );
true

gap> G = Normalizer( GL(3,Integers), G );
true

gap> IsTrivial( Centralizer(GL(3,Integers), G ) );
true

gap> L := ZClassRepsQClass( G );
[ <matrix group of size 24 with 4 generators>, 
  <matrix group of size 24 with 4 generators>, 
  <matrix group of size 24 with 4 generators> ]

gap> RepresentativeAction( GL(3,Integers), L[1], L[2] );
fail

gap> G2 := G^[[1,1,0],[1,0,0],[0,0,1]];
<matrix group of size 24 with 4 generators>

gap> C := RepresentativeAction( GL(3,Integers), G, G2 );
[ [ 0, 0, 1 ], [ 1, 1, 0 ], [ 1, 0, 0 ] ]

gap> G^C = G2;
true

gap> C := CaratQClassCatalog( G, 7 );
rec( familysymb := "3", 
  group := Group([ [ [ -1, 1, -1 ], [ 0, 1, 0 ], [ 1, 0, 0 ] ], 
      [ [ -1, 1, -1 ], [ 0, 0, -1 ], [ 1, 0, 0 ] ] ]), 
  qclass := "group.24", 
  trans := [ [ 1/2, 0, 1/2 ], [ -1/2, 1/2, 0 ], [ 0, -1/2, 1/2 ] ] )

gap> G^C.trans = C.group;
true

gap> C := ConjugatorQClass( L[1], L[3] );
[ [ -1/2, 0, -1/2 ], [ 0, 1/2, 0 ], [ -1/2, -1/2, 1/2 ] ]

gap> L[1]^C = L[3];
true

gap> G := Group( [ [[0,1,0,0],[0,0,1,0],[0,0,0,1],[-1,0,0,0]],
>               [[-1,0,0,0],[0,0,0,1],[0,0,1,0],[0,1,0,0]] ] );
<matrix group with 2 generators>

gap> L := BravaisSupergroups( G );
[ <matrix group of size 16 with 2 generators>, 
  <matrix group of size 384 with 3 generators>, <matrix group of size 1152 with 
    3 generators> ]

gap> LL := List( L, ZClassRepsQClass );
[ [ <matrix group of size 16 with 2 generators> ], 
  [ <matrix group of size 384 with 3 generators>, 
      <matrix group of size 384 with 3 generators>, 
      <matrix group of size 384 with 3 generators> ], 
  [ <matrix group of size 1152 with 3 generators> ] ]

gap> N := NormalizerInGLnZBravaisGroup( G );
<matrix group with 5 generators>

gap> GeneratorsOfGroup( N );
[ [ [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ], [ -1, 0, 0, 0 ] ], 
  [ [ -1, 0, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 0 ] ], 
  [ [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ], [ -1, 0, 0, 0 ] ], 
  [ [ 1, 1, 0, -1 ], [ -1, 0, 1, 1 ], [ 0, -1, -1, -1 ], [ 1, 1, 1, 0 ] ], 
  [ [ 0, 1, -1, 1 ], [ -1, 0, 1, -1 ], [ 1, -1, 0, 1 ], [ -1, 1, -1, 0 ] ] ]

gap> Size( N );
infinity

gap> C := ConjugatorQClass( LL[2][3], LL[2][2] );
[ [ 0, 1, 1, -1 ], [ -1/2, 1/2, 0, -1/2 ], [ 1/2, 0, -1/2, 1/2 ], 
  [ 0, -1/2, -1/2, 1 ] ]

gap> LL[2][3]^C = LL[2][2];
true

gap> CaratCrystalFamilies[5];
[ "1,1,1,1,1", "1,1,1,1;1", "1,1,1;1,1", "1,1,1;1;1", "1,1;1,1;1", 
  "1,1;1;1;1", "1;1;1;1;1", "2-1',2-1';1", "2-1,2-1;1", 
  "2-1;1,1,1", "2-1;1,1;1", "2-1;1;1;1", "2-1;2-1;1", "2-1;2-2;1", 
  "2-2',2-2';1", "2-2,2-2;1", "2-2;1,1,1", "2-2;1,1;1", 
  "2-2;1;1;1", "2-2;2-2;1", "3;1,1", "3;1;1", "3;2-1", "3;2-2", 
  "4-1';1", "4-1;1", "4-2';1", "4-2;1", "4-3';1", "4-3;1", "5-1", 
  "5-2" ]

gap> BravaisGroupsCrystalFamily( "4-2;1" );
[ <matrix group of size 576 with 4 generators>, 
  <matrix group of size 144 with 7 generators>, 
  <matrix group of size 288 with 4 generators>, 
  <matrix group of size 144 with 6 generators> ]
  
gap> gens := GeneratorsOfGroup( NormalizerInGLnZ( Group( [ [ [ 1 ] ] ] ) ) );
[ [ [ -1 ] ] ]
gap> gens[1]^2;
[ [ 1 ] ]
