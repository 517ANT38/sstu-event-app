import 'package:flutter/material.dart';
import 'package:sstu_event_app/components/faclist.dart';
import 'package:sstu_event_app/components/news.dart';
import 'package:sstu_event_app/models/news.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewsListPageState();
  }
}

class NewsListPageState extends State<NewsListPage> {
  List<NewsModel> models = [
    NewsModel(
        title: "Hello",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "bye",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "okay",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "Hello",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "bye",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "okay",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "Hello",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "bye",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "okay",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "Hello",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "bye",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
    NewsModel(
        title: "okay",
        description: "description",
        date: DateTime.now(),
        imgURLs: []),
  ];

  bool showFilter = false;
  setShowFilter(bool showFilter) {
    setState(() {
      this.showFilter = showFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 310),
                child: const Text("Your news")),
            const SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                const SizedBox(height: 10),
                ...models.map((m) => Column(
                    children: [News(model: m), const SizedBox(height: 20)]))
              ],
            ))),
            Container(
                color: Theme.of(context).colorScheme.secondary,
                constraints: const BoxConstraints.tightFor(height: 38)),
          ],
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  setShowFilter(true);
                },
                child: Image.asset("assets/images/expand.png"))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints.tightFor(height: 54),
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  color: Theme.of(context).colorScheme.inversePrimary),
              child: TextButton(
                  onPressed: () {}, child: const Text("Your subscribes")),
            )),
        if (showFilter)
          Stack(children: [
            GestureDetector(onTap: () {
              setShowFilter(false);
            }),
            const Align(
              alignment: Alignment.centerLeft,
              child: Faclist(),
            )
          ])
      ],
    );
  }
}