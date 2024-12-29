// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String?> registerWithRole({
//     required String email,
//     required String password,
//     required String role,
//   }) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Menyimpan role di displayName sebagai contoh (bisa disimpan di Firestore untuk data lebih lengkap)
//       await userCredential.user?.updateDisplayName(role);

//       return 'User registered successfully';
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } catch (e) {
//       return 'An error occurred';
//     }
//   }
// }
