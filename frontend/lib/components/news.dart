import 'package:flutter/material.dart';
import 'package:sstu_event_app/models/news.dart';

class News extends StatelessWidget {
  final NewsModel model;

  const News({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
          constraints: const BoxConstraints.tightFor(width: 310, height: 86),
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
                child: const Image(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    )),
              ),
              if (model.imgURLs.isNotEmpty)
                Image(image: NetworkImage(model.imgURLs[0])),
            ],
          )),
    );
  }
}
