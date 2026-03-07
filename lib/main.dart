import 'package:flutter/material.dart';
import 'package:pagnation_usecase/helper/providers/app_providers.dart';
import 'package:pagnation_usecase/helper/routes.dart';
import 'package:pagnation_usecase/home/home_screen.dart';
import 'package:pagnation_usecase/login/screen/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:pagnation_usecase/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: AppProviders.providers, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
