# Pipelines to handle frames

- Export video's frames
```
gst-launch-1.0 filesrc location=out.h264 ! h264parse ! decodebin ! videoconvert ! pngenc ! multifilesink location='frames/%04.png'
```