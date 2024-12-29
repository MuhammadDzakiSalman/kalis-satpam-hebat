import 'package:flutter/material.dart';
import '../../../widgets/Appbar.dart';
import '../LoginScreen.dart';

class CorporateForm extends StatefulWidget {
  const CorporateForm({super.key});

  @override
  _CorporateFormState createState() => _CorporateFormState();
}

class _CorporateFormState extends State<CorporateForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _yearFoundedController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _tibNibController = TextEditingController();
  final TextEditingController _companyLocationController = TextEditingController();

  // Method to handle form validation and submission
  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process registration (e.g., send data to an API or store it)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil!')),
      );
      
      // Navigate to LoginScreen after registration is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  // Common text field widget for reuse
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
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
            borderSide: BorderSide.none, // Removes default border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5), // Grey border with opacity
              width: 1, // Set the width of the border
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue, // Blue border when focused
              width: 1.5, // Set the width of the focused border
            ),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Corporate Form',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Go back to the previous screen
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                const Text(
                  'Register as Corporate',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Please fill in the required details to register',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),

                // Company Name TextField
                _buildTextField(
                  controller: _companyNameController,
                  label: 'Nama Perusahaan',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Perusahaan tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                // Business Type TextField
                _buildTextField(
                  controller: _businessTypeController,
                  label: 'Jenis Usaha',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis Usaha tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                // Year Founded TextField
                _buildTextField(
                  controller: _yearFoundedController,
                  label: 'Tahun Berdiri',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tahun Berdiri tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Tahun harus berupa angka';
                    }
                    return null;
                  },
                ),

                // Phone Number TextField
                _buildTextField(
                  controller: _phoneNumberController,
                  label: 'No. Telepon',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No. Telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                // TIB/NIB TextField
                _buildTextField(
                  controller: _tibNibController,
                  label: 'TIB/NIB',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'TIB/NIB tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                // Company Location TextField
                _buildTextField(
                  controller: _companyLocationController,
                  label: 'Lokasi Perusahaan',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lokasi Perusahaan tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}