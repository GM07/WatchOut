import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:WatchOut/widgets/IngredientHistoryHandler.dart';
import 'package:flutter/services.dart';

import 'ingredient.dart';
import 'package:path_provider/path_provider.dart';
import 'file_handler.dart';
import 'package:WatchOut/classes/ingredient.dart';

class Client {
  static FoodList ingredients = FoodList();
  static Map<String, FoodList> backupLists;
  static Map<Ingredient, int> scores = Map();

  static List<String> items;
  static File file;

  static String relativePath = '/lists.json';

  static Future openStorage() async {
    final path = await getApplicationDocumentsDirectory().then((e) => e.path);
    file = File(path + relativePath);
  }

  static void addRandomLists() {
    backupLists = {
      'Aujourd\'hui':
          FoodList(items: generateIngredients(1), date: DateTime.now()),
      'Demain': FoodList(items: generateIngredients(2), date: DateTime.now()),
      'Apres Demain':
          FoodList(items: generateIngredients(3), date: DateTime.now()),
      'Jamais': FoodList(items: generateIngredients(4), date: DateTime.now()),
    };
  }

  static List<Ingredient> getListFromJsonElement(dynamic element) {
    List<Ingredient> list = List<Ingredient>();

    for (dynamic elem in element) {
      list.add(Ingredient.fromMap(elem));
    }

    return list;
  }

  static Future loadListsFromBackup() async {
    if (!await file.exists()) {
      return;
    }

    String jsonString = await file.readAsString();
    Map<String, dynamic> map = jsonDecode(jsonString);
    backupLists = map.map((String key, dynamic value) {
      if (value == null) {
        print(key);
        return MapEntry<String, FoodList>(key, FoodList());
      }

      return MapEntry<String, FoodList>(
          key,
          FoodList(
              date: DateTime.parse(value['date']),
              items: getListFromJsonElement(value['items'])));
    });
  }

  // Adds current ingredient list to backup
  static Future addListToBackup() async {
    backupLists.addAll({DateTime.now().toString(): ingredients});

    if (!await file.exists()) {
      file.create(recursive: false);
    }

    String jsonMap = jsonEncode(backupLists);
    file.writeAsString(jsonMap);
  }
}
