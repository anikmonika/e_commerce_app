import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    Future<void> placeOrder() async {
      final orderId = 'ORDER-${Random().nextInt(10000)}';
      final orderData = {
        'orderId': orderId,
        'totalAmount': cartProvider.totalAmount,
        'cartItems': cartProvider.items.values.map((item) {
          return {
            'id': item.id,
            'title': item.title,
            'quantity': item.quantity,
            'price': item.price,
          };
        }).toList(),
        'date': Timestamp.now(),
      };

      // Add order to Firestore
      await FirebaseFirestore.instance.collection('orders').add(orderData);
      cartProvider.clearCart();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Order Confirmation')),
      body: FutureBuilder(
        future: placeOrder(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 100),
                SizedBox(height: 20),
                Text(
                  'Order Placed Successfully!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Order ID: ORDER-${Random().nextInt(10000)}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/landing'));
                  },
                  child: Text('Back to Home'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
