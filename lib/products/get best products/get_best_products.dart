import 'package:pagnation_usecase/helper/api/api_constants.dart';
import 'package:pagnation_usecase/products/constants/products_constants.dart';

class GetBestProducts {
  static String get endpoint => ApiConstants.productsEndpoint;
  
  static Map<String, dynamic> get queryParameters => {
    "seller_id": ProductsConstants.sellerId,
    "paginate": ProductsConstants.paginate,
  };
}
