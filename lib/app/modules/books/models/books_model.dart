class BooksModel {
  final String? msg;
  final bool? status;
  final List<Book>? data;

  BooksModel({
    this.msg,
    this.status,
    this.data,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<Book>.from(json["data"]!.map((x) => Book.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Book {
  final int? id;
  final String? heading;
  final List<Chapter>? chapters;

  Book({
    this.id,
    this.heading,
    this.chapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    heading: json["heading"],
    chapters: json["chapters"] == null
        ? []
        : List<Chapter>.from(
        json["chapters"]!.map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "heading": heading,
    "chapters": chapters == null
        ? []
        : List<dynamic>.from(chapters!.map((x) => x.toJson())),
  };
}

class Chapter {
  final int? id;
  final String? title;
  final String? urlLink;
  final List<SubChapter>? subchapters;

  Chapter({
    this.id,
    this.title,
    this.urlLink,
    this.subchapters,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    title: json["title"],
    urlLink: json["url_link"],
    subchapters: json["subchapters"] == null
        ? []
        : List<SubChapter>.from(
        json["subchapters"]!.map((x) => SubChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url_link": urlLink,
    "subchapters": subchapters == null
        ? []
        : List<dynamic>.from(subchapters!.map((x) => x.toJson())),
  };
}

class SubChapter {
  final int? id;
  final String? title;
  final String? urlLink;

  SubChapter({
    this.id,
    this.title,
    this.urlLink,
  });

  factory SubChapter.fromJson(Map<String, dynamic> json) => SubChapter(
    id: json["id"],
    title: json["title"],
    urlLink: json["url_link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url_link": urlLink,
  };
}
