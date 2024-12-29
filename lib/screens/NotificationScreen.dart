import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';
import '../widgets/Appbar.dart';
import 'NotificationDetailScreen.dart'; // Import NotificationDetail screen

class NotificationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'System',
      'message': 'Hi, Amorim Van Gofh. Masa berlaku KTA anda akan berakhir pada 20-01-2025',
      'read': false,
      'timestamp': DateTime.now(), // Current timestamp
    },
    {
      'title': 'System',
      'message': 'Hi, Amorim Van Gofh. Masa berlaku KTA anda akan berakhir pada 20-01-2025',
      'read': false,
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)), // 1 hour ago
    },
    {
      'title': 'System',
      'message': 'Hi, Amorim Van Gofh. Masa berlaku KTA anda akan berakhir pada 20-01-2025',
      'read': false,
      'timestamp': DateTime.now().subtract(const Duration(days: 1)), // 1 day ago
    },
  ];

  NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Function to simulate refreshing the list
  Future<void> _refreshNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      widget.notifications.insert(0, {
        'title': 'New Notification',
        'message': 'This is a new notification after refreshing.',
        'read': false, // Notification is new, marked as unread
        'timestamp': DateTime.now().subtract(const Duration(days: 1)), // 1 day ago
      });
    });
  }

  // Function to handle notification click and mark it as read
  void _onNotificationTap(int index) {
    setState(() {
      widget.notifications[index]['read'] = true; // Mark as read
    });

    // Navigate to the notification detail page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetail(
          title: widget.notifications[index]['title'],
          message: widget.notifications[index]['message'],
          timestamp: widget.notifications[index]['timestamp'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Notifications',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RefreshIndicator(
          onRefresh: _refreshNotifications,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: widget.notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(
                title: widget.notifications[index]['title'],
                message: widget.notifications[index]['message'],
                isRead: widget.notifications[index]['read'],
                timestamp: widget.notifications[index]['timestamp'], // Pass timestamp
                onTap: () => _onNotificationTap(index), // Pass the tap function
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final bool isRead;
  final DateTime timestamp; // Add timestamp
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.isRead,
    required this.timestamp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Format the timestamp using intl package
    String formattedTime = DateFormat('HH:mm').format(timestamp);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Place timestamp and badge side by side with a gap
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Timestamp
                Text(
                  formattedTime,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 10), // Gap between timestamp and badge
                // AnimatedSwitcher to show/hide the badge based on read status
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isRead
                      ? const SizedBox.shrink() // If read, hide badge
                      : badges.Badge(
                          key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
                          badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: Colors.blue,
                          ),
                          position: badges.BadgePosition.topEnd(top: -5, end: -5),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
