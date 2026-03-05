import 'package:pagnation_usecase/helper/api_constants.dart';
import 'package:pagnation_usecase/products/constants/products_constants.dart';

class GetBestProducts {
  static Uri get uri =>
      Uri.https(ApiConstants.prodbaseUrl, ApiConstants.productsEndpoint, {
        "seller_id": ProductsConstants.sellerId,
        "paginate": ProductsConstants.paginate,
      });
}
