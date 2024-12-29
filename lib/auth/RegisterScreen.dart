import 'package:flutter/material.dart';
import '../../widgets/Appbar.dart';  // Mengimpor custom AppBar
import '../widgets/RoleCard.dart';
import 'form/CorporateForm.dart';
import 'form/PoliceForm.dart';
import 'form/SecurityForm.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Register',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Judul dan deskripsi
              const Text(
                'Choose Your Role',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Please select your role to continue',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Membuat daftar RoleCard yang dapat dipilih
              _buildRoleCard(
                context,
                icon: Icons.local_police,
                label: "Police",
                destination: const PoliceForm(),
              ),
              _buildRoleCard(
                context,
                icon: Icons.security,
                label: "Security",
                destination: const SecurityForm(),
              ),
              _buildRoleCard(
                context,
                icon: Icons.business,
                label: "Corporate",
                destination: const CorporateForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mempermudah pembuatan RoleCard
  Widget _buildRoleCard(BuildContext context, {
    required IconData icon,
    required String label,
    required Widget destination,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RoleCard(
        icon: icon,
        label: label,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}