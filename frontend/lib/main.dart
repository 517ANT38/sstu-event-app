import 'package:flutter/material.dart';
import 'package:sstu_event_app/pages/newslistpage.dart';
import 'package:sstu_event_app/styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const NewsListPage());
  }
}
