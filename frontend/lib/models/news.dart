class NewsModel {
  final String title;
  final String description;
  final DateTime date;
  final List<String> imgURLs;

  NewsModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.imgURLs});

  factory NewsModel.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'title': String title,
        'desc': String description,
        'date': String date,
        'imgUrls': List<dynamic> imgUrls
      } =>
        NewsModel(
            title: title,
            description: description,
            date: DateTime.parse(date.split(".").reversed.join("-")),
            imgURLs: imgUrls.map((e) => e as String).toList()),
      _ => throw const FormatException("Failed to load News")
    };
  }
}

class HeaderNewsModel {
  final String id;
  final String title;
  final String url;
  final String imgURL;

  HeaderNewsModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.imgURL});

  factory HeaderNewsModel.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'title': String title,
        'url': String url,
        'imgUrl': String imgUrl
      } =>
        HeaderNewsModel(id: id, title: title, url: url, imgURL: imgUrl),
      _ => throw const FormatException("Failed to load HeaderNews")
    };
  }
}
