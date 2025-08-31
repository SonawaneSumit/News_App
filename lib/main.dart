import 'package:algoocean_news/screen/splashScreen.dart';
import 'package:algoocean_news/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Algoocean News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          // backgroundColor: Apptheme.primary,
          showUnselectedLabels: true,
        ),
      ),
      home: splash_screen(),
    );
  }
}
