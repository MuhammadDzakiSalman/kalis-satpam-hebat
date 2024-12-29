// lib/main.dart
// import 'package:e_satpam_bengkalis/screens/auth/LoginScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'auth/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/IncidentScreen.dart';
import 'screens/SecurityScreen.dart';
import 'screens/ProfileScreen.dart';

// import 'screens/auth/LoginScreen.dart';
import 'widgets/Appbar.dart';
import 'widgets/BottomNavbar.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        indicatorColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SecurityScreen(),
    const IncidentScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    'Home', 
    'Security', 
    'Incident', 
    'Profile',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _titles[_currentIndex]),
      body: _screens[_currentIndex],
      bottomNavigationBar: MyBottomNavbar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}
