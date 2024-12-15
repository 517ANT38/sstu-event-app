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
        title: const Text('Your Subscriptions'),
      ),
      body: subscriptions.isEmpty
          ? const Center(child: Text('No subscriptions found.'))
          : ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];
                return ListTile(
                  title: Text('${subscription.firstName} ${subscription.secondName}'),
                  subtitle: Text(subscription.edu),
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
