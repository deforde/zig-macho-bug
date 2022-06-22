.PHONY: all

all: libfoo

builddir: clean
	mkdir build

libfoo: builddir
	$(CC) -shared -fPIC foo.c -o build/libfoo.$(DYLIB_EXT)

exec: libfoo
	$(CC) main.c build/libfoo.$(DYLIB_EXT) -o build/app

clean:
	rm -rf build

