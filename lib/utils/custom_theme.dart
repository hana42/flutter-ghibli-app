import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(Color.fromARGB(255, 11, 11, 11)),
    )),
    scaffoldBackgroundColor: Color.fromARGB(255, 11, 11, 11),
    backgroundColor: Colors.white,
    splashColor: Colors.black.withOpacity(0.0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        elevation: 0,
        selectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        backgroundColor: Color.fromARGB(255, 11, 11, 11),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade300,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white)),
    primaryColor: Colors.grey,
    dividerColor: Colors.white70,
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.grey),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      hintStyle: const TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue)),
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 2),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20));
        }),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(300, 60),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 151, 202, 223)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
  );
}
