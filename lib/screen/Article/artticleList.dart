// ignore_for_file: camel_case_types

import 'package:new_york_news/controllers/articleController.dart';
import 'package:new_york_news/screen/Article/articleWebView.dart';
import 'package:new_york_news/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class article_list extends StatefulWidget {
  const article_list({super.key});

  @override
  State<article_list> createState() => _article_listState();
}

class _article_listState extends State<article_list> {
  var articleController = Get.put(article_controller());

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "No Date";

    try {
      DateTime dateTime = DateTime.parse(dateStr); // Parse ISO8601 string
      return DateFormat("dd MMM yyyy").format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.appbarcolor,
      body: RefreshIndicator(
        color: Apptheme.primary,
        onRefresh: () async {
          await articleController.newswithFilter("");
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchAnchor(builder: (
                BuildContext context,
                SearchController controller,
              ) {
                return SearchBar(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  hintText: "Search Articles",
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    articleController.newswithFilter(value);
                  },
                );
              }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List.empty();
              }),
            ),
            Obx(
              () => /* child: */ Expanded(
                child: articleController.loadingD.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Apptheme.primary,
                        ),
                      )
                    : ListView.builder(
                        controller: articleController.scroll_Controller,
                        itemCount: articleController.results.length +
                            (articleController.loadingPage.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == articleController.results.length) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Apptheme.primary,
                              )),
                            );
                          }
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 5,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black54, // fade color
                                      ],
                                    ).createShader(bounds),
                                    blendMode: BlendMode.xor,
                                    child: Image.network(
                                      articleController.results[index]
                                          ["multimedia"]["default"]["url"],
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        articleController.results[index]
                                            ["headline"]["main"],
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: articleController
                                                            .results[index]
                                                        ["abstract"] ??
                                                    "",
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                )),
                                            const TextSpan(text: " "),
                                            WidgetSpan(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(() => ArticleWebView(
                                                        url: articleController
                                                                .results[index]
                                                            ["web_url"],
                                                      ));
                                                },
                                                child: Text(
                                                  "Read More",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Apptheme.textcolor,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.remove),
                                          Expanded(
                                            child: Text(
                                              articleController.results[index]
                                                      ["byline"]["original"] ??
                                                  "No Author",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _formatDate(articleController
                                                  .results[index]["pub_date"]),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
