class User {
  final int id;
  final int type;
  final int active;
  final String name;
  final String username;
  final String contactPerson;
  final String email;
  final String phone;
  final String code;
  final double balance;
  final int? sellerId;
  final int commercialNum;
  final int? nationalId;
  final int? licenseNum;
  final int locationId;
  final List<int> customerGroupsIds;
  final int walletId;
  final int loginMethod;
  final int cartItemsCount;
  final int unreadNotificationsCount;

  User({
    required this.id,
    required this.type,
    required this.active,
    required this.name,
    required this.username,
    required this.contactPerson,
    required this.email,
    required this.phone,
    required this.code,
    required this.balance,
    required this.sellerId,
    required this.commercialNum,
    required this.nationalId,
    required this.licenseNum,
    required this.locationId,
    required this.customerGroupsIds,
    required this.walletId,
    required this.loginMethod,
    required this.cartItemsCount,
    required this.unreadNotificationsCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      type: json['type'],
      active: json['active'],
      name: json['name'],

      username: json['username'],
      contactPerson: json['contact_person'],
      email: json['email'],
      phone: json['phone'],
      code: json['code'],
      balance: (json['balance'] as num).toDouble(),
      sellerId: json['seller_id'],
      commercialNum: json['commercial_num'],
      nationalId: json['national_id'],
      licenseNum: json['license_num'],
      locationId: json['location_id'],
      customerGroupsIds: List<int>.from(json['customer_groups_ids']),
      walletId: json['wallet_id'],
      loginMethod: json['login_method'],

      cartItemsCount: json['cart_items_count'],
      unreadNotificationsCount: json['unread_notifications_count'],
    );
  }
}
