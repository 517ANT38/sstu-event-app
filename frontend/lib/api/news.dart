import 'dart:convert';

import 'package:sstu_event_app/api/agent.dart';
import 'package:sstu_event_app/models/faculties.dart';
import 'package:sstu_event_app/models/news.dart';

abstract class NewsAgent extends Agent {
  static Future<List<HeaderNewsModel>> getAll(Faculties faculty) async {
    return (json.decode((await Agent.get("news/${faculty.name}")).body)
            as List<dynamic>)
        .map((e) => HeaderNewsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<NewsModel> getOne(String id) async {
    return NewsModel.fromJson(
        json.decode((await Agent.get("news/id/$id")).body));
  }
}
