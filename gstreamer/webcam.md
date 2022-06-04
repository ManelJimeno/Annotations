# Pipelines to handle a webcam

## See webcam in a window

```bash
gst-launch-1.0 autovideosrc device=/dev/video0 ! videoconvert ! xvimagesink
```

## Record webcam in a mp4 file

```bash
gst-launch-1.0 v4l2src device=/dev/video0 \
    ! video/x-raw, format=YUY2, width=640, height=360, framerate=15/1 \
    ! encodebin profile="video/quicktime,variant=iso:video/x-h264:audio/mpeg,mpegversion=1,layer=3" \
    ! filesink location=/tmp/test.mp4 -e
```
