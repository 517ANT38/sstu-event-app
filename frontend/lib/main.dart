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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Main"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: Image.asset("assets/images/notify.png"))
          ],
        ),
        body: Center(
          child: NewsListPage(),
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                color: darkTheme.colorScheme.secondary,
                constraints: const BoxConstraints.tightFor(height: 38)),
            Container(
              constraints: const BoxConstraints.tightFor(height: 54),
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  color: darkTheme.colorScheme.inversePrimary),
              child: TextButton(
                  onPressed: () {}, child: const Text("Your subscribes")),
            )
          ],
        ),
      ),
    );
  }
}
