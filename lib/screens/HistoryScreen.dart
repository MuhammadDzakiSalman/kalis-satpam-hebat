import 'package:flutter/material.dart';

import '../widgets/Appbar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'History',
        showNotificationIcon: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 10, // Example number of items
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.blue),
              title: Text('Activity ${index + 1}'),
              subtitle: const Text('Details about the activity.'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to details page
              },
            ),
          );
        },
      ),
    );
  }
}
