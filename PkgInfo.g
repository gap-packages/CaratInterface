#############################################################################
##
##  PkgInfo.g for Carat
##

SetPackageInfo( rec(

PkgName := "Carat",

Version := "1.1",

Date := "05/10/2001",

ArchiveURL := "http://www.itap.physik.uni-stuttgart.de/~gaehler/gap/Carat/carat-1.1",

ArchiveFormats := ".zoo",

Persons := [
  rec(
    LastName := "Gähler",
    FirstNames := "Franz",
    IsAuthor := true,
    IsMaintainer := true,
    Email := "gaehler@itap.physik.uni-stuttgart.de",
    WWWHome := "http://www.itap.physik.uni-stuttgart.de/~gaehler/",
    #PostalAddress := "",           
    Place := "Stuttgart",
    Institution := "ITAP, Universität Stuttgart"
  )
],

Status := "accepted",

CommunicatedBy := "Herbert Pahlings (Aachen)",

AcceptDate := "02/2000",

README_URL := "http://www.itap.physik.uni-stuttgart.de/~gaehler/gap/Carat/README.carat",
PkgInfoURL := "http://www.itap.physik.uni-stuttgart.de/~gaehler/gap/Carat/PkgInfo.g",

AbstractHTML := 
"This package provides <span class=\"pkgname\">GAP</span> interface \
routines to some of the stand-alone programs of <a \
href=\"http://wwwb.math.rwth-aachen.de/carat\">CARAT</a>, a package \
for the computation with crystallographic groups. CARAT is to a large \
extent complementary to the <span class=\"pkgname\">GAP</span> package \
<span class=\"pkgname\">Cryst</span>. In particular, it provides \
routines for the computation of normalizers and conjugators of \
finite unimodular groups in GL(n,Z), and routines for the computation \
of Bravais groups, which are all missing in <span class=\"pkgname\">Cryst\
</span>. A catalog of Bravais groups up to dimension 6 is also provided.",

PackageWWWHome := "http://www.itap.physik.uni-stuttgart.de/~gaehler/gap/packages.html",

PackageDoc  := rec(
  BookName  := "Carat",
  Archive   := "http://www.itap.physik.uni-stuttgart.de/~gaehler/gap/Carat/carat-doc-1.1.zoo",
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Interface to CARAT, a crystallographic groups package",
  AutoLoad  := true
),

Dependencies := rec(
  GAP := ">=4.2",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  ExternalConditions := []
),

AvailabilityTest := function()
  local path;
  # Carat is available only on UNIX
  if not ARCH_IS_UNIX() then
     Info( InfoWarning, 3, "Package Carat is available only on UNIX" );
     return false;
  fi;  
  # test the existence of a compiled binary; since there are
  # so many, we don't test for all of them, hoping for the best
  path := DirectoriesPackagePrograms( "carat" );
  if Filename( path, "Z_equiv" ) = fail then
     Info( InfoWarning, 3, "Package Carat: The binaries must be compiled" );
     return false;
  fi;
  return true;
end,

Autoload := true,

#TestFile := "tst/testall.g",

Keywords := [ "crystallographic groups", "finite unimodular groups", "GLnZ" ]

));

