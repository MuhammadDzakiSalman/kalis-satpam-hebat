import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../widgets/Appbar.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<Map<String, String>> profiles = _getProfiles();

  // Initialize profiles for easy maintenance
  static List<Map<String, String>> _getProfiles() {
    return [
      {
        'name': 'Amorim Van Gofh',
        'id': 'ID 1002OPB10',
        'status': 'Active',
        'assignment': '-',
        'image': 'images/police1.png',
      },
      {
        'name': 'John Doe',
        'id': 'ID 1003XYZ15',
        'status': 'Inactive',
        'assignment': 'Assigned to Project A',
        'image': 'images/police2.png',
      },
      {
        'name': 'Alice Johnson',
        'id': 'ID 1004ABC20',
        'status': 'Active',
        'assignment': 'Assigned to Project B',
        'image': 'images/police1.png',
      },
      {
        'name': 'Bob Smith',
        'id': 'ID 1005DEF25',
        'status': 'Inactive',
        'assignment': 'Assigned to Project C',
        'image': 'images/police2.png',
      },
      {
        'name': 'Charlie Brown',
        'id': 'ID 1006GHI30',
        'status': 'Active',
        'assignment': '-',
        'image': 'images/police1.png',
      },
      {
        'name': 'David Lee',
        'id': 'ID 1007JKL35',
        'status': 'Active',
        'assignment': 'Assigned to Project D',
        'image': 'images/police2.png',
      },
      {
        'name': 'Eva Green',
        'id': 'ID 1008MNO40',
        'status': 'Inactive',
        'assignment': '-',
        'image': 'images/police1.png',
      },
      {
        'name': 'Frank Ocean',
        'id': 'ID 1009PQR45',
        'status': 'Active',
        'assignment': 'Assigned to Project E',
        'image': 'images/police2.png',
      },
      {
        'name': 'Grace Lee',
        'id': 'ID 1010STU50',
        'status': 'Inactive',
        'assignment': 'Assigned to Project F',
        'image': 'images/police1.png',
      },
      {
        'name': 'Henry Adams',
        'id': 'ID 1011VWX55',
        'status': 'Active',
        'assignment': '-',
        'image': 'images/police2.png',
      },
    ];
  }

  // Filter profiles based on search query
  List<Map<String, String>> _filterProfiles() {
    return profiles.where((profile) {
      final name = profile['name']!.toLowerCase();
      final id = profile['id']!.toLowerCase();
      return name.contains(_searchQuery) || id.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProfiles = _filterProfiles();

    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          _buildProfileList(filteredProfiles),
        ],
      ),
    );
  }

  // Build search bar with QR scan functionality
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search by name or ID',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: _onQRScanPressed,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Navigate to QR Scanner Screen and update search query with scanned result
  Future<void> _onQRScanPressed() async {
    final scannedCode = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );
    if (scannedCode != null) {
      setState(() {
        _searchQuery = scannedCode.toLowerCase();
        _searchController.text = scannedCode;
      });
    }
  }

  // Build the list of filtered profiles
  Widget _buildProfileList(List<Map<String, String>> filteredProfiles) {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredProfiles.length,
        itemBuilder: (context, index) {
          final profile = filteredProfiles[index];
          return ProfileCard(profile: profile);
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Map<String, String> profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 12, right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            _buildProfileImage(),
            const SizedBox(width: 10),
            _buildProfileDetails(),
          ],
        ),
      ),
    );
  }

  // Navigate to Detail Screen
  void _navigateToDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(profile: profile)),
    );
  }

  // Build profile image with a circular shape
  Widget _buildProfileImage() {
    return Container(
      width: 100,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(image: AssetImage(profile['image']!), fit: BoxFit.contain),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Build profile details (name, id, status, assignment)
  Widget _buildProfileDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile['name']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(profile['id']!),
          Text('Status: ${profile['status']}'),
          Text('Penugasan: ${profile['assignment']}'),
        ],
      ),
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildScannerBody(qrKey, context),
    );
  }

  // Build QR Scanner AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Scan QR Code'),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // Build QR Scanner Body
  Widget _buildScannerBody(GlobalKey qrKey, BuildContext context) {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: (controller) {
            controller.scannedDataStream.listen((scanData) {
              Navigator.pop(context, scanData.code);
              controller.dispose();
            });
          },
        ),
        _buildOverlay(),
        _buildFocusArea(),
        _buildHintText(),
      ],
    );
  }

  // Build overlay for QR scanner
  Widget _buildOverlay() {
    return Container(
      color: Colors.black.withOpacity(.5), // Semi-transparent overlay
    );
  }

  // Build focus area for QR code scanning
  Widget _buildFocusArea() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }

  // Build hint text at the bottom of the screen
  Widget _buildHintText() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Arahkan QR Code ke area ini untuk memindai',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, String> profile;

  const DetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail Personel',
        showNotificationIcon: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: _buildProfileDetailView(),
    );
  }

  // Build Profile Details View
  Widget _buildProfileDetailView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5), // Border with grey color and 0.5 opacity
            width: 1.0, // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(),
              const SizedBox(height: 20),
              _buildProfileInfo('Nama', profile['name']!),
              const SizedBox(height: 10),
              _buildProfileInfo('No. KTA', profile['id']!),
              const SizedBox(height: 10),
              _buildProfileInfo('Status', profile['status']!),
              const SizedBox(height: 10),
              _buildProfileInfo('Penugasan', profile['assignment']!),
            ],
          ),
        ),
      ),
    );
  }

  // Build the profile image for the detail screen
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(profile['image']!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Build text widget for profile information
  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with bold and colored style
          SizedBox(
            width: 100, // Fixed width for label to make it aligned
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 8), // Space between ":" and value
          // Value aligned to the left, ensuring the layout stays balanced
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
