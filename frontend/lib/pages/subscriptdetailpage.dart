import 'package:flutter/material.dart';
import 'package:sstu_event_app/models/eventrequest.dart';

class SubscriptionDetailPage extends StatelessWidget {
  final EventRequest subscription;

  const SubscriptionDetailPage({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${subscription.firstName} ${subscription.secondName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${subscription.firstName} ${subscription.secondName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text('Education: ${subscription.edu}'),
            const SizedBox(height: 8),
            Text('Phone: ${subscription.phone}'),
            const SizedBox(height: 8),
            Text('Children Count: ${subscription.countChild}'),
            const SizedBox(height: 8),
            Text('Class Range: ${subscription.fromClass} to ${subscription.toClass ?? 'N/A'}'),
            const SizedBox(height: 8),
            Text('Event ID: ${subscription.idEvent}'),
            const SizedBox(height: 8),
            Text('Representative: ${subscription.isRepresentative ? "Yes" : "No"}'),
          ],
        ),
      ),
    );
  }
}
