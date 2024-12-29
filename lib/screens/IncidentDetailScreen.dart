import 'package:flutter/material.dart';
import '../widgets/Appbar.dart';

class IncidentDetailScreen extends StatefulWidget {
  final Map<String, String> report;

  const IncidentDetailScreen({super.key, required this.report});

  @override
  _IncidentDetailScreenState createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  List<String> assignedPersonnel = [];
  final List<String> personnel = [
    'Satpam 1',
    'Satpam 2',
    'Satpam 3',
    'Satpam 4',
    'Satpam 5',
    
    'Satpam 6'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Detail Incident',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIncidentDetailCard(),
            const SizedBox(height: 20),
            _buildAssignButton(),
            const SizedBox(height: 20),
            const Spacer(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // Membuat card detail insiden
  Widget _buildIncidentDetailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.report['title']}', style: _TextStyles.titleStyle),
          const SizedBox(height: 8),
          Text('${widget.report['subtitle']}',
              style: _TextStyles.subtitleStyle),
          const SizedBox(height: 8),
          Text('${widget.report['location']}',
              style: _TextStyles.subtitleStyle),
          const SizedBox(height: 8),
          Text('${widget.report['file']}', style: _TextStyles.subtitleStyle),
          const SizedBox(height: 8),
          if (assignedPersonnel.isNotEmpty) _buildAssignedPersonnel(),
        ],
      ),
    );
  }

  // Menampilkan daftar personil yang ditugaskan
  Widget _buildAssignedPersonnel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Satpam Ditugaskan:', style: _TextStyles.titleStyle),
        const SizedBox(height: 4),
        ...assignedPersonnel.map(
          (person) => Text(person, style: _TextStyles.subtitleStyle),
        ),
      ],
    );
  }

  // Membuat tombol "Tugaskan"
  Widget _buildAssignButton() {
    return SizedBox(
      width: double.infinity, // Ensure it takes the full width
      child: OutlinedButton(
        onPressed: _onAssignPersonnel,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('Tugaskan', style: _TextStyles.outlinedButtonStyle),
      ),
    );
  }

  // Menangani pemilihan personil yang ditugaskan
  Future<void> _onAssignPersonnel() async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MultiSelectPersonnel(personnel: personnel);
      },
    );
    if (result != null) {
      setState(() {
        assignedPersonnel = result;
      });
    }
  }

  // Membuat tombol "Tolak" dan "Konfirmasi"
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _onReject,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('Tolak', style: _TextStyles.buttonStyle),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('Konfirmasi', style: _TextStyles.buttonStyle),
          ),
        ),
      ],
    );
  }

  // Menangani penolakan laporan
  void _onReject() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan telah ditolak')),
    );
  }

  // Menangani konfirmasi laporan
  void _onConfirm() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tugas telah dikonfirmasi untuk ${assignedPersonnel.join(", ")}',
        ),
      ),
    );
  }
}

// Kelas untuk menyimpan gaya teks yang konsisten
class _TextStyles {
  static const TextStyle titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle subtitleStyle = TextStyle(
    color: Colors.black87,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle buttonStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle outlinedButtonStyle = TextStyle(
    color: Colors.blue,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

// Widget untuk memilih personil
class MultiSelectPersonnel extends StatefulWidget {
  final List<String> personnel;

  const MultiSelectPersonnel({super.key, required this.personnel});

  @override
  _MultiSelectPersonnelState createState() => _MultiSelectPersonnelState();
}

class _MultiSelectPersonnelState extends State<MultiSelectPersonnel> {
  final List<String> _selectedPersonnel = [];
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredPersonnel = widget.personnel
        .where((person) =>
            person.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSearchBar(), // Memanggil fungsi untuk membuat Search Bar
          const SizedBox(height: 10),
          _buildPersonnelList(
              filteredPersonnel), // Daftar personil yang difilter
          const SizedBox(height: 10),
          _buildSaveButton(), // Tombol simpan
        ],
      ),
    );
  }

  // Fungsi untuk membangun Search Bar dengan gaya yang diperbarui
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
                hintText: 'Cari Satpam',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value
                      .toLowerCase(); // Menyaring personil berdasarkan pencarian
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Membuat daftar personil yang bisa dipilih
  Widget _buildPersonnelList(List<String> filteredPersonnel) {
    return Expanded(
      child: ListView(
        children: filteredPersonnel.map((person) {
          return CheckboxListTile(
            title: Text(person,
                style: _TextStyles
                    .subtitleStyle), // Konsisten dengan gaya subtitle
            value: _selectedPersonnel.contains(person),
            onChanged: (isSelected) {
              setState(() {
                if (isSelected == true) {
                  _selectedPersonnel.add(person);
                } else {
                  _selectedPersonnel.remove(person);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  // Membuat tombol simpan dengan gaya yang konsisten
  Widget _buildSaveButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity, // Tombol akan memenuhi seluruh lebar ruang
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, _selectedPersonnel);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text('Simpan', style: _TextStyles.buttonStyle),
      ),
    );
  }
}
