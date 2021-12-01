import 'dart:io';
import 'package:basic_flutter_app/res/color.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_player.dart';

class VideoThumbnailImage extends StatefulWidget {
  final String path;
  const VideoThumbnailImage({Key? key, required this.path}) : super(key: key);

  @override
  VideoThumbnailImageState createState() => VideoThumbnailImageState();
}

class VideoThumbnailImageState extends State<VideoThumbnailImage> {
  bool processing = true;
  VideoPlayerController? _controller;
  @override
  initState() {
    // getThumbnailImage(widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.rebuild) {
    //   // getThumbnailImage(widget.path);
    // }
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Container(
                    // width: MediaQuery.of(context).size.height - 200,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        LimitedBox(
                          maxHeight: 200,
                          maxWidth: 200,
                          child: _controller != null &&
                                  _controller!.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayerScreen(
                                    file: widget.path,
                                    isLocalFile:
                                        !widget.path.startsWith("http"),
                                    autoPlay: true,
                                  ),
                                )
                              : Center(child: CircularProgressIndicator()),
                        ),
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          color: const Color(0xFFBFFFBE),
                          child: Text(
                            '${widget.path.substring(widget.path.lastIndexOf("/") + 1)}',
                            maxLines: 1,
                            style: TextStyle(
                                color: CustomColors.darkGray(),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                            right: 7,
                            top: 7,
                            child: ClipOval(
                              child: Material(
                                color: Colors.red, // Button color
                                child: InkWell(
                                  splashColor: Colors.green, // Splash color
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Icon(Icons.clear,
                                          color: Colors.white, size: 20)),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        child: Stack(
          children: [
            // if (!processing)
            VideoPlayerScreen(
                onInitialized: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                file: widget.path,
                isLocalFile: !widget.path.startsWith("http"),
                useAsThumbnail: true),
            //if (!processing)
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
            // if (processing) Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
