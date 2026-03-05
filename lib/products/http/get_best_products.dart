import 'package:http/http.dart' as http;
import 'package:pagnation_usecase/helper/api_constants.dart';
import 'package:pagnation_usecase/products/constants/products_constants.dart';

Future<void> getBestSellerProducts() async {
  final uri = Uri.https(
    ApiConstants.prodbaseUrl,
    ApiConstants.productsEndpoint,
    {
      'seller_id': ProductsConstants.sellerId,
      'paginate': ProductsConstants.paginate,
    },
  );
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print("Error: ${response.statusCode}");
  }
}
