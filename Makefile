PKG_CONFIG = pkg-config

BASE_CFLAGS=-std=c++11 -Wall -Wextra -O3 `$(PKG_CONFIG) --cflags Qt5DBus mpv`
BASE_LDFLAGS=`$(PKG_CONFIG) --libs Qt5DBus`

libunity.so: libunity.c
	$(CXX) libunity.c -o libunity.so $(BASE_CFLAGS) $(CFLAGS) $(BASE_LDFLAGS) $(LDFLAGS) -shared -fPIC

install: libunity.so
	mkdir -p $(HOME)/.config/mpv/scripts
	cp libunity.so -t $(HOME)/.config/mpv/scripts

clean:
	rm libunity.so
