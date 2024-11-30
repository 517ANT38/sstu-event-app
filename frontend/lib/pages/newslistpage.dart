import 'package:flutter/material.dart';
import 'package:sstu_event_app/api/news.dart';
import 'package:sstu_event_app/components/bottomnavbar.dart';
import 'package:sstu_event_app/components/faclist.dart';
import 'package:sstu_event_app/components/news.dart';
import 'package:sstu_event_app/models/faculties.dart';
import 'package:sstu_event_app/models/news.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewsListPageState();
  }
}

class NewsListPageState extends State<NewsListPage>
    with SingleTickerProviderStateMixin {
  Map<Faculties, List<HeaderNewsModel>> headers =
      Map.fromEntries(Faculties.values.map((e) => MapEntry(e, [])));

  bool showFilter = false;
  setShowFilter(bool showFilter) {
    setState(() {
      this.showFilter = showFilter;
    });
  }

  late Animation<double> animation;
  late AnimationController controller;

  late Set<Faculties> faculties;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    animation = Tween<double>(begin: -3, end: -1).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    faculties = Faculties.values.toSet();

    for (var fac in Faculties.values) {
      NewsAgent.getAll(fac).then((value) {
        setState(() {
          headers.addAll({fac: value});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset("assets/images/notify.png"))
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
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
                    ...headers.entries
                        .where((entry) => faculties.contains(entry.key))
                        .expand((entry) => entry.value)
                        .map((model) => Column(children: [
                              News(model: model),
                              const SizedBox(height: 20)
                            ]))
                  ],
                ))),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      controller.forward().then((_) {
                        setShowFilter(true);
                      });
                    },
                    child: Image.asset("assets/images/expand.png"))),
            Stack(children: [
              if (showFilter)
                GestureDetector(onTap: () {
                  controller.reverse().then((_) {
                    setShowFilter(false);
                  });
                }),
              Align(
                alignment: Alignment(animation.value, 0),
                child: Faclist(onChange: (facs) {
                  setState(() {
                    faculties = facs;
                  });
                },),
              )
            ])
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
