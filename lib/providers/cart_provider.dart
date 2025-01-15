import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => [..._cartItems];

  // Add a product to the cart
  void addProduct(Product product) {
    _cartItems.add(product);
    notifyListeners();  // Notify listeners to update UI
  }

  // Remove a product from the cart
  void removeProduct(Product product) {
    _cartItems.remove(product);
    notifyListeners();  // Notify listeners to update UI
  }

  // Clear all products from the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();  // Notify listeners to update UI
  }

  // Get the total price of the cart
  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}