import 'package:flutter/material.dart';
import 'package:sstu_event_app/models/faculties.dart';

class Faclist extends StatefulWidget {
  const Faclist({super.key});

  @override
  State<StatefulWidget> createState() {
    return FaclistState();
  }
}

class FaclistState extends State<Faclist> {
  Set<Faculties> selected = Set.from(Faculties.values);

  updateSelected(Faculties fac) {
    setState(() {
      if (selected.contains(fac)) {
        selected.remove(fac);
      } else {
        selected.add(fac);
      }
    });
  }

  clearSelected() {
    setState(() {
      selected = Set.from(Faculties.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.inversePrimary;

    final unActiveColor = Theme.of(context).colorScheme.secondary;

    return Container(
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(15)),
          color: Theme.of(context).colorScheme.primaryContainer),
      constraints: const BoxConstraints.tightFor(width: 190, height: 500),
      padding: const EdgeInsets.all(9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                color: selected.contains(Faculties.sstu)
                    ? activeColor
                    : unActiveColor,
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(15))),
            child: TextButton(
                onPressed: () {
                  updateSelected(Faculties.sstu);
                },
                child: const Text("SSTU")),
          ),
          ...Faculties.values.skip(1).map((e) => DecoratedBox(
              decoration: BoxDecoration(
                  color: selected.contains(e) ? activeColor : unActiveColor),
              child: TextButton(
                  onPressed: () {
                    updateSelected(e);
                  },
                  child: Text(e.name)))),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15))),
              child: TextButton(
                  onPressed: clearSelected, child: const Text("RESET"))),
        ],
      ),
    );
  }
}
