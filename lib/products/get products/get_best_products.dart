import 'package:pagnation_usecase/helper/api/api_constants.dart';
import 'package:pagnation_usecase/products/constants/products_constants.dart';

// a helper that builds the API request for getting products.
class GetBestProducts {
  static String get endpoint => ApiConstants.productsEndpoint;

  static Map<String, dynamic> getQueryParameters({String? cursor}) => {
    "seller_id": ProductsConstants.sellerId,
    "paginate": ProductsConstants.paginate,
    if (cursor != null) "cursor": cursor,
  };
}
