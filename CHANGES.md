## 2.3.11 (2026-08-19)

- fixed links in manual

## 2.3.10 (2026-08-18)

- manual converted to GAPDoc (thanks to fingolfin for converting)

## 2.3.9 (2026-05-05)

- typo in release date corrected

## 2.3.8 (2026-05-05)

- read away empty lines at the beginning of CARAT input files

## 2.3.7 (2024-10-16)

- use GMP_PREFIX if available

## 2.3.6 (2023-12-18)

- added missing CloseStream in CaratQClassCatalog
- catch CARAT failures better

## 2.3.5 (2023-04-03)

- removed C source no longer needed (use IO package instead)
- fixed a use-after-free in CARAT

## 2.3.4 (2022-07-29)

- fixed a bug in NormalizerInGLnZ

## 2.3.3 (2019-12-20)

- fixed conversion of documentation to HTML

## 2.3.2 (2019-12-10)

- fixed buffer overflow in Bravais_catalog

## 2.3.1 (2019-11-14)

- changed name to CaratInterface
- adapted to new CARAT build system (using autotools)
- further code cleanup in CARAT
- caught a case in CaratReadMultiBravaisFile

## 2.3 (2019-10-24)

- switched to GitHub version of CARAT
- code cleanup in CARAT, resulting in a vastly reduced number of
  compilation warnings
- support for a environment variable CARAT_DIR pointing to the
  CARAT base directory. Using it, one can override the location
  of CARAT at compile time
- catch the trivial 1d case in NormalizerInGLnZ

## 2.2.3 (2018-11-04)

- build system improvements - compiles now on MacOS
- automatic tests and code coverage of tests added

## 2.2.2 (2018-03-28)

- added more flexibility to build process
- builds now also on MacOS

## 2.2.1 (2018-03-06)

- wrong date corrected

## 2.2.0 (2018-02-22)

- new CARAT tarball from Aachen, includes now a GPL 3 license file
- new build system with configure & make, builds CARAT with the same
  GMP library as GAP
- bugs in ConjugatorQClass and CaratQClassCatalog fixed
- testfiles added

## 2.1.7 (2017-12-22)

- improved build instructions for gcc 5 or higher

## 2.1.6 (2016-05-23)

- updated config.guess

## 2.1.5 (2016-05-17)

- build only static version of gmplib, so that this one must be used

## 2.1.4 (2012-05-29)

- fixed file permissions

## 2.1.3 (2012-05-07)

- another small fix in PackageInfo.g

## 2.1.2 (2012-05-02)

- small fix in PackageInfo.g

## 2.1.1

- update to GAP version 4.5

## 2.1

- update to CARAT version 2.1b1

## 2.0.2

- included updated version of CARAT 2.0 with a newer version of GMP,
  which compiles also with gcc 4.1.

## 2.0.1 (2006-12-18)

- BravaisGroupsCrystalFamily stored wrong sizes in groups.

## 2.0

- switch to CARAT 2.0 (without GAP interface update)

## 1.1.3

- BravaisSubgroups and BravaisSupergroups stored wrong sizes in groups.

## 1.1.2

- File manual.toc added.

## 1.1.1 (2003-06-18)

- made CARAT_TMP_DIR work with saved workspaces

- CaratInvariantFormSpace implemented, but not yet documented

- Support for new package loading mechanism in GAP 4.4

## 1.1

- addition of an access function for the CARAT Q-class catalog;
  new function ConjugatorQClass

- switch to CARAT 1.2
