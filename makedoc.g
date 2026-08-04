#############################################################################
##
##  makedoc.g
##
##  Builds the package documentation with AutoDoc/GAPDoc.
##
#############################################################################

LoadPackage("AutoDoc");

# Run this from the package's root directory: gap makedoc.g
AutoDoc(rec(
    autodoc := rec(scan_dirs := []),
    gapdoc := rec(main := "main", files := []),
    extract_examples := true,
    scaffold := rec(
        includes := [
            "introduction.xml",
            "installation.xml",
            "carat.xml"
        ],
        entities := rec(
            CARAT := "<Package>CARAT</Package>",
            CaratInterface := "<Package>CaratInterface</Package>",
            Cryst := "<Package>Cryst</Package>",
        ),
        bib := "manual.bib",
    ),
));

QuitGap();
