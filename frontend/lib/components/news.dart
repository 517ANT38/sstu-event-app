import 'package:flutter/material.dart';
import 'package:sstu_event_app/api/news.dart';
import 'package:sstu_event_app/models/news.dart';
import 'package:sstu_event_app/pages/newspage.dart';

class News extends StatelessWidget {
  final HeaderNewsModel model;

  const News({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
          onTap: () {
            NewsAgent.getOne(model.id).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewsPage(model: value)));
            });
          },
          child: Container(
              constraints:
                  const BoxConstraints.tightFor(width: 310, height: 86),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      constraints:
                          const BoxConstraints.tightFor(width: 224, height: 86),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(model.title, textAlign: TextAlign.center)),
                  Container(
                    constraints:
                        const BoxConstraints.tightFor(width: 86, height: 86),
                    child: Image(
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          model.imgURL,
                        )),
                  ),
                ],
              ))),
    );
  }
}
