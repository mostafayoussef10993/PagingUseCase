// The ApiEndpoints used through the app

class ApiConstants {
  //base url
  static const String baseUrl = 'https://cp-dev.isupply.tech/api';
  //login
  static const String loginEndpoint = "/login";
  //identifier, password, type keys for login
  static const String identifierKey = "identifier";
  static const String passwordKey = "password";
  static const String typeKey = "type";
  //get products
  static const String getProducts =
      'https://cp-dev.isupply.tech/api/v1/products/best-seller?seller_id=22833';
}
