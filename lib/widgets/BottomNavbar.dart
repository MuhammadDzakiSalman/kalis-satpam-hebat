import 'package:flutter/material.dart';

class MyBottomNavbar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const MyBottomNavbar({super.key, required this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 4,
      selectedFontSize: 0, // Hilangkan ukuran font untuk memastikan alignment
      unselectedFontSize: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_police_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey[800],
      onTap: onTap,
    );
  }
}
