import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'ingredient.dart';
import 'package:path_provider/path_provider.dart';
import 'file_handler.dart';
import 'package:WatchOut/classes/ingredient.dart';

class Client {
  static List<Ingredient> ingredients = List();
  static Map<String, List<Ingredient>> backupLists = {};
  static Map<Ingredient, int> scores = Map();

  static List<String> items;

  static String relativePath = '/lists.json';

  static void addRandomLists() {}

  static Future loadListsFromBackup() async {
    final path = await getApplicationDocumentsDirectory().then((e) => e.path);
    String jsonString = await rootBundle.loadString(path);
  }

  // Adds current ingredient list to backup
  static Future addListToBackup() async {
    final path = await getApplicationDocumentsDirectory().then((e) => e.path);
    final File file = File(path + relativePath);

    if (!await file.exists()) {
      file.create(recursive: false);
    }

    String jsonMap = jsonEncode(backupLists);
    print(jsonMap);
  }
}
