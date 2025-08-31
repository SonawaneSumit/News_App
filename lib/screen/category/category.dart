// ignore_for_file: camel_case_types

import 'package:algoocean_news/controllers/homeController.dart';
import 'package:algoocean_news/screen/HomeScreen/homeScreen.dart';
import 'package:algoocean_news/utils/apptheme.dart';
import 'package:flutter/foundation.dart';
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
          SizedBox(
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
                        crossAxisCount: 3, // 🔹 Two columns
                        crossAxisSpacing: 0, // space between columns
                        mainAxisSpacing: 11, // space between rows
                        childAspectRatio:
                            2.5, // 🔹 Adjust height/width of each item
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
                                    )
                                    //  const TextStyle(
                                    //   color: Colors.black87,
                                    //   fontSize: 12,
                                    //   fontWeight: FontWeight.w500,
                                    // ),
                                    ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            await homecontroller.newswithFilter(
                                ExerciseFilter.values[index].name);
                            Get.to(() => HomeScreen(category: true));
                            // homecontroller.newswithFilter("science");
                          },
                        ));
                      }),
            ),
          ),
          // Wrap(
          //   direction: Axis.horizontal,
          //   spacing: 7.0,
          //   children: ExerciseFilter.values.map((ExerciseFilter exercise) {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: FilterChip(
          //         padding: const EdgeInsets.all(17.0),
          //         label: Text(exercise.name),
          //         shape: RoundedRectangleBorder(
          //           side: BorderSide(color: Colors.grey.shade400),
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //         labelStyle: TextStyle(
          //           fontSize: 14,
          //           color: homecontroller.selectedFilter.value == exercise
          //               ? Colors.white
          //               : Colors.black,
          //         ),
          //         selected: /* filters.contains(exercise) */
          //             homecontroller.selectedFilter.value == exercise,
          //         showCheckmark: false,
          //         elevation: 3,
          //         selectedColor: Apptheme.primary.withOpacity(0.8),
          //         backgroundColor: Colors.white,
          //         onSelected: (bool selected) {
          //           // setState(() {
          //           homecontroller.selectedFilter.value =
          //               selected ? exercise : null;
          //           homecontroller.newswithFilter(exercise.name);
          //           print(exercise.name);
          //           // if (selected) {
          //           //   filters.add(exercise);
          //           // }
          //           // } else {
          //           //   filters.remove(exercise);
          //           // }
          //           // });
          //         },
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
