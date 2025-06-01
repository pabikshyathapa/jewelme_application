import 'package:flutter/material.dart';
import 'package:jewelme_application/theme/theme_data.dart';
import 'package:jewelme_application/view/splashscreen.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: SplashScreen(),
    );
  }
}