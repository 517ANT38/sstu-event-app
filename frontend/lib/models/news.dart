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
    return NewsModel(
        title: data['title'] as String,
        description: data['desc'] as String,
        date: data['date'] as DateTime,
        imgURLs: data['imgUrls'] as List<String>);
  }
}

class HeaderNewsModel {
  final String title;
  final String url;
  final String imgURL;

  HeaderNewsModel(
      {required this.title, required this.url, required this.imgURL});

  factory HeaderNewsModel.fromJson(Map<String, dynamic> data) {
    return HeaderNewsModel(
        title: data['title'] as String,
        url: data['url'] as String,
        imgURL: data['imgUrl'] as String);
  }
}
