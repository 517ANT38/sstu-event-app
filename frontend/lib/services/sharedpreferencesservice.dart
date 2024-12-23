
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sstu_event_app/models/eventrequest.dart';

class Sharedpreferencesservice {
  static Sharedpreferencesservice? _service;
  Sharedpreferencesservice._();
  static Sharedpreferencesservice get() {
    _service ??= Sharedpreferencesservice._();
    return _service!;
  }

  Future<List<EventRequest>> loadSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> lst  = (await prefs.getStringList('subscriptions')) ?? [];
    return lst.map((e) =>EventRequest.fromJson(json.decode(e)))
          .toList();
    
  }

  Future<void> addSubscriptions(EventRequest subscription) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> subscriptionData = (prefs.getStringList('subscriptions')) ?? [];
  final subDict = subscription.toJson();
  subDict['nameEvent'] = subscription.nameEvent;
  subscriptionData.add(json.encode(subDict));
  await prefs.setStringList('subscriptions', subscriptionData);
}
  

}