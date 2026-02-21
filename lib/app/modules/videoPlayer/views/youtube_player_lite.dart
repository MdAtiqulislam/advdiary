import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerLite extends StatefulWidget {
  final String videoUrl;

  const YoutubePlayerLite({super.key, required this.videoUrl});

  @override
  State<YoutubePlayerLite> createState() => _YoutubePlayerLiteState();
}

class _YoutubePlayerLiteState extends State<YoutubePlayerLite> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: false,
        forceHD: true,
        controlsVisibleAtStart: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.redAccent,
        onReady: () => debugPrint('YouTube Player Ready'),
      ),
      builder: (context, player) {
        return Container(
          color: Colors.black,
          child: player,
        );
      },
    );
  }
}
