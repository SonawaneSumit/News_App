// ignore_for_file: camel_case_types

import 'package:algoocean_news/controllers/homeController.dart';
import 'package:algoocean_news/screen/HomeScreen/homeScreen.dart';
import 'package:algoocean_news/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class categoryScreen extends StatefulWidget {
  const categoryScreen({super.key});

  @override
  State<categoryScreen> createState() => _categoryScreenState();
}

class _categoryScreenState extends State<categoryScreen> {
  final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.appbarcolor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                color: Colors.white,
                padding: const EdgeInsets.all(9),
                child: Text("News Categories",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Obx(
            // child:
            () => Expanded(
              child: homecontroller.loadingD.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Apptheme.primary,
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: ExerciseFilter.values.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 11,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        return Center(
                            child: InkWell(
                          child: Container(
                            height: 40,
                            width: 100,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                    ExerciseFilter.values[index].name
                                        .toUpperCase(),
                                    style: GoogleFonts.robotoCondensed(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ),
                          onTap: () async {
                            await homecontroller.newswithFilter(
                                ExerciseFilter.values[index].name);
                            Get.to(() => HomeScreen(category: true));
                          },
                        ));
                      }),
            ),
          ),
        ],
      ),
    );
  }
}
