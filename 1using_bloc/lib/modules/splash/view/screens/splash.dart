import 'package:flutter/material.dart';
import 'package:kequele/shared/routes/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              AppRouter.go(context: context, path: AppPages.login.path);
            },
            child: Text("Splash")),
      ),
    );
  }
}
