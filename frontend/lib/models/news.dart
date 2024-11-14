class News{
  final String title;
  final String description;
  final DateTime date;
  final List<String> imgURLs;

  const News({
    required this.title,
    required this.description,
    required this.date,
    required this.imgURLs
  });

  factory News.fromJson(Map<String, dynamic> data){
    return News(
      title: data['title'] as String,
      description: data['desc'] as String,
      date: data['date'] as DateTime,
      imgURLs: data['imgUrls'] as List<String>
    );
  }
}