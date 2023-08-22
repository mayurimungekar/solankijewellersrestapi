import 'package:flutter/material.dart';
import 'package:solanki/pages/login_page.dart';
import 'package:solanki/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.orangeAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orangeAccent),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 22.0, color: Colors.orange),
          displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.blueAccent)
        )
      ),
      home: const LoginPage(),
    );
  }
}


