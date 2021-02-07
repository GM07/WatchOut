import 'dart:io';

import 'ingredient.dart';
import 'package:path_provider/path_provider.dart';

class Client {
  static List<Ingredient> ingredients = List();

  static Map<String, List<Ingredient>> backupLists = Map();

  static Map<Ingredient, int> scores = Map();

  static loadListsFromBackup() async {}

  // Adds current ingredient list to backup
  static addListToBackup() async {
    final path = await getApplicationDocumentsDirectory().then((e) => e.path);
    final File file = File(path);
  }
}
