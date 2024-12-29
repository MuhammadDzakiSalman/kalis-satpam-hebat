import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the timestamp
import '../widgets/Appbar.dart';

class NotificationDetail extends StatelessWidget {
  final String title;
  final String message;
  final DateTime timestamp; // Accept timestamp from the notification

  const NotificationDetail({
    super.key,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    // Format the timestamp to display a readable date and time
    String formattedTime = DateFormat('dd-MM-yyyy HH:mm').format(timestamp);

    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: title,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the card color to white
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15), // Set shadow opacity
                    blurRadius: 4, // Set blur radius
                    offset: const Offset(0, 0), // Set offset for shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                        height: 10), // Add space between message and timestamp
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        formattedTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
