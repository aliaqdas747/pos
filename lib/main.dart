import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/utils/textTheme.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: TTextTheme.lightTextTheme,
        primaryColor: const Color(0xFF6C63FF),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
