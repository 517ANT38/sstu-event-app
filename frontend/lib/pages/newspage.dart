import 'package:flutter/material.dart';
import 'package:sstu_event_app/components/bottomnavbar.dart';
import 'package:sstu_event_app/models/news.dart';
import 'package:sstu_event_app/pages/eventform.dart';

class NewsPage extends StatelessWidget {
  final NewsModel model;

  final String idEvent;

  const NewsPage({super.key, required this.model, required this.idEvent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новость"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset("assets/images/notify.png"))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                model.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(model.description),
              Text('${model.date.day}.${model.date.month}.${model.date.year}'),
              if (model.imgURLs.isNotEmpty)
                Image(image: NetworkImage(model.imgURLs[0])),
              // if (model.imgURLs.length > 1)
              //   ...model.imgURLs.sublist(1).map((e) => Image(image: NetworkImage(e)))
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EventForm(idEvent: idEvent,nameEvent:model.title)));
                      },
                      child: const Text("Подписаться"))),
              const SizedBox(height: 20)
            ],
          ),
        )),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
