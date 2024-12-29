import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // For file picker

class CreateIncidentModal extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController jumlahSecurityController;
  final TextEditingController tanggalMulaiController;
  final TextEditingController tanggalSelesaiController;
  final TextEditingController lampiranController;
  final Function onCreateIncident;

  const CreateIncidentModal({
    Key? key,
    required this.formKey,
    required this.jumlahSecurityController,
    required this.tanggalMulaiController,
    required this.tanggalSelesaiController,
    required this.lampiranController,
    required this.onCreateIncident,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      title: Text('Create New Incident', style: titleStyle),
      contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Jumlah Security TextFormField
                _buildTextFormField(
                  controller: jumlahSecurityController,
                  label: 'Jumlah Security',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of security personnel';
                    }
                    return null;
                  },
                ),
                // Tanggal Mulai Date Picker
                _buildDatePicker(
                  controller: tanggalMulaiController,
                  label: 'Tanggal Mulai',
                  context: context,
                ),
                // Tanggal Selesai Date Picker
                _buildDatePicker(
                  controller: tanggalSelesaiController,
                  label: 'Tanggal Selesai',
                  context: context,
                ),
                // Lampiran File Upload
                _buildFilePicker(
                  controller: lampiranController,
                  label: 'Lampiran (File Upload)',
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        // Action Buttons (Cancel and Create Incident) with gap only between buttons
        Row(
          children: [
            // Cancel Button
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[700]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                ),
              ),
            ),
            SizedBox(width: 10), // Only gap between buttons
            // Create Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    onCreateIncident();
                    Navigator.pop(context);
                  }
                },
                child: Text('Create'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        validator: validator,
      ),
    );
  }

  // Date Picker for Tanggal Mulai and Tanggal Selesai using showDatePicker
  Widget _buildDatePicker({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            controller.text = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
          }
        },
      ),
    );
  }

  // File Picker for Lampiran with icon inside the field
  Widget _buildFilePicker({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                controller.text = result.files.single.name; // Display selected file name
              }
            },
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        readOnly: true,
      ),
    );
  }
}
