// ...existing code...
import 'package:flutter/material.dart';
import 'package:pagnation_usecase/providers/auth_provider.dart';
import 'package:provider/provider.dart';
// adjust this import path if your AuthProvider is located elsewhere
import 'package:pagnation_usecase/presentation/splash/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
