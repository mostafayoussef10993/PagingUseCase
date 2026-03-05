// The ApiEndpoints used through the app

class ApiConstants {
  //authentication base url
  static const String authbaseUrl = 'https://cp-dev.isupply.tech/api';
  //login
  static const String loginEndpoint = "/login";
  //identifier, password, type keys for login
  static const String identifierKey = "identifier";
  static const String passwordKey = "password";
  static const String typeKey = "type";
  // products base url
  static const String prodbaseUrl = 'https://cp-dev.isupply.tech/api/v1/';
  // products endpoint
  static const String productsEndpoint = 'products/best-seller';
}
