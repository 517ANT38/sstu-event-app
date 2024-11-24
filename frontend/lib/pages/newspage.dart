import 'package:flutter/material.dart';
import 'package:sstu_event_app/models/news.dart';

class NewsPage extends StatelessWidget {
  final NewsModel model;

  const NewsPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Text(model.title),
        Text(model.description),
        Text('${model.date.day}.${model.date.month}.${model.date.year}'),
        if (model.imgURLs.isNotEmpty)
          Image(image: NetworkImage(model.imgURLs[0])),
        // if (model.imgURLs.length > 1)
        //   ...model.imgURLs.sublist(1).map((e) => Image(image: NetworkImage(e)))
        TextButton(onPressed: () {}, child: const Text("Subscribe"))
      ],
    ));
  }
}
