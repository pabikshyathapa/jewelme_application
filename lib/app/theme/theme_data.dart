import 'package:flutter/material.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
   useMaterial3: false,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFFE04B4B)),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 17),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontFamily: 'Poppins Bold',
            fontSize: 19,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    ),
     appBarTheme: const AppBarTheme(
      centerTitle: true,
      color:Colors.blueGrey,
      elevation: 4,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins Bold',
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
     ),

  );
}