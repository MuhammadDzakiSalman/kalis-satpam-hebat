import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/IncidentCard.dart';

class IncidentScreen extends StatelessWidget {
  const IncidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final reports = _generateDummyReports();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Gunakan IncidentCard di sini
              ...reports.map((report) => IncidentCard(report: report)).toList(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _generateDummyReports() {
    return [
      {
        'title': 'PT. Riau Petroleum PT. Riau Petroleum PT. Riau Petroleum',
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
  }
}
