import 'dart:convert';
import 'dart:js';

import 'package:flutter/services.dart';

import 'ingredient.dart';
import 'package:path_provider/path_provider.dart';

Future<List<Ingredient>> parseJson(String response) async {
  if (response == null) {
    return [];
  }
  final parsed = json.decode(response.toString()).cast<Map<String, dynamic>>();
  return parsed
      .map<Ingredient>((json) => new Ingredient.fromJson(json))
      .toList();
}

Future<List<Ingredient>> loadJsonIngredients(String path) async {
  String jsonString = await rootBundle.loadString(path);
  return parseJson(jsonString);
}
