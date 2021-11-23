# mpv-libunity
`mpv-libunity` is a mpv plugin that shows a nice progress bar on your panel/dock using libunity specification. Obviously this only works on linux and with panels that support libunity (such as kde plasma or dash-to-dock on gnome). Cinnamon panel is also supported via `cinnamon.lua` (but you will need xdotool and xprop in that case).

![](image.png)

## Build
Build requirements:
 - c++ compiler
 - pkg-config
 - mpv development files
 - Qt5DBus development files (On archlinux available via qt5-base)

Just run `make`

## Install
Just run `make install`
