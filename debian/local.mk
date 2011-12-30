############################ -*- Mode: Makefile -*- ###########################
## local.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:42:10 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Wed Sep  6 12:35:37 2006
## Last Machine Used: glaurung.internal.golden-gryphon.com
## Update Count     : 11
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: b07b1015-30ba-4b46-915f-78c776a808f4
## 
###############################################################################

testdir:
	$(testdir)


debian/stamp/BUILD/checkpolicy: debian/stamp/build/checkpolicy
debian/stamp/INST/checkpolicy:  debian/stamp/install/checkpolicy
debian/stamp/BIN/checkpolicy:   debian/stamp/binary/checkpolicy

CLN-common::
	$(REASON)
	-test ! -f Makefile || $(MAKE) clean
	$(MAKE) -C test clean

CLEAN/checkpolicy::
	-rm -rf $(TMPTOP)

debian/stamp/build/checkpolicy:
	$(checkdir)
	$(REASON)
	@test -d debian/stamp/build || mkdir -p debian/stamp/build
	$(MAKE) YACC="bison -y" CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
	$(MAKE) -C test YACC="bison -y" CC="$(CC)" CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
	$(check-libraries)
	@echo done > $@

debian/stamp/install/checkpolicy:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	rm -rf               $(TMPTOP)
	$(make_directory)    $(TMPTOP)
	$(make_directory)    $(BINDIR)
	$(make_directory)    $(MAN8DIR)
	$(make_directory)    $(DOCDIR)
	$(MAKE)              DESTDIR=$(TMPTOP) install
	$(install_file)      debian/changelog       $(DOCDIR)/changelog.Debian
	$(install_file)      ChangeLog              $(DOCDIR)/changelog
	gzip -9frq           $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)      debian/copyright       $(DOCDIR)/copyright
	gzip -9fqr           $(MANDIR)/
	$(strip-exec)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	@echo done > $@

debian/stamp/binary/checkpolicy:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	$(make_directory)    $(TMPTOP)/DEBIAN
	dpkg-shlibdeps       $(BINDIR)/checkpolicy
	dpkg-gencontrol      -p$(package) -isp      -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root:root   $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build         $(TMPTOP) ..
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	@echo done > $@
