###########################################################################
#
#  This is a wrapper makefile to build and set up CARAT for use with GAP.
#  It depends on certain variables defined in the file config.carat, which
#  in turn is produced by the companion configure script.
#
#  Usage:  ./configure <path to GAP root>
#          make
#
#  This tries to build CARAT with the same GMP library as GAP.
#
#  By default, the QCatalog of CARAT is unpacked only up to dimension 5.
#  If you need also dimension 6 (another 180 Mb), unpack also the rest with
#
#          make qcat6
#
#  The compiled binaries and libraries can be removed with 
#
#          make clean
#
#  This requires the config.carat file that has been used to build CARAT.
#
###########################################################################


# include the variables determined by the configure script
include config.carat

# build everything
ALL: carat qcatalog programs arch

# fetch carat.tgz if necessary, and unpack it
carat.tgz:
	"$(GET)" "https://wwwb.math.rwth-aachen.de/carat/carat.tgz"
carat/Makefile: carat.tgz
	tar pzxf carat.tgz
	touch $@
carat: carat/Makefile

# unpack the qcatalog, by default without dimension 6
carat/tables/qcatalog/TGROUPS.GAP: carat/Makefile
	cd carat/tables; tar pzxf qcatalog.tar.gz --exclude=qcatalog/dim6
	touch $@
qcatalog: carat/tables/qcatalog/TGROUPS.GAP

# unpack also qcatalog for dimension 6
carat/tables/qcatalog/dim6/BASIS: carat/tables/qcatalog/TGROUPS.GAP
	cd carat/tables; tar pzxf qcatalog.tar.gz qcatalog/dim6
	touch $@
qcat6: carat/tables/qcatalog/dim6/BASIS

# compile and link the CARAT binaries
programs: Makefile_CARAT config.carat carat/Makefile
	sed 's/#include <malloc.h>/\/* inclusion of malloc.h removed *\//g' < carat/include/typedef.h > typedef.tmp
	mv typedef.tmp carat/include/typedef.h
	cd carat; make -f ../Makefile_CARAT TOPDIR="$(TOPDIR)" CC="$(CC)" CFLAGS="$(FLAGS) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)"
	chmod -R a+rX .

# make a suitable link, so that GAP can find the CARAT binaries
arch: config.carat carat/Makefile
	mkdir -p bin; chmod a+rx bin
	rm -f "bin/$(ARCHDIR)"
	ln -s "../carat/bin/`carat/bin/config.guess`-`basename $(CC)`" "bin/$(ARCHDIR)"

# clean up everything
clean: config.carat
	if [ -d "bin/$(ARCHDIR)/" ]; then rm -f "bin/$(ARCHDIR)"/*; fi
	if [ -h "bin/$(ARCHDIR)"  ]; then rm "bin/$(ARCHDIR)"; fi

.PHONY: all clean arch carat qcatalog qcat6
