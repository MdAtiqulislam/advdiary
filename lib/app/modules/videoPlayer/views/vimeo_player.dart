

import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VimeoPlayerWidget extends StatelessWidget {
  final String videoUrlOrId;

  const VimeoPlayerWidget({super.key, required this.videoUrlOrId});


  static String? _extractVimeoId(String url) {
    final regExp = RegExp(r"vimeo\.com/(?:video/)?(\d+)");
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
    return VimeoPlayer(videoId: _extractVimeoId(videoUrlOrId)??"");
  }
}