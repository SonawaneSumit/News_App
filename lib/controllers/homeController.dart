import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum ExerciseFilter {
  home,
  arts,
  automobiles,
  business,
  fashion,
  food,
  health,
  insider,
  magazine,
  movies,
  nyregion,
  obituaries,
  opinion,
  politics,
  realestate,
  science,
  sports,
  sundayreview,
  technology,
  theater,
  tmagazine,
  travel,
  upshot,
  us,
  world
}

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newswithFilter(ExerciseFilter.values.first.name);
  }

  var loadingD = false.obs;
  // reactive selected filter
  var selectedFilter = Rxn<ExerciseFilter>();
  List<dynamic> results = [].obs;
  // var selectedFilter = Rxn<ExerciseFilter?>();

  void selectFilter(ExerciseFilter? filter) {
    selectedFilter.value = filter;
    if (filter != null) {
      print("Selected filter: ${filter.name}"); // for API call
    }
  }

  Future<void> newswithFilter(var filter) async {
    loadingD.value = true;
    try {
      var url = Uri.parse(
          'https://api.nytimes.com/svc/topstories/v2/$filter.json?api-key=bfM4Vp7zPUifAmJujAyLkp6QDi31Y80Q');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var resbody = jsonDecode(response.body);
        // results = resbody["results"];
        results.assignAll(resbody["results"]);
        print(response.body);
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      loadingD.value = false;
    }
  }
}
