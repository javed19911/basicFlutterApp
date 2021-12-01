import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String file;
  final bool isLocalFile;
  final bool autoPlay;
  final bool useAsThumbnail;
  final ValueChanged<VideoPlayerController>? onInitialized;
  const VideoPlayerScreen(
      {Key? key,
      required this.file,
      this.isLocalFile = true,
      this.autoPlay = false,
      this.useAsThumbnail = false,
      this.onInitialized})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool isPlaying = false;
  // Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    if (widget.isLocalFile) {
      _controller = VideoPlayerController.file(
        File(widget.file),
      );
    } else {
      _controller = VideoPlayerController.network(widget.file
          // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          );
    }

    // Initialize the controller and store the Future for later use.
    // _initializeVideoPlayerFuture = _controller.initialize();

    _controller?.initialize().then((_) {
      print("_controller initialized");
      if (widget.onInitialized != null) {
        widget.onInitialized?.call(_controller!);
      }
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});

      _controller?.addListener(() {
        // print("controller.value.isPlaying  ${_controller.value.isPlaying}");
        // print("isPlaying  $isPlaying");
        if (isPlaying != _controller!.value.isPlaying) {
          setState(() {
            isPlaying = _controller!.value.isPlaying;
          });
        }
      });

      if (widget.autoPlay) {
        Future.delayed(Duration(seconds: 1), () {
          _controller?.play();
          // setState(() {});
        });
      }
    });

    // Use the controller to loop the video.
    // _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // var scale = size.aspectRatio * _controller.value.aspectRatio;
    // if (scale < 1) scale = 1 / scale;
    return Scaffold(
      backgroundColor: Colors.grey,
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Stack(children: [
        // Transform.scale(
        //   scale: scale,
        //   child: Center(
        //     child: _controller.value.isInitialized
        //         ? VideoPlayer(_controller)
        //         : Container(),
        //   ),
        // ),
        Center(
          child: _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container(),
        ),

        if (!widget.useAsThumbnail)
          Center(
            child: MaterialButton(
              splashColor: Colors.transparent,
              onPressed: () {
                // Wrap the play or pause in a call to `setState`. This ensures the
                // correct icon is shown.
                setState(() {
                  // If the video is playing, pause it.
                  if (_controller!.value.isPlaying) {
                    _controller?.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller?.play();
                  }
                });
              },
              // Display the correct icon depending on the state of the player.
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ]),
    );
  }
}
