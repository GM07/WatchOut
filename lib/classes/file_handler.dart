import 'dart:collection';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<String>> parseJson(String response) async {
  if (response == null) {
    return [];
  }
  final parsed =
      await json.decode(response.toString()) as LinkedHashMap<String, dynamic>;
  List<dynamic> elements = parsed['tags'];
  return await elements
      .map((dynamic ingredient) => ingredient['name'].toString())
      .toList();
}

Future<List<String>> loadJsonIngredients(String path) async {
  String jsonString = await rootBundle.loadString(path);
  return await parseJson(jsonString);
}
