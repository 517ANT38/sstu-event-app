import 'package:flutter/material.dart';
import 'subscriptdetailpage.dart';
import 'package:sstu_event_app/models/eventrequest.dart';
import 'package:sstu_event_app/services/sharedpreferencesservice.dart';

class SubscriptionListPage extends StatefulWidget {
  const SubscriptionListPage({super.key});

  @override
  State<SubscriptionListPage> createState() => _SubscriptionListPageState();
}

class _SubscriptionListPageState extends State<SubscriptionListPage> {
  List<EventRequest> subscriptions = [];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    final serv = Sharedpreferencesservice.get();
    final subscriptionData = await serv.loadSubscriptions();
    setState(() {
      subscriptions = subscriptionData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши подписки'),
      ),
      body: subscriptions.isEmpty
          ? const Center(child: Text('Подписки не найдены.'))
          : ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                subscription.nameEvent = subscription.nameEvent??"Мероприятие ${index+1}";
                return ListTile(
                  title: Text(subscription.nameEvent!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionDetailPage(
                          subscription: subscription,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
