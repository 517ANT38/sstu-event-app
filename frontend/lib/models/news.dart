class NewsModel{
  final String title;
  final String description;
  final DateTime date;
  final List<String> imgURLs;

  const NewsModel({
    required this.title,
    required this.description,
    required this.date,
    required this.imgURLs
  });

  factory NewsModel.fromJson(Map<String, dynamic> data){
    return NewsModel(
      title: data['title'] as String,
      description: data['desc'] as String,
      date: data['date'] as DateTime,
      imgURLs: data['imgUrls'] as List<String>
    );
  }
}