// ignore_for_file: camel_case_types, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class article_controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    newswithFilter("", loadMore: false);
    scroll_Controller.addListener(_onScroll);
  }

  @override
  void onClose() {
    super.onClose();
    scroll_Controller.dispose();
  }

  void _onScroll() {
    if (scroll_Controller.position.pixels >=
            scroll_Controller.position.maxScrollExtent - 200 &&
        !loadingPage.value &&
        hasMore.value) {
      print("load more data");
      newswithFilter(currentQuery.value, loadMore: true);
    }
  }

  var currentQuery = "".obs;
  var loadingD = false.obs;
  var loadingPage = false.obs;
  List<dynamic> results = [].obs;
  var hasMore = true.obs;
  var page = 0;

  final ScrollController scroll_Controller = ScrollController();

  Future<void> newswithFilter(var searchitem, {bool loadMore = false}) async {
    bool isNewSearch = searchitem != currentQuery.value;

    if (isNewSearch) {
      page = 0;
      results.clear();
      hasMore.value = true;
    }

    currentQuery.value = searchitem;

    if (loadMore) {
      loadingPage.value = true;
    } else {
      loadingD.value = true;
    }

    print("search item $searchitem page $page $loadMore");
    try {
      var url = Uri.parse(
          'https://api.nytimes.com/svc/search/v2/articlesearch.json?page=$page&q=$searchitem&api-key=bfM4Vp7zPUifAmJujAyLkp6QDi31Y80Q');

      var response = await http.get(url);
      print("url ${response.headers} ${response.request}");
      if (response.statusCode == 200) {
        var resbody = jsonDecode(response.body);

        var docs = resbody["response"]["docs"] as List;
        if (docs.isEmpty) {
          hasMore.value = false;
        } else {
          results.addAll(docs);
        }

        print("article ${resbody["response"]["docs"][0]["abstract"]}");
      } else {
        print("Failed to load articles. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      loadingD.value = false;
      loadingPage.value = false;
    }
  }
}
