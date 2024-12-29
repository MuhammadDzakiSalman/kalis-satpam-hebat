// lib/services/auth_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AuthService {
  static const String baseUrl = 'YOUR_API_BASE_URL'; // Ganti dengan URL API Anda

  static Future<Map<String, dynamic>> registerPolice({
    required String name,
    required String phone,
    required DateTime birthDate,
    required String birthPlace,
    required String domicile,
    required String position,
    required String ktaNumber,
    required DateTime ktaExpiryDate,
    required String password,
    required File photoFile,
    required File ktaFile,
    required File ktpFile,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/auth/register/police'),
      );

      // Add text fields
      request.fields.addAll({
        'nama': name,
        'no_telepon': phone,
        'tanggal_lahir': birthDate.toIso8601String(),
        'tempat_lahir': birthPlace,
        'domisili': domicile,
        'jabatan': position,
        'no_kta': ktaNumber,
        'masa_berlaku_kta': ktaExpiryDate.toIso8601String(),
        'password': password,
        'role_id': '1', // Assuming 1 is for police role
      });

      // Add files
      request.files.add(await http.MultipartFile.fromPath(
        'foto_path',
        photoFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'kta_path',
        ktaFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'ktp_path',
        ktpFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonResponse['data'],
          'message': 'Registration successful',
        };
      } else {
        return {
          'success': false,
          'message': jsonResponse['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: ${e.toString()}',
      };
    }
  }
}