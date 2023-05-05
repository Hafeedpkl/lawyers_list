import 'package:flutter/material.dart';
import 'package:lawyers_list/controller/sign_in_provider.dart';
import 'package:lawyers_list/controller/splash_screen_provider.dart';
import 'package:lawyers_list/views/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
