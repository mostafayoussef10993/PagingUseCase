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
      productId: json['product_id'],
      sellerId: json['seller_id'],
      discount: json['discount'],
      priceAfterDiscount: json['price_after_discount'],

      title: json['product']?['title'],
      price: json['product']?['price'],

      storeName: json['seller']?['store_name'],

      photo: json['seller']?['photo'],
    );
  }
}
