// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../../../widgets/Appbar.dart';

// import '../LoginScreen.dart';  // Adjust this import path

// class PoliceForm extends StatefulWidget {
//   const PoliceForm({super.key});

//   @override
//   _PoliceFormState createState() => _PoliceFormState();
// }

// class _PoliceFormState extends State<PoliceForm> {
//   final _formKey = GlobalKey<FormState>();
//   File? _ktpImage;
//   File? _ktaImage;
//   File? _photoImage; // New variable to store the photo image

//   // Text controllers for the form fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _birthPlaceController = TextEditingController();
//   final TextEditingController _domisiliController = TextEditingController();
//   final TextEditingController _positionController = TextEditingController();
//   final TextEditingController _ktaNumberController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController(); // Password controller

//   // Date pickers
//   DateTime? _birthDate;
//   DateTime? _ktaExpiryDate;

//   // To show/hide password
//   bool _isPasswordVisible = false;

//   // Function to pick an image from gallery
//   Future<void> _pickImage(ImageSource source, String type) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         if (type == 'KTP') {
//           _ktpImage = File(pickedFile.path);
//         } else if (type == 'KTA') {
//           _ktaImage = File(pickedFile.path);
//         } else if (type == 'photo') {
//           // New case for photo
//           _photoImage = File(pickedFile.path);
//         }
//       });
//     }
//   }

//   // Function to pick a date
//   Future<void> _pickDate(BuildContext context, String type) async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(3000),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         if (type == 'birth') {
//           _birthDate = pickedDate;
//         } else if (type == 'ktaExpiry') {
//           _ktaExpiryDate = pickedDate;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         showNotificationIcon: false,
//         title: 'Form Police',
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const _FormTitle(),
//               const SizedBox(height: 30),
//               // Photo upload section added here
//               _FileUploadSection(
//                 label: 'Upload Photo',
//                 onTap: () => _pickImage(ImageSource.gallery, 'photo'),
//                 file: _photoImage,
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _nameController,
//                 label: 'Nama Lengkap',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'Nama tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _phoneController, // Moved phone input here
//                 label: 'No. Telepon',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'No Telepon tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildDateField(
//                 label: 'Tanggal Lahir',
//                 selectedDate: _birthDate,
//                 onTap: () => _pickDate(context, 'birth'),
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _birthPlaceController,
//                 label: 'Tempat Lahir',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'Tempat Lahir tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _domisiliController,
//                 label: 'Domisili',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'Domisili tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _positionController,
//                 label: 'Jabatan',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'Jabatan tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildTextField(
//                 controller: _ktaNumberController,
//                 label: 'No. KTA',
//                 validator: (value) {
//                   if (value == null || value.isEmpty)
//                     return 'No. KTA tidak boleh kosong';
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 10),
//               _buildDateField(
//                 label: 'Masa Berlaku KTA',
//                 selectedDate: _ktaExpiryDate,
//                 onTap: () => _pickDate(context, 'ktaExpiry'),
//               ),
//               const SizedBox(height: 10),
//               // KTA Upload Section
//               _FileUploadSection(
//                 label: 'Upload KTA',
//                 onTap: () => _pickImage(ImageSource.gallery, 'KTA'),
//                 file: _ktaImage,
//               ),
//               const SizedBox(height: 10),
//               // KTP Upload Section (now below KTA upload)
//               _FileUploadSection(
//                 label: 'Upload KTP',
//                 onTap: () => _pickImage(ImageSource.gallery, 'KTP'),
//                 file: _ktpImage,
//               ),
//               const SizedBox(height: 10),
//               _buildPasswordField(),
//               const SizedBox(height: 30),
//               _RegisterButton(onPressed: () {
//                 if (_formKey.currentState?.validate() ?? false) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Registrasi berhasil!')),
//                   );

//                   // Navigate to the LoginScreen after a successful registration
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual LoginScreen
//                   );
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Reusable text field widget
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.blue, width: 2),
//         ),
//         errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
//       ),
//       validator: validator,
//     );
//   }

//   // Password input field with visibility toggle
//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: _passwordController,
//       obscureText: !_isPasswordVisible,
//       decoration: InputDecoration(
//         labelText: 'Password',
//         labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.blue, width: 2),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//             color: Colors.black38,
//           ),
//           onPressed: () {
//             setState(() {
//               _isPasswordVisible = !_isPasswordVisible;
//             });
//           },
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty)
//           return 'Password tidak boleh kosong';
//         return null;
//       },
//     );
//   }

//   // Reusable date picker widget
//   Widget _buildDateField({
//     required String label,
//     required DateTime? selectedDate,
//     required VoidCallback onTap,
//   }) {
//     final TextEditingController _dateController = TextEditingController();

//     // Update the controller when the date is picked
//     if (selectedDate != null) {
//       _dateController.text = '${selectedDate.toLocal()}'.split(' ')[0];  // Format the date to 'yyyy-MM-dd'
//     }

//     return GestureDetector(
//       onTap: onTap,
//       child: AbsorbPointer(
//         child: TextFormField(
//           controller: _dateController,
//           decoration: InputDecoration(
//             labelText: label,
//             labelStyle: const TextStyle(fontSize: 14, color: Colors.black38),
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Colors.blue, width: 2),
//             ),
//             suffixIcon: const Icon(Icons.calendar_today, color: Colors.black38),
//             hintText: selectedDate != null
//                 ? '${selectedDate.toLocal()}'.split(' ')[0]
//                 : 'Pilih Tanggal',
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FormTitle extends StatelessWidget {
//   const _FormTitle();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text(
//           'Register as Police',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           'Please fill in the required details to register',
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }

// class _FileUploadSection extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;
//   final File? file;

//   const _FileUploadSection({
//     required this.label,
//     required this.onTap,
//     required this.file,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 28),
//         child: Center(
//           child: file == null
//               ? Text(
//                   label,
//                   style: const TextStyle(color: Colors.black38, fontSize: 16),
//                 )
//               : Image.file(
//                   file!,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//         ),
//       ),
//     );
//   }
// }

// class _RegisterButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const _RegisterButton({required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: const Text(
//           'Register',
//           style: TextStyle(
//               color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/Appbar.dart';
import '../LoginScreen.dart';

class PoliceForm extends StatefulWidget {
  const PoliceForm({super.key});

  @override
  _PoliceFormState createState() => _PoliceFormState();
}

class _PoliceFormState extends State<PoliceForm> {
  final _formKey = GlobalKey<FormState>();
  File? _ktpImage;
  File? _ktaImage;
  File? _photoImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _ktaNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  DateTime? _birthDate;
  DateTime? _ktaExpiryDate;

  bool _isPasswordVisible = false;

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (type == 'KTP') {
          _ktpImage = File(pickedFile.path);
        } else if (type == 'KTA') {
          _ktaImage = File(pickedFile.path);
        } else if (type == 'photo') {
          _photoImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _pickDate(BuildContext context, String type) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
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

  Future<void> _registerPolice() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create a request body
      var request = http.MultipartRequest('POST', Uri.parse('https://b0d9-103-90-66-18.ngrok-free.app/api/police/register'));

      // Add text fields
      request.fields['nama'] = _nameController.text;
      request.fields['no_telepon'] = _phoneController.text;
      request.fields['password'] = _passwordController.text;
      request.fields['tanggal_lahir'] = _birthDate?.toIso8601String() ?? '';
      request.fields['tempat_lahir'] = _birthPlaceController.text;
      request.fields['domisili'] = _domisiliController.text;
      request.fields['jabatan'] = _positionController.text;
      request.fields['no_kta'] = _ktaNumberController.text;
      request.fields['masa_berlaku_kta'] = _ktaExpiryDate?.toIso8601String() ?? '';

      // Add images
      if (_photoImage != null) {
        request.files.add(await http.MultipartFile.fromPath('foto_upload', _photoImage!.path));
      }
      if (_ktaImage != null) {
        request.files.add(await http.MultipartFile.fromPath('kta_upload', _ktaImage!.path));
      }
      if (_ktpImage != null) {
        request.files.add(await http.MultipartFile.fromPath('ktp_upload', _ktpImage!.path));
      }

      try {
        // Send the request
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi berhasil!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to Login screen
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi gagal!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showNotificationIcon: false,
        title: 'Form Police',
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
              _FileUploadSection(
                label: 'Upload Photo',
                onTap: () => _pickImage(ImageSource.gallery, 'photo'),
                file: _photoImage,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _nameController,
                label: 'Nama Lengkap',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _phoneController,
                label: 'No. Telepon',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'No Telepon tidak boleh kosong';
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
                controller: _birthPlaceController,
                label: 'Tempat Lahir',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Tempat Lahir tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _domisiliController,
                label: 'Domisili',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Domisili tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _positionController,
                label: 'Jabatan',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Jabatan tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _ktaNumberController,
                label: 'No. KTA',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'No. KTA tidak boleh kosong';
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
                label: 'Upload KTA',
                onTap: () => _pickImage(ImageSource.gallery, 'KTA'),
                file: _ktaImage,
              ),
              const SizedBox(height: 10),
              _FileUploadSection(
                label: 'Upload KTP',
                onTap: () => _pickImage(ImageSource.gallery, 'KTP'),
                file: _ktpImage,
              ),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 30),
              _RegisterButton(onPressed: _registerPolice),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
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
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black38,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password tidak boleh kosong';
        return null;
      },
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    final TextEditingController _dateController = TextEditingController();
    if (selectedDate != null) {
      _dateController.text = '${selectedDate.toLocal()}'.split(' ')[0];
    }

    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: _dateController,
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
          ),
        ),
      ),
    );
  }

  Widget _RegisterButton({required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text('Register', style: TextStyle(fontSize: 16)),
    );
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Daftar sebagai Polisi',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: Colors.blue),
                const SizedBox(width: 10),
                Text(file == null ? 'Pilih File' : file!.path.split('/').last),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
