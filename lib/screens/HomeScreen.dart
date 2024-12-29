import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import '../widgets/IncidentCard.dart'; // Make sure to import your IncidentCard widget
import '../widgets/CreateIncidentModal.dart'; // Import the modal widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  // Controllers and form key for the modal
  final _formKey = GlobalKey<FormState>();
  final _jumlahSecurityController = TextEditingController();
  final _tanggalMulaiController = TextEditingController();
  final _tanggalSelesaiController = TextEditingController();
  final _lampiranController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Start the auto slide timer
    _timer = Timer.periodic(Duration(seconds: 3), _autoSlide);
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Auto slide function to change the page every 3 seconds
  void _autoSlide(Timer timer) {
    if (_currentPage < 3) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    // Animate to the next page
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    );

    // Dummy data for incidents
    List<Map<String, String>> incidents = [
      {
        'title': 'PT. Riau Petroleum',
        'subtitle': 'Membutuhkan 5 Satpam',
        'file': 'docs-20022024.pdf',
        'location': 'Riau, Indonesia',
        'date': '2024-12-22 08:30:00',
      },
      {
        'title': 'PT. Energi Nusantara',
        'subtitle': 'Membutuhkan 3 Satpam',
        'file': 'docs-15032024.pdf',
        'location': 'Jakarta, Indonesia',
        'date': '2024-12-22 10:15:00',
      },
      {
        'title': 'PT. Alam Raya',
        'subtitle': 'Membutuhkan 4 Satpam',
        'file': 'docs-11042024.pdf',
        'location': 'Bandung, Indonesia',
        'date': '2024-04-11 14:45:00',
      },
      {
        'title': 'PT. Sumber Sejahtera',
        'subtitle': 'Membutuhkan 2 Satpam',
        'file': 'docs-07052024.pdf',
        'location': 'Surabaya, Indonesia',
        'date': '2024-05-07 16:00:00',
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel with PageView
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // Number of images in carousel
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://via.placeholder.com/378x165", // Replace with your carousel images
                          fit: BoxFit.cover,
                          width: 350,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // 3 Buttons with gap
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildVerticalIconButton(
                    const Color(0xFF3FCAF3),
                    Icons.security,
                    'Data Satpam',
                  ),
                  const SizedBox(width: 15),
                  _buildVerticalIconButton(
                    const Color(0xFFFC5C65),
                    Icons.business,
                    'Data Corporate',
                  ),
                  const SizedBox(width: 15),
                  _buildVerticalIconButton(
                    const Color(0xFFFFB830),
                    Icons.history,
                    'History Incident',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Title Incident
              Container(
                width: double.infinity,
                child: Text(
                  'Latest Incident',
                  style: titleStyle,
                ),
              ),

              const SizedBox(height: 10),

              // List of Incidents (using IncidentCard widget)
              ...List.generate(
                incidents.length,
                (index) {
                  return IncidentCard(report: incidents[index]);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Show modal to add a new incident
    showDialog(
      context: context,
      builder: (context) {
        return CreateIncidentModal(
          formKey: _formKey,
          jumlahSecurityController: _jumlahSecurityController,
          tanggalMulaiController: _tanggalMulaiController,
          tanggalSelesaiController: _tanggalSelesaiController,
          lampiranController: _lampiranController,
          onCreateIncident: _handleCreateIncident,
        );
      },
    );
  },
  child: Icon(
    Icons.add,
    color: Colors.white, // Set the color to white
  ),
  backgroundColor: Colors.blue,
)

    );
  }

  void _handleCreateIncident() {
    // Handle incident creation (e.g., add to a list, show a message, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Incident Created!')),
    );
  }

  // Updated button with vertical icon and text arrangement
  Widget _buildVerticalIconButton(Color color, IconData icon, String text) {
    return Expanded(
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
