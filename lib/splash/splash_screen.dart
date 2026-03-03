import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pagnation_usecase/auth/providers/auth_provider.dart';
import 'package:pagnation_usecase/helper/routes.dart';
import 'package:pagnation_usecase/helper/image_asset_path.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //wait 5 secs and  then navgigate to home screen or login screen according to login state

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      final auth = context.read<AuthProvider>();
      final String route = auth.isLoggedIn ? Routes.home : Routes.login;
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // This is the loading animation for the splash screen.
          children: [Lottie.asset(ImageAssets.loading)],
        ),
      ),
      backgroundColor: Colors.blue.shade50,
    );
  }
}
