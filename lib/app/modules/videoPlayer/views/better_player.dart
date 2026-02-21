// better_player_widget.dart
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';


class BetterPlayerWidget extends StatefulWidget {
  final String url;
  final double aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool isLive;

  const BetterPlayerWidget({
    super.key,
    required this.url,
    this.aspectRatio = 16 / 9,
    this.autoPlay = true,
    this.looping = false,
    this.isLive = false,
  });

  @override
  State<BetterPlayerWidget> createState() => _BetterPlayerWidgetState();
}

class _BetterPlayerWidgetState extends State<BetterPlayerWidget> {
  late final BetterPlayerController _controller;

  @override
  void initState() {
    super.initState();
    final config = BetterPlayerConfiguration(
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      fit: BoxFit.contain,
      handleLifecycle: true,
      autoDetectFullscreenDeviceOrientation: true,
      fullScreenByDefault: false,
      allowedScreenSleep: false,
    );

    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
      liveStream: widget.isLive,
    );

    _controller = BetterPlayerController(config);
    _controller.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: BetterPlayer(controller: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}