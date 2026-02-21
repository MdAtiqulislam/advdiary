/*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:better_player_plus/better_player_plus.dart';

enum VideoSourceType {
  youtube,
  vimeo,
  network,
  localFile,
  unknown,
}

class UniversalVideoPlayer extends StatefulWidget {

  const UniversalVideoPlayer({
    super.key,
    this.sourceType=VideoSourceType.unknown,
    required this.videoUrlOrId,
    this.autoPlay = true,
    this.looping = false,
    this.aspectRatio = 16 / 9,
  });

  factory UniversalVideoPlayer.fromLink(
      String link, {
        Key? key,
        bool autoPlay = true,
        bool looping = false,
        double aspectRatio = 16 / 9,
      }) {
    final type = _detectSourceType(link);
    return UniversalVideoPlayer(
      key: key,
      sourceType: type,
      videoUrlOrId: link,
      autoPlay: autoPlay,
      looping: looping,
      aspectRatio: aspectRatio,
    );
  }

  final VideoSourceType sourceType;
  final String videoUrlOrId;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  @override
  State<UniversalVideoPlayer> createState() => _UniversalVideoPlayerState();

  static String? _extractYouTubeId(String urlOrId) {
    return YoutubePlayer.convertUrlToId(urlOrId) ?? urlOrId;
  }

  static String? _extractVimeoId(String url) {
    final regExp = RegExp(r"vimeo\.com/(?:video/)?(\d+)");
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? url;
  }

  static VideoSourceType _detectSourceType(String url) {
    if (url.contains("youtu")) return VideoSourceType.youtube;
    if (url.contains("vimeo")) {
      print("video type");
      return VideoSourceType.vimeo;
    }
    if (url.startsWith("file://") ||
        url.endsWith(".mp4") ||
        url.endsWith(".m3u8") ||
        url.contains("cdn") ||
        url.contains("stream")) {
      return VideoSourceType.localFile;


    }
    return VideoSourceType.unknown; // অন্য সব ক্ষেত্রে ওয়েবভিউ
  }
}

class _UniversalVideoPlayerState extends State<UniversalVideoPlayer> {
  YoutubePlayerController? _ytController;
  BetterPlayerController? _bpController;
  late WebViewController _webViewController;
  bool _isWebViewLoaded = false; // ✅ WebView loaded state

  @override
  void initState() {
    super.initState();

    switch (widget.sourceType) {
      case VideoSourceType.youtube:
        _ytController = YoutubePlayerController(
          initialVideoId: UniversalVideoPlayer._extractYouTubeId(widget.videoUrlOrId)!,
          flags: YoutubePlayerFlags(
            autoPlay: widget.autoPlay,
            loop: widget.looping,
            enableCaption: true,
            controlsVisibleAtStart: true,
            forceHD: true,
            useHybridComposition: true,
          ),
        );
        break;

      case VideoSourceType.vimeo:
        break;

      case VideoSourceType.network:
      case VideoSourceType.localFile:
        final config = BetterPlayerConfiguration(
          aspectRatio: widget.aspectRatio,
          autoPlay: widget.autoPlay,
          looping: widget.looping,
          fit: BoxFit.contain,
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            enableFullscreen: true,
            enablePlaybackSpeed: true,
            enableMute: true,
            showControls: true,
          ),
          autoDetectFullscreenDeviceOrientation: true,
          autoDetectFullscreenAspectRatio: true,
        );

        final dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.videoUrlOrId,
        );

        _bpController = BetterPlayerController(config)..setupDataSource(dataSource);
        break;

      case VideoSourceType.unknown:
        _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (_) {
                setState(() {
                  _isWebViewLoaded = true; // ✅ page loaded
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.videoUrlOrId));
        break;
    }
  }

  @override
  void dispose() {
    _ytController?.dispose();
    _bpController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    switch (widget.sourceType) {
      case VideoSourceType.youtube:
        return YoutubePlayerBuilder(
          onEnterFullScreen: () {
            // Force landscape + hide system UI
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          },
          onExitFullScreen: () {
            // Back to portrait + show system UI
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          },
          player: YoutubePlayer(
            controller: _ytController!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
          builder: (context, player) {
            return Container(color: Colors.black, child: player);
          },
        );






      case VideoSourceType.vimeo:
        return VimeoPlayer(
          videoId: UniversalVideoPlayer._extractVimeoId(widget.videoUrlOrId)!,
        );

      case VideoSourceType.network:
      case VideoSourceType.localFile:
        return AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: BetterPlayer(controller: _bpController!),
        );

      case VideoSourceType.unknown:
        return Container(
          height: 300,
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              Opacity(
                opacity: _isWebViewLoaded ? 1 : 0,
                child: WebViewWidget(controller: _webViewController),
              ),
              if (!_isWebViewLoaded)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          ),
        );
    }
  }
}


*/

// universal_video_player.dart

/*
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:better_player_plus/better_player_plus.dart';

enum VideoSourceType {
  youtube,
  vimeo,
  network,
  localFile,
  unknown,
}

class UniversalVideoPlayer extends StatefulWidget {
  const UniversalVideoPlayer({
    super.key,
    this.sourceType = VideoSourceType.unknown,
    required this.videoUrlOrId,
    this.autoPlay = true,
    this.looping = false,
    this.aspectRatio = 16 / 9,
  });

  factory UniversalVideoPlayer.fromLink(
      String link, {
        Key? key,
        bool autoPlay = true,
        bool looping = false,
        double aspectRatio = 16 / 9,
      }) {
    final type = _detectSourceType(link);
    return UniversalVideoPlayer(
      key: key,
      sourceType: type,
      videoUrlOrId: link,
      autoPlay: autoPlay,
      looping: looping,
      aspectRatio: aspectRatio,
    );
  }

  final VideoSourceType sourceType;
  final String videoUrlOrId;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  @override
  State<UniversalVideoPlayer> createState() => _UniversalVideoPlayerState();

  static String? _extractYouTubeId(String urlOrId) {
    return YoutubePlayerController.convertUrlToId(urlOrId) ?? urlOrId;
  }

  static String? _extractVimeoId(String url) {
    final regExp = RegExp(r"vimeo\.com/(?:video/)?(\d+)");
    final match = regExp.firstMatch(url);
    print("vimeo url: $url");
    print("vimeo id: ${match?.group(1)}");
    return match?.group(1);
  }


  static VideoSourceType _detectSourceType(String url) {
    if (url.contains("youtu")) return VideoSourceType.youtube;
    if (url.contains("vimeo")) return VideoSourceType.vimeo;
    if (url.startsWith("file://") ||
        url.endsWith(".mp4") ||
        url.endsWith(".m3u8") ||
        url.contains("cdn") ||
        url.contains("stream")) {
      return VideoSourceType.localFile;
    }
    return VideoSourceType.unknown; // other types like WebView
  }
}

class _UniversalVideoPlayerState extends State<UniversalVideoPlayer> {
  YoutubePlayerController? _ytIframeController;
  BetterPlayerController? _bpController;
  late WebViewController _webViewController;
  bool _isWebViewLoaded = false;

  @override
  void initState() {
    super.initState();

    switch (widget.sourceType) {
      case VideoSourceType.youtube:
        final videoId = YoutubePlayerController.convertUrlToId(widget.videoUrlOrId) ?? widget.videoUrlOrId;
        _ytIframeController = YoutubePlayerController(
         // initialVideoId: videoId,
          params: YoutubePlayerParams(
           // autoPlay: true,
            showFullscreenButton: true,
            showControls: true,
            enableCaption: true,
            strictRelatedVideos: true,
            showVideoAnnotations: false,

            //  origin: widget.videoUrlOrId
          ),
        );
        _ytIframeController?.loadVideoById(videoId: videoId);


        break;

      case VideoSourceType.vimeo:
        break;

      case VideoSourceType.network:
      case VideoSourceType.localFile:
        final config = BetterPlayerConfiguration(
          aspectRatio: widget.aspectRatio,
          autoPlay: widget.autoPlay,
          looping: widget.looping,
          fit: BoxFit.contain,
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            enableFullscreen: true,
            enablePlaybackSpeed: true,
            enableMute: true,
            showControls: true,
          ),
          autoDetectFullscreenDeviceOrientation: true,
          autoDetectFullscreenAspectRatio: true,
        );

        final dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.videoUrlOrId,
        );

        _bpController = BetterPlayerController(config)..setupDataSource(dataSource);
        break;

      case VideoSourceType.unknown:
        _webViewController = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (_) {
                setState(() {
                  _isWebViewLoaded = true;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.videoUrlOrId));
        break;
    }
  }

  @override
  void dispose() {
    _ytIframeController?.close();
    _bpController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.sourceType) {
      case VideoSourceType.youtube:
        return YoutubePlayerScaffold(
          controller: _ytIframeController!,
          builder: (context, player) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: player,
            );
          },
        );

      case VideoSourceType.vimeo:
        return VimeoPlayer(
          videoId: UniversalVideoPlayer._extractVimeoId(widget.videoUrlOrId)!,
        );

      case VideoSourceType.network:
      case VideoSourceType.localFile:
        return AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: BetterPlayer(controller: _bpController!),
        );

      case VideoSourceType.unknown:
        return Container(
          height: 300,
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              Opacity(
                opacity: _isWebViewLoaded ? 1 : 0,
                child: WebViewWidget(controller: _webViewController),
              ),
              if (!_isWebViewLoaded)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          ),
        );
    }
  }
}

*/

// universal_video_player.dart

import 'package:advdiary/app/modules/videoPlayer/views/vimeo_player.dart';
import 'package:advdiary/app/modules/videoPlayer/views/web_view_player.dart';
import 'package:advdiary/app/modules/videoPlayer/views/youtube_player_lite.dart';
import 'package:flutter/material.dart';

import 'better_player.dart';

enum VideoSourceType {
  youtube,
  vimeo,
  network,
  localFile,
  liveTV,
  unknown,
}

class UniversalVideoPlayer extends StatelessWidget {
  final VideoSourceType sourceType;
  final String videoUrlOrId;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;

  const UniversalVideoPlayer({
    super.key,
    this.sourceType = VideoSourceType.unknown,
    required this.videoUrlOrId,
    this.autoPlay = true,
    this.looping = false,
    this.aspectRatio = 16 / 9,
  });

  factory UniversalVideoPlayer.fromLink(
    String link, {
    Key? key,
    bool autoPlay = true,
    bool looping = false,
    double aspectRatio = 16 / 9,
  }) {
    final type = _detectSourceType(link);
    return UniversalVideoPlayer(
      key: key,
      sourceType: type,
      videoUrlOrId: link,
      autoPlay: autoPlay,
      looping: looping,
      aspectRatio: aspectRatio,
    );
  }

  static VideoSourceType _detectSourceType(String url) {
    if (url.contains("youtu")) return VideoSourceType.youtube;
    if (url.contains("vimeo")) return VideoSourceType.vimeo;
    if (url.endsWith(".m3u8") || url.contains("live"))
      return VideoSourceType.liveTV;
    if (url.startsWith("file://") ||
        url.endsWith(".mp4") ||
        url.contains("cdn") ||
        url.contains("stream")) {
      return VideoSourceType.localFile;
    }
    return VideoSourceType.unknown;
  }

  @override
  Widget build(BuildContext context) {
    switch (sourceType) {
      case VideoSourceType.youtube:
        return YoutubePlayerLite(
          videoUrl: videoUrlOrId,
        );
      case VideoSourceType.vimeo:
        return VimeoPlayerWidget(
          videoUrlOrId: videoUrlOrId,
          // aspectRatio: aspectRatio,
        );
      case VideoSourceType.network:
      case VideoSourceType.localFile:
      case VideoSourceType.liveTV:
        return BetterPlayerWidget(
          url: videoUrlOrId,
          aspectRatio: aspectRatio,
          autoPlay: autoPlay,
          looping: looping,
          isLive: sourceType == VideoSourceType.liveTV,
        );
      case VideoSourceType.unknown:
        return WebViewPlayerWidget(url: videoUrlOrId);
    }
  }
}
