import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kalis_satpam_hebat/auth/LoginScreen.dart';
import 'dart:io';
import '../../../widgets/Appbar.dart';

class SecurityForm extends StatefulWidget {
  const SecurityForm({super.key});

  @override
  _SecurityFormState createState() => _SecurityFormState();
}

class _SecurityFormState extends State<SecurityForm> {
  final _formKey = GlobalKey<FormState>();
  File? _ktpImage;
  File? _ktaImage;
  File? _sertifikatImage;  // Variabel untuk menyimpan file Sertifikat

  // Text controllers for the form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ktaNumberController = TextEditingController();

  // Date pickers
  DateTime? _birthDate;
  DateTime? _ktaExpiryDate;

  // Function to pick an image from gallery
  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (type == 'KTP') {
          _ktpImage = File(pickedFile.path);
        } else if (type == 'KTA') {
          _ktaImage = File(pickedFile.path);
        } else if (type == 'Sertifikat') {  // Menangani file Sertifikat
          _sertifikatImage = File(pickedFile.path);
        }
      });
    }
  }

  // Function to pick a date
  Future<void> _pickDate(BuildContext context, String type) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (type == 'birth') {
          _birthDate = pickedDate;
        } else if (type == 'ktaExpiry') {
          _ktaExpiryDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Form Security',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FormTitle(),
              const SizedBox(height: 30),

              // Foto input field
              _FileUploadSection(
                label: 'Upload Foto',
                onTap: () => _pickImage(ImageSource.gallery, 'Foto'),
                file: null,  // This will be replaced by the actual image picker implementation later
              ),
              const SizedBox(height: 10),

              _buildTextField(
                controller: _nameController,
                label: 'Nama Lengkap',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Nama tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _birthPlaceController,
                label: 'Tempat Lahir',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Tempat Lahir tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildDateField(
                label: 'Tanggal Lahir',
                selectedDate: _birthDate,
                onTap: () => _pickDate(context, 'birth'),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _domisiliController,
                label: 'Domisili',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Domisili tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _phoneController,
                label: 'No. Telepon',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'No Telepon tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _ktaNumberController,
                label: 'No. KTA',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'No. KTA tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildDateField(
                label: 'Masa Berlaku KTA',
                selectedDate: _ktaExpiryDate,
                onTap: () => _pickDate(context, 'ktaExpiry'),
              ),
              const SizedBox(height: 10),
              _FileUploadSection(
                label: 'Upload KTP',
                onTap: () => _pickImage(ImageSource.gallery, 'KTP'),
                file: _ktpImage,
              ),
              const SizedBox(height: 10),
              _FileUploadSection(
                label: 'Upload KTA',
                onTap: () => _pickImage(ImageSource.gallery, 'KTA'),
                file: _ktaImage,
              ),
              const SizedBox(height: 10),
              // Upload Sertifikat Section
              _FileUploadSection(
                label: 'Upload Sertifikat',  // Label untuk Sertifikat
                onTap: () => _pickImage(ImageSource.gallery, 'Sertifikat'),  // Menangani file Sertifikat
                file: _sertifikatImage,  // File Sertifikat
              ),
              const SizedBox(height: 30),
              _RegisterButton(onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Handle form submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registrasi berhasil!')),
                  );
                  // Navigate to MainScreen after registration
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),  // Arahkan ke MainScreen
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
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
      validator: validator,
    );
  }

  // Reusable date picker widget
  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.black38),
            hintText: selectedDate != null
                ? '${selectedDate.toLocal()}'.split(' ')[0]
                : 'Pilih Tanggal',
          ),
        ),
      ),
    );
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Register as Security',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Please fill in the required details to register',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class _FileUploadSection extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final File? file;

  const _FileUploadSection({
    required this.label,
    required this.onTap,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Center(
          child: file == null
              ? Text(
                  label,
                  style: const TextStyle(color: Colors.black38, fontSize: 16),
                )
              : Image.file(
                  file!,
                  height: 100,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RegisterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
