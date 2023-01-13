class Order {
  final String description;
  final int price;
  final String customerName;
  final DateTime timestamp;

  Order(
      {required this.description,
      required this.price,
      required this.customerName,
      required this.timestamp});

  factory Order.fromRTDB(Map<String, dynamic> data) {
    return Order(
        description: data['description'] ?? 'Drink',
        price: data['price'] ?? 0,
        customerName: data['customer'] ?? 'Unknown',
        timestamp: (data['time'] != null)
            ? DateTime.fromMillisecondsSinceEpoch(data['time'])
            : DateTime.now());
  }
}
