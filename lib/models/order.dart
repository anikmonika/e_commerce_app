import 'cart_item.dart'; // Ensure you import CartItem class

class Order {
  final String id;
  final double totalAmount;
  final List<CartItem> cartItems;
  final DateTime date;

  Order({
    required this.id,
    required this.totalAmount,
    required this.cartItems,
    required this.date,
  });

  // Convert Order object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalAmount': totalAmount,
      'cartItems': cartItems
          .map((item) => {
                'id': item.id,
                'title': item.title,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList(),
      'date': date.toIso8601String(),
    };
  }

  // Convert Map to Order object
  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      totalAmount: map['totalAmount'] as double,
      cartItems: (map['cartItems'] as List<dynamic>? ?? [])
          .map((item) => CartItem(
                id: item['id'] as String,
                title: item['title'] as String,
                price: item['price'] as double,
                quantity: item['quantity'] as int,
              ))
          .toList(),
      date: DateTime.parse(map['date'] as String),
    );
  }
}
