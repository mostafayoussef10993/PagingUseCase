import 'package:provider/provider.dart';
import 'package:pagnation_usecase/auth/providers/auth_provider.dart';
import 'package:pagnation_usecase/helper/api/api_constants.dart';
import 'package:pagnation_usecase/helper/dio/dio_client_model.dart';
import 'package:pagnation_usecase/products/provider/product_provider.dart';
import 'package:pagnation_usecase/products/provider/prod_repository.dart';
import 'package:pagnation_usecase/products/provider/prod_api_service.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),

    Provider(
      create: (_) =>
          ProductApiService(DioClient.create(ApiConstants.prodbaseUrl)),
    ),

    Provider(
      create: (context) => ProductRepository(context.read<ProductApiService>()),
    ),

    ChangeNotifierProvider(
      create: (context) => ProductProvider(context.read<ProductRepository>()),
    ),
  ];
}
