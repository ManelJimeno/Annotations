# Build GStreamer

## Build gst-validate and install

```bash
git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git
cd gstreamer
meson build && ninja -C builddir
sudo cp builddir/subprojects/gst-devtools/validate/gst/validate/libgstvalidate-1.0.so.0 /lib/x86_64-linux-gnu
sudo cp builddir/subprojects/gst-devtools/validate/tools/gst-validate-1.0 /usr/bin
# sudo apt install patchelf
sudo patchelf --remove-rpath /usr/bin/gst-validate-1.0
```