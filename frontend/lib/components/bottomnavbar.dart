import 'package:flutter/material.dart';
import 'package:sstu_event_app/pages/subscriptlistpage.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Theme.of(context).colorScheme.secondary,
          constraints: const BoxConstraints.tightFor(height: 38),
        ),
        Container(
          constraints: const BoxConstraints.tightFor(height: 54),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionListPage(),
                ),
              );
            },
            child: const Text("Ваши подписки"),
          ),
        )
      ],
    );
  }
}
