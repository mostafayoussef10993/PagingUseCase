import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pagnation_usecase/presentation/login/login_screen.dart';
import 'package:pagnation_usecase/utils/image_asset_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //wait 5 secs and  then navgigate to login screen

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
          ), //TODO: navigation routes
        );
      }
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
