import 'package:flutter/material.dart';
import 'ProfileDetailScreen.dart';
import 'HistoryScreen.dart';
import 'ChangePasswordScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Profile content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture
                    CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          const NetworkImage("https://via.placeholder.com/100x100"),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 20),

                    // User Name (Optional)
                    const Text(
                      'John Doe', // Placeholder name
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'ABS1020',  // Nomor KTA
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Cetak ID Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        // Logic to print ID
                      },
                      child: const Text(
                        'Download QR Code',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Personal Data, History, and Account Section
                    _buildInfoSection(
                      context,
                      'Personal Data',
                      Icons.person,
                      const ProfileDetailScreen(),
                    ),
                    const SizedBox(height: 5),
                    _buildInfoSection(
                      context,
                      'History',
                      Icons.history,
                      const HistoryScreen(),
                    ),
                    const SizedBox(height: 5),
                    _buildInfoSection(
                      context,
                      'Change Password',
                      Icons.password,
                      const ChangePasswordScreen(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Logout Button at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // Logic to handle logout
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each information section with an icon
  Widget _buildInfoSection(
    BuildContext context,
    String title,
    IconData icon,
    Widget navigateTo,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,
                    size: 24, color: Colors.blue), // Icon for each section
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
