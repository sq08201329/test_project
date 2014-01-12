DIRS = pclibsrc clibsrc testproc 

all: 
	make `./systype.sh`

clean:
	for i in $(DIRS); do \
		(cd $$i && $(MAKE)  clean) || exit 1; \
	done
	#rm -rf bin/* lib/* logfile/*

freebsd:
	for i in $(DIRS); do \
		(cd $$i && $(MAKE) -f freebsd.mk) || exit 1; \
	done

linux:
	for i in $(DIRS); do \
		(cd $$i && $(MAKE)) || exit 1; \
	done

macos:
	for i in $(DIRS); do \
		(cd $$i && $(MAKE) -f macos.mk) || exit 1; \
	done

solaris:
	for i in $(DIRS); do \
		(cd $$i && $(MAKE) -f solaris.mk) || exit 1; \
	done
