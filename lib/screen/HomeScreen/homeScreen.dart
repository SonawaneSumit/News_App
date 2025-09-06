import 'package:new_york_news/controllers/homeController.dart';
import 'package:new_york_news/screen/Article/articleWebView.dart';
import 'package:new_york_news/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final bool category;
  const HomeScreen({super.key, this.category = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homecontroller = Get.put(HomeController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: widget.category == true
          ? AppBar(
              backgroundColor: Apptheme.primary,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Image.asset(
                "assets/NYT_Logo.png",
                color: Colors.white,
                alignment: Alignment.center,
                // height: 120,
                width: 140,
                fit: BoxFit.contain,
              ),
            )
          : null,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.black,
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => homecontroller.loadingD.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Apptheme.primary,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: homecontroller.results.length,
                      itemBuilder: (context, index) {
                        print(
                            "Building item at index: ${homecontroller.loadingD.value}");
                        final news = homecontroller.results[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          shadowColor: Colors.black,
                          elevation: 5,
                          // clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        news["multimedia"] != null
                                            ? news["multimedia"][0]["url"]
                                            : "",
                                        height: height * 0.19,
                                        width: width * 0.29,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child,
                                                loadingProgress) =>
                                            loadingProgress == null
                                                ? child
                                                : SizedBox(
                                                    height: 120,
                                                    width: 120,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                        color: Apptheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.loyalty_outlined),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Apptheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 6.0,
                                                          left: 6.0,
                                                          top: 2.0,
                                                          bottom: 2.0),
                                                  child: Text(
                                                    news["section"] ?? "",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(news["title"] ?? "No Title",
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => ArticleWebView(
                                                    url: news["url"],
                                                  ));
                                            },
                                            child: Text(
                                              "Read More",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Apptheme.textcolor),
                                              maxLines: 3,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(Icons.remove),
                                              Expanded(
                                                child: Text(
                                                  news["byline"] ?? "No Author",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
