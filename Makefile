SHELL = bash
PROJNM = lsproc
AND32GXX = arm-linux-gnueabihf-g++
AND64GXX = aarch64-linux-gnu-g++

SRCDIR = src
INCDIR = $(SRCDIR)/include
LIBDIR = $(SRCDIR)/lib
DBGDIR = debug
DBGDYNDIR = $(DBGDIR)/dynamic
DBGSTCDIR = $(DBGDIR)/static
RELDIR = release
RELDYNDIR = $(RELDIR)/dynamic
RELSTCDIR = $(RELDIR)/static
TSTDIR = test
TSTDYNDIR = $(TSTDIR)/dynamic
TSTSTCDIR = $(TSTDIR)/static
ANDDIR = android
ANDDYNDIR = $(ANDDIR)/dynamic
ANDDYNDIR32 = $(ANDDYNDIR)/32
ANDDYNDIR64 = $(ANDDYNDIR)/64
ANDSTCDIR = $(ANDDIR)/static
ANDSTCDIR32 = $(ANDSTCDIR)/32
ANDSTCDIR64 = $(ANDSTCDIR)/64

MAINNM = main
MAINEX = cpp
MAINFL = $(MAINNM).$(MAINEX)

SRCFLS = $(wildcard $(SRCDIR)/*.cpp)
OBJSRC = $(wildcard $(INCDIR)/*.cpp)
OBJOBJ = $(subst include,lib,$(patsubst %.cpp,%.o,$(OBJSRC)))
DBGDYN = $(DBGDYNDIR)/$(PROJNM)
DBGSTC = $(DBGSTCDIR)/$(PROJNM)
TGTDYN = $(RELDYNDIR)/$(PROJNM)
TGTSTC = $(RELSTCDIR)/$(PROJNM)
TSTDYN = $(TSTDYNDIR)/$(PROJNM)
TSTSTC = $(TSTSTCDIR)/$(PROJNM)
ANDDYN32 = $(ANDDYNDIR32)/$(PROJNM)
ANDDYN64 = $(ANDDYNDIR64)/$(PROJNM)
ANDSTC32 = $(ANDSTCDIR32)/$(PROJNM)
ANDSTC64 = $(ANDSTCDIR64)/$(PROJNM)

TSTEXE = $(TSTDYN) # or $(TSTSTC)
TSTARG = # --help # $(TSTEXE)

# GTKINC = $(shell pkg-config gtkmm-3.0 --cflags)
# GTKLIB = $(shell pkg-config gtkmm-3.0 --libs)

LDFLAG = -I$(INCDIR) -O3 -std=c++17
ANDFLG = $(LDFLAG) -march=armv8.5-a
LDLIBS = -L$(LIBDIR) -l$(PROJNM)

DBGFLG = -ggdb -Wall -Wextra -std=c++17

SNFLGS = 	-fsanitize=undefined \
			   	-fno-sanitize-recover=all -fsanitize=float-divide-by-zero \
				 	-fsanitize=float-cast-overflow -fno-sanitize=null \
				 	-fno-sanitize=alignment -std=c++17

SNFLGD = $(SNFLGS) -fsanitize=address

STFLAG = -static -static-libgcc -static-libstdc++

all: releasedynamicall

releasedynamicall: buildincdir buildlibdir buildreldyndir buildlibs cleanreleasedynamic
	@echo Building dynamic executable
	$(CXX) $(GTKINC) $(LDFLAG) $(SRCFLS) -o $(TGTDYN) $(LDLIBS) $(GTKLIB)

releasedynamic: cleanreleasedynamic builddirectories
	@echo Building dynamic executable
	$(CXX) $(GTKINC) $(LDFLAG) $(SRCFLS) -o $(TGTDYN) $(LDLIBS) $(GTKLIB)

releasestaticall: cleanreleasestatic builddirectories
	@echo Building static executable
	$(CXX) $(GTKINC) $(STFLAG) $(LDFLAG) $(SRCFLS) -o $(TGTSTC) $(LDLIBS) $(GTKLIB)

releasestatic: cleanreleasestatic builddirectories
	@echo Building static executable
	$(CXX) $(GTKINC) $(STFLAG) $(LDFLAG) $(SRCFLS) -o $(TGTSTC) $(LDLIBS) $(GTKLIB)

androidall: androidstaticall androiddynamicall

androidstaticall:	android32staticall android64staticall

android32staticall: cleanandroid32static builddirectories
	@echo Building static Android 32 bit executable
	$(AND32GXX) -static $(ANDFLG) $(SRCFLS) -o $(ANDSTC32)

android32static: cleanandroid32static builddirectories
	@echo Building static Android 32 bit executable
	$(AND32GXX) -static $(ANDFLG) $(SRCFLS) -o $(ANDSTC32)

android64staticall: cleanandroid64static builddirectories
	@echo Building static Android 64 bit executable
	$(AND64GXX) -static $(ANDFLG) $(SRCFLS) -o $(ANDSTC64)

android64static: cleanandroid64static builddirectories
	@echo Building static Android 64 bit executable
	$(AND64GXX) -static $(ANDFLG) $(SRCFLS) -o $(ANDSTC64)

androiddynamicall:	android32dynamicall android64dynamicall

android32dynamicall: cleanandroid32dynamic builddirectories
	@echo Building Android 32 bit executable
	$(AND32GXX) $(ANDFLG) $(SRCFLS) -o $(ANDDYN32)

android32dynamic: cleanandroid32dynamic builddirectories
	@echo Building Android 32 bit executable
	$(AND32GXX) $(ANDFLG) $(SRCFLS) -o $(ANDDYN32)

android64dynamicall: cleanandroid64dynamic builddirectories
	@echo Building Android 64 bit executable
	$(AND64GXX) $(ANDFLG) $(SRCFLS) -o $(ANDDYN64)

android64dynamic: cleanandroid64dynamic builddirectories
	@echo Building Android 64 bit executable
	$(AND64GXX) $(ANDFLG) $(SRCFLS) -o $(ANDDYN64)

debugdynamicall: buildincdir buildlibdir builddbgdyndir buildlibs cleandebugdynamic
	@echo Building debug executable
	$(CXX) $(GTKINC) -I$(INCDIR) -std=c++17 $(DBGFLG) $(SRCFLS) -o $(DBGDYN) $(LDLIBS) $(GTKLIB)

debugdynamic: cleandebugdynamic builddirectories
	@echo Building debug executable
	$(CXX) $(GTKINC) -I$(INCDIR) $(DBGFLG) $(SRCFLS) -o $(DBGDYN) $(LDLIBS) $(GTKLIB)

debugstaticall: cleandebugstatic builddirectories buildlibs
	@echo Building debug executable
	$(CXX) $(STFLAG) $(GTKINC) -I$(INCDIR) -std=c++17 $(DBGFLG) $(SRCFLS) -o $(DBGSTC) $(LDLIBS) $(GTKLIB)

debugstatic: cleandebugstatic builddirectories
	@echo Building debug executable
	$(CXX) $(STFLAG) $(GTKINC) -I$(INCDIR) $(DBGFLG) $(SRCFLS) -o $(DBGSTC) $(GTKLIB) $(LDLIBS) $(GTKLIB)

debugbuilds: debugdynamic debugstatic

releasebuilds: releasedynamic releasestatic

allbuilds: debugbuilds releasebuilds

.PHONY: test

test:
	@echo Running test of $(TSTEXE)
	./$(TSTEXE) $(TSTARG)

# buildlibs:
buildlibs: buildallobjects buildarchive

buildallobjects: cleanobjects
	@echo Building object files from $(INCDIR) to $(LIBDIR)
	$(shell IFS=$(echo -en "\n\b") array=( $(OBJSRC) );\
		for file in "$${array[@]}";do \
			lib=$${file//include/lib}; \
			lib=$${lib//.cpp/.o}; \
			$(CXX) $(GTKINC) $(LDFLAG) -c $${file} -o $${lib} $(GTKLIB); \
			strip $${lib} \
		done \
	)
# $(CXX) $(GTKINC) $(LDFLAG) -c $${file} -o $${lib} $(LDLIBS) $(GTKLIB); \

buildarchive: cleanarchive
	@echo Building object archive
	ar rcs $(LIBDIR)/lib$(PROJNM).a $(OBJOBJ)

builddirectories:
	@echo Building project directories
	$(shell \
	mkdir -p $(INCDIR) $(LIBDIR) \
	$(DBGDIR) $(TSTDIR) $(RELDIR) \
	$(DBGDYNDIR) $(DBGSTCDIR) \
	$(RELDYNDIR) $(RELSTCDIR) \
	$(TSTDYNDIR) $(TSTSTCDIR) \
	$(ANDDIR) $(ANDDYNDIR) \
	$(ANDDYNDIR32) $(ANDDYNDIR64) \
	$(ANDSTCDIR) $(ANDSTCDIR32) \
	$(ANDSTCDIR64) \
	)

buildalldirs: buildincdir buildlibdir builddebdir builddebdir buildreldir builddbgdyndir builddbgstcdir buildreldyndir buildrelstcdir buildtstdyndir buildtststcdir buildanddir buildanddyndir buildanddyn32dir buildanddyn64dir buildandstcdir buildandstc32dir buildandstc64dir
	@echo Building project directories

buildincdir:
	@echo Building include directory
	mkdir -p $(INCDIR)

buildlibdir:
	@echo Building lib directory
	mkdir -p $(LIBDIR)

builddebdir:
	@echo Building debug directory
	mkdir -p $(DBGDIR)

buildtstdir:
	@echo Building test directory
	mkdir -p $(TSTDIR)

buildreldir:
	@echo Building release directories
	mkdir -p $(RELDIR)

builddbgdyndir:
	@echo Building debug dynamic directory
	mkdir -p $(DBGDYNDIR)

builddbgstcdir:
	@echo Building include directory
	mkdir -p $(DBGSTCDIR)

buildreldyndir:
	@echo Building release dynamic directory
	mkdir -p $(RELDYNDIR)

buildrelstcdir:
	@echo Building release static directory
	mkdir -p $(RELSTCDIR)

buildtstdyndir:
	@echo Building test dynamic directory
	mkdir -p $(TSTDYNDIR)

buildtststcdir:
	@echo Building test static directory
	mkdir -p $(TSTSTCDIR)

buildanddir:
	@echo Building android directories
	mkdir -p $(ANDDIR)

buildanddyndir:
	@echo Building android dynamic directories
	mkdir -p $(ANDDYNDIR)

buildanddyn32dir:
	@echo Building android dynamic 32 directory
	mkdir -p $(ANDDYNDIR32)

buildanddyn64dir:
	@echo Building android dynamic 64 directory
	mkdir -p $(ANDDYNDIR64)

buildandstcdir:
	@echo Building android static directories
	mkdir -p $(ANDSTCDIR)

buildandstc32dir:
	@echo Building android static 32 directory
	mkdir -p $(ANDSTCDIR32)

buildandstc64dir:
	@echo Building android static 64 directory
	mkdir -p $(ANDSTCDIR64)

cleandirectories:
	@echo Cleaning project directories
	$(shell \
	rm -rf $(DBGDYNDIR) $(DBGSTCDIR) \
	$(RELDYNDIR) $(RELSTCDIR) \
	$(TSTDYNDIR) $(TSTSTCDIR) \
	$(ANDDIR) $(ANDDYNDIR) \
	$(ANDDYNDIR32) $(ANDDYNDIR64) \
	$(ANDSTCDIR) $(ANDSTCDIR32) \
	$(ANDSTCDIR64) \
	$(DBGDIR) $(TSTDIR) $(RELDIR) $(ANDDIR) \
	)

clean: cleandirectories cleanrelease cleandebug cleantest cleanobjects cleanarchive cleanandroid

cleanrelease: cleanreleasedynamic cleanreleasestatic

cleanreleasedynamic:
	@echo Cleaning dynamic release
	rm -f $(TGTDYN)

cleanreleasestatic:
	@echo Cleaning static release
	rm -f $(TGTSTC)

cleanandroid: cleanandroid32static cleanandroid64static cleanandroid32dynamic cleanandroid64dynamic

cleanandroid32static:
	@echo Cleaning static Android 32 bit release
	rm -f $(ANDSTC32)

cleanandroid64static:
	@echo Cleaning static Android 64 bit release
	rm -f $(ANDSTC64)

cleanandroid32dynamic:
	@echo Cleaning dynamic Android 32 bit release
	rm -f $(ANDDYN32)

cleanandroid64dynamic:
	@echo Cleaning dynamic Android 64 bit release
	rm -f $(ANDDYN64)

cleandebug: cleandebugdynamic cleandebugstatic

cleandebugdynamic:
	@echo Cleaning dynamic debug
	rm -f $(DBGDYN)

cleandebugstatic:
	@echo Cleaning static debug
	rm -f $(DBGSTC)

cleantest: cleantestdynamic cleanteststatic

cleantestdynamic:
	@echo Cleaning dynamic test
	rm -f $(TSTDYN)

cleanteststatic:
	@echo Cleaning static test
	rm -f $(TSTSTC)

cleanobjects:
	@echo Cleaning objects
	rm -f $(LIBDIR)/*.o

cleanarchive:
	@echo Cleaning archive
	rm -f $(LIBDIR)/*.a

install: installdynamic

installdynamic:
	@echo Installing $(PROJNM)
	cp -f $(TGTDYN) /usr/bin/$(PROJNM)

installstatic:
	@echo Installing $(PROJNM)
	cp -f $(TGTSTC) /usr/bin/$(PROJNM)