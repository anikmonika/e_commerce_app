class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => [..._products];

  // Add a new product to Firestore
  Future<void> addProduct({
    required String title,
    required String description,
    required double price,
    required int stock,
    required String imageUrl,
  }) async {
    try {
      final newProduct = Product(
        id: DateTime.now()
            .toString(), // Generate a unique ID (you can modify it to match your needs)
        title: title,
        description: description,
        price: price,
        stock: stock,
        imageUrl: imageUrl,
      );

      // Add the product to Firestore (or locally if not using Firestore)
      final docRef = FirebaseFirestore.instance.collection('products').doc();
      await docRef.set(newProduct
          .toMap()); // Ensure that toMap() is properly defined in your Product class

      // Optionally, add the product to the local list (not mandatory for Firestore)
      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error; // Handle any errors that might occur while adding the product
    }
  }
}
