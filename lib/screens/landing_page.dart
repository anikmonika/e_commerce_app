import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_item.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _searchQuery = '';
  String _filter = 'A-Z';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products
        .where((prod) => prod.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (_filter == 'A-Z') {
      products.sort((a, b) => a.title.compareTo(b.title));
    } else if (_filter == 'Price Low-High') {
      products.sort((a, b) => a.price.compareTo(b.price));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: _filter,
                items: ['A-Z', 'Price Low-High']
                    .map((filter) => DropdownMenuItem(value: filter, child: Text(filter)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _filter = value!;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                return ProductItem(product: products[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
