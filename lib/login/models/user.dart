class User {
  final int? id;
  final int? type;
  final int? active;
  final String? name;
  final String? username;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final String? code;
  final double? balance;
  final int? sellerId;
  final int? commercialNum;
  final int? nationalId;
  final int? licenseNum;
  final int? locationId;
  final List<int>? customerGroupsIds;
  final int? walletId;
  final int? loginMethod;
  final int? cartItemsCount;
  final int? unreadNotificationsCount;

  User({
    this.id,
    this.type,
    this.active,
    this.name,
    this.username,
    this.contactPerson,
    this.email,
    this.phone,
    this.code,
    this.balance,
    this.sellerId,
    this.commercialNum,
    this.nationalId,
    this.licenseNum,
    this.locationId,
    this.customerGroupsIds,
    this.walletId,
    this.loginMethod,
    this.cartItemsCount,
    this.unreadNotificationsCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      type: json['type'] as int?,
      active: json['active'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      contactPerson: json['contact_person'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      code: json['code'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      sellerId: json['seller_id'] as int?,
      commercialNum: json['commercial_num'] as int?,
      nationalId: json['national_id'] as int?,
      licenseNum: json['license_num'] as int?,
      locationId: json['location_id'] as int?,
      customerGroupsIds: json['customer_groups_ids'] != null
          ? List<int>.from(
              (json['customer_groups_ids'] as List<dynamic>).map(
                (e) => (e as num).toInt(),
              ),
            )
          : null,
      walletId: json['wallet_id'] as int?,
      loginMethod: json['login_method'] as int?,
      cartItemsCount: json['cart_items_count'] as int?,
      unreadNotificationsCount: json['unread_notifications_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'active': active,
      'name': name,
      'username': username,
      'contact_person': contactPerson,
      'email': email,
      'phone': phone,
      'code': code,
      'balance': balance,
      'seller_id': sellerId,
      'commercial_num': commercialNum,
      'national_id': nationalId,
      'license_num': licenseNum,
      'location_id': locationId,
      'customer_groups_ids': customerGroupsIds,
      'wallet_id': walletId,
      'login_method': loginMethod,
      'cart_items_count': cartItemsCount,
      'unread_notifications_count': unreadNotificationsCount,
    };
  }
}
