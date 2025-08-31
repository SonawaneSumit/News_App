// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'package:algoocean_news/screen/Article/artticleList.dart';
import 'package:algoocean_news/screen/HomeScreen/homeScreen.dart';
import 'package:algoocean_news/screen/category/category.dart';
import 'package:algoocean_news/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int page_index = 0;
  final List _pages = [
    HomeScreen(),
    const categoryScreen(),
    const article_list(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Apptheme.primary,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              "assets/App_logo.png",
              color: Colors.white,
              alignment: Alignment.center,
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
            Text("Algoocean News",
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      // drawer: Drawer(),
      body: SafeArea(child: _pages[page_index]),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        elevation: 50,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
        ],
        currentIndex: page_index,
        onTap: (int index) => setState(() {
          page_index = index;
          print("$page_index");
        }),
      ),
    );
  }
}
