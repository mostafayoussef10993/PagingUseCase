class Product {
  final int? productId;
  final int? sellerId;
  final int? discount;
  final int? priceAfterDiscount;
  final String? title;
  final int? price;
  final String? storeName;
  final String? photo;

  Product({
    required this.productId,
    required this.sellerId,
    required this.discount,
    required this.priceAfterDiscount,
    required this.title,
    required this.price,
    required this.storeName,
    required this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: _toInt(json['product_id']),
      sellerId: _toInt(json['seller_id']),
      discount: _toInt(json['discount']),
      priceAfterDiscount: _toInt(json['price_after_discount']),
      title: json['product']?['title'],
      price: _toInt(json['product']?['price']),
      storeName: json['seller']?['store_name'],
      photo: json['seller']?['photo'],
    );
  }

  // Helper function to convert dynamic values to int
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
