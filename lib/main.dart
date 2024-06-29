import 'package:flutter/material.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/utils/textTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: TTextTheme.lightTextTheme,
        primaryColor: Color(0xFF6C63FF),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
