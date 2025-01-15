import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => [..._products];

  // Fetch products in real-time from Firestore
  Future<void> fetchProductsRealTime() async {
    // Listen to the changes in Firestore's 'products' collection
    FirebaseFirestore.instance.collection('products').snapshots().listen(
      (snapshot) {
        _products.clear();  // Clear existing list
        for (var doc in snapshot.docs) {
          // Convert each Firestore document to a Product object
          _products.add(Product.fromFirestore(doc));
        }
        notifyListeners();  // Notify listeners to update UI
      },
      onError: (error) {
        // Handle the error appropriately
        print('Error fetching products: $error');
      },
    );
  }

  // Add a new product to Firestore
  Future<void> addProduct(Product product) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('products').doc();  // Auto-generated doc ID
      await docRef.set(product.toMap());  // Save the product data to Firestore
    } catch (error) {
      // Handle the error appropriately
      print('Error adding product: $error');
    }
  }
}