class SingleVideo {
  final int? id;
  final String? title;
  final String? description;
  final String? timeDuration;
  final String? videoType;
  final dynamic uploadedVideo;
  final String? youtubeLink;
  final dynamic thumbnail;

  SingleVideo({
    this.id,
    this.title,
    this.description,
    this.timeDuration,
    this.videoType,
    this.uploadedVideo,
    this.youtubeLink,
    this.thumbnail,
  });

  factory SingleVideo.fromJson(Map<String, dynamic> json) => SingleVideo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    timeDuration: json["time_duration"],
    videoType: json["video_type"],
    uploadedVideo: json["uploaded_video"],
    youtubeLink: json["youtube_link"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "time_duration": timeDuration,
    "video_type": videoType,
    "uploaded_video": uploadedVideo,
    "youtube_link": youtubeLink,
    "thumbnail": thumbnail,
  };
}