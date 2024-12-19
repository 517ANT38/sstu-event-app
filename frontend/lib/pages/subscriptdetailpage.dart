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
              'ФИО: ${subscription.firstName} ${subscription.secondName}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text('Школа: ${subscription.edu}'),
            const SizedBox(height: 8),
            Text('Телефон: ${subscription.phone}'),
            const SizedBox(height: 8),
            Text('Количество детей: ${subscription.countChild}'),
            const SizedBox(height: 8),
            subscription.toClass != null ? Text('Классы: с ${subscription.fromClass} по ${subscription.toClass}') : Text('Класс: ${subscription.fromClass}'),
            const SizedBox(height: 8),
            Text('Мероприятие: ${subscription.idEvent}'),
          ],
        ),
      ),
    );
  }
}
