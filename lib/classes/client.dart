import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:WatchOut/widgets/IngredientHistoryHandler.dart';
import 'package:flutter/services.dart';

import 'ingredient.dart';
import 'package:path_provider/path_provider.dart';
import 'file_handler.dart';
import 'package:WatchOut/classes/ingredient.dart';

class Client {
  static FoodList ingredients = FoodList(items: List<Ingredient>());
  static Map<String, FoodList> backupLists = Map();
  static Map<String, int> scores = Map();

  static List<String> items;
  static File filelist;
  static File fileDechet;

  static String relativePath = '/lists.json';
  static String relativePathDechet = '/dechets.json';

  static Future openStorage() async {
    final path = await getApplicationDocumentsDirectory().then((e) => e.path);
    filelist = File(path + relativePath);
    fileDechet = File(path + relativePathDechet);
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
    scores = {
      'potato': 5,
      'tomato': 10,
      'carrot': 7,
      'Orange juice': 3,
      'pineapple': 6,
      'pizza': 2,
      'salt': 15,
    };
  }

  static void onIngredientThrown(Ingredient ingredient, int quantity) {
    if (scores.containsKey(ingredient.title))
      scores.update(ingredient.title, (value) => value + quantity);
    else
      scores[ingredient.title] = quantity;
    saveScores();
  }

  static List<String> worstIngredients() {
    List<String> worstItems = new List<String>(3);
    List<int> worstScores = new List<int>.filled(3, 0, growable: false);
    for (var entry in scores.entries) {
      if (entry.value >= worstScores[2]) {
        worstScores[2] = entry.value;
        worstItems[2] = entry.key;
        if (worstScores[2] >= worstScores[1]) {
          int temp = worstScores[1];
          String tempName = worstItems[1];
          worstScores[1] = worstScores[2];
          worstScores[2] = temp;
          worstItems[1] = worstItems[2];
          worstItems[2] = tempName;
        }
        if (worstScores[1] >= worstScores[0]) {
          int temp = worstScores[0];
          String tempName = worstItems[0];
          worstScores[0] = worstScores[1];
          worstScores[1] = temp;
          worstItems[0] = worstItems[1];
          worstItems[1] = tempName;
        }
      }
    }
    return worstItems;
  }

  static Future saveScores() async {
    if (!await fileDechet.exists()) {
      fileDechet.create(recursive: false);
    }

    String jsonMap = jsonEncode(scores);
    fileDechet.writeAsString(jsonMap);
  }

  static Future loadScores() async {
    if (!await fileDechet.exists()) {
      return;
    }

    String jsonString = await fileDechet.readAsString();
    Map<String, dynamic> map = jsonDecode(jsonString);
    for (var entry in map.entries) {
      scores[entry.key] = entry.value;
    }
  }

  static List<Ingredient> getListFromJsonElement(dynamic element) {
    List<Ingredient> list = List<Ingredient>();

    for (dynamic elem in element) {
      list.add(Ingredient.fromMap(elem));
    }

    return list;
  }

  static Future loadListsFromBackup() async {
    if (!await filelist.exists()) {
      return;
    }

    String jsonString = await filelist.readAsString();
    Map<String, dynamic> map = jsonDecode(jsonString);
    backupLists = map.map((String key, dynamic value) {
      if (value == null) {
        print(key);
        return MapEntry<String, FoodList>(key, FoodList());
      }
      print(value);
      return MapEntry<String, FoodList>(
          key,
          FoodList(
              date: DateTime.parse(value['date']),
              items: getListFromJsonElement(value['items'])));
    });

    print(backupLists);
  }

  // Adds current ingredient list to backup
  static Future addListToBackup() async {
    if (ingredients.date == null || ingredients.items == null) return;
    backupLists.addAll({DateTime.now().toString(): ingredients});

    if (!await filelist.exists()) {
      filelist.create(recursive: false);
    }

    String jsonMap = jsonEncode(backupLists);
    filelist.writeAsString(jsonMap);
  }

  // Adds current ingredient list to backup
  static Future addDechetToBackup() async {
    if (!await fileDechet.exists()) {
      fileDechet.create(recursive: false);
    }

    String jsonMap = jsonEncode(backupLists);
    filelist.writeAsString(jsonMap);
  }

  static FoodList getLastFoodList() {
    if (backupLists == null || backupLists.keys == null) {
      return null;
    }

    List<DateTime> dates =
        backupLists.keys.map((e) => DateTime.parse(e)).toList();

    dates.sort((a, b) => a.isBefore(b) ? 1 : 0);

    return backupLists[dates[0].toString()];
  }
}
