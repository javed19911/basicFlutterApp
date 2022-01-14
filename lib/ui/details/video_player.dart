import 'package:flutter/widgets.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatelessWidget {
  final String videoId;
  const VideoPlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      params: const YoutubePlayerParams(
        // autoPlay: true,
        // mute: true,
        enableCaption: false,
        showFullscreenButton: true,
      ),
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return YoutubePlayerIFrame(
          aspectRatio: constraints.maxWidth / constraints.maxHeight,
          controller: _controller,
        );
      },
    );
  }
}
