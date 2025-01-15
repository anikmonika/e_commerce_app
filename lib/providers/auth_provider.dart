import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  // Sign-in method with email and password (using phoneNumber as email)
  Future<void> signIn(String phoneNumber, String password) async {
    try {
      // Treating phone number as the email for login
      await _auth.signInWithEmailAndPassword(
        email: "$phoneNumber@example.com", // Treat phoneNumber as email
        password: password,
      );
      _user = _auth.currentUser;  // Save the current user
      notifyListeners();  // Notify listeners about the change
    } catch (e) {
      print("Error during sign-in: $e"); // Print error message for debugging
      throw Exception('Authentication failed');
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;  // Clear the current user
      notifyListeners();  // Notify listeners about the change
    } catch (e) {
      print("Error during sign-out: $e"); // Print error message for debugging
      throw Exception('Sign-out failed');
    }
  }

  // Register method with email and password (using phoneNumber as email)
  Future<void> register(String phoneNumber, String password) async {
    try {
      // Treating phone number as the email for registration
      await _auth.createUserWithEmailAndPassword(
        email: "$phoneNumber@example.com", // Treat phoneNumber as email
        password: password,
      );
      _user = _auth.currentUser;  // Save the current user
      notifyListeners();  // Notify listeners about the change
    } catch (e) {
      print("Error during registration: $e"); // Print error message for debugging
      throw Exception('Registration failed');
    }
  }
}