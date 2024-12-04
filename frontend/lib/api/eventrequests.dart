import 'dart:convert';

import 'package:http/http.dart';
import 'package:sstu_event_app/api/agent.dart';
import 'package:sstu_event_app/models/eventrequest.dart';

abstract class EventRequestsAgent extends Agent {
  static Future<Response> add(EventRequest model) async {
    return Agent.post("requestsEvents/create", json.encode(model.toJson()));
  }
}
