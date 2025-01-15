import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl, fit: BoxFit.cover, width: 50, height: 50),
      title: Text(product.title),
      subtitle: Text('\$${product.price}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(productId: product.id),
          ),
        );
      },
    );
  }
}
