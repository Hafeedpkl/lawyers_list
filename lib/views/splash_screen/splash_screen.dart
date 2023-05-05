import 'package:flutter/material.dart';
import 'package:lawyers_list/controller/splash_screen_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SplashScreenProvider>(context, listen: false)
          .splashTimer(context);
    });

    return Scaffold(
      body: Center(child: Image.asset("assets/images/icon.png")),
    );
  }
}
