import 'package:flutter/material.dart';
import 'package:jewelme_application/view/dashboard_page.dart';
import 'package:jewelme_application/view/login_page.dart';
import 'package:jewelme_application/view/signup_page.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}