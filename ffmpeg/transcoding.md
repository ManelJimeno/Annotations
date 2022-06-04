# FFmpeg tricks

[Useful commands](https://www.busindre.com/comandos_ffmpeg_utiles)

## Transcoding

| Resolution         | Bitrate     |
| ------------------ | ----------- |
| 352 x 240: 240p    | 200 - 350   |
| 480 x 360: 360p    | 400 - 650   |
| 720 x 540: 540p    | 750 - 1350  |
| 858 x 480: 480p    | 600 - 1100  |
| 1280 x 720: 720p   | 1300 - 2300 |
| 1920 x 1080: 1080p | 2850 - 4500 |

```bash
ffmpeg -i bbb_sunflower_2160p_60fps.mp4 -vf scale=1280:720 -b:v 2000k video_HD_2000k.mkv

ffmpeg -i bbb_sunflower_2160p_60fps_normal.mp4 -c:v libx264 -profile:v main -level:v 4.0 -c:a copy bbb_sunflower_2160p_60fps_normal_main.mp4


ffmpeg -i bbb_sunflower_2160p_60fps_normal.mp4 -c:v h264_videotoolbox -vf scale=1280:720 -profile:v main -level:v 4.0 -c:a copy bbb_sunflower_2160p_60fps_normal_main.mp4

ffmpeg -i bbb_sunflower_2160p_60fps_normal.mp4 -c:v h264_nvenc -vf scale=1280:720 -profile:v main -level:v 4.0 -c:a copy bbb_sunflower_2160p_60fps_normal_main.mp4

h264_nvenc

ffmpeg -hide_banner -i bbb_sunflower_2160p_60fps_normal.mp4 -h encoder=h264_videotoolbox -profile:v main  bbb_sunflower_2160p_60fps_normal_main.mp4
```
