

import '../models/single_video_model.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PassworrdValidator on String{
  bool isValidPassword() {
    return RegExp((r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')).hasMatch(this);
  }
}

extension SingleVideoThumbnail on SingleVideo {
  String? getThumbnailUrl() {
    if (videoType == "youtube_link" && youtubeLink != null) {
      final Uri? uri = Uri.tryParse(youtubeLink!);
      if (uri != null) {
        // Extract video id from YouTube link
        String? videoId;
        if (uri.queryParameters.containsKey('v')) {
          videoId = uri.queryParameters['v'];
        } else if (uri.pathSegments.isNotEmpty) {
          videoId = uri.pathSegments.last;
        }
        if (videoId != null) {
          return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
        }
      }
    }

    // If thumbnail provided from API
    if (thumbnail != null && thumbnail.toString().isNotEmpty) {
      return thumbnail.toString();
    }

    // For uploaded videos (server hosted)
    if (uploadedVideo != null && uploadedVideo.toString().isNotEmpty) {
      // Example: same folder as video but .jpg
      return uploadedVideo.toString().replaceAll(RegExp(r'\.\w+$'), '.jpg');
    }

    return null;
  }
}
