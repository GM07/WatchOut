import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:WatchOut/widgets/ingredient_list.dart';
import 'package:intl/intl.dart';
import 'ingredient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IngredientHistory extends StatefulWidget {

  @override
  _IngredientHistoryState createState() => _IngredientHistoryState();
}

class IngredientListJSON {
  List<Ingredient> list = new List<Ingredient>();
  DateTime date;

  IngredientListJSON(List<Ingredient> l, DateTime date){
    this.list = l;
    this.date = date;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'list': List<dynamic>.from(list.map((x) => x))};
  }

  IngredientListJSON.fromJson(Map json){
    this.date = DateTime.parse(json['date']);
    this.list = List<Ingredient>.from(json['list'].map((x) => x));
  }

}

class _IngredientHistoryState extends State<IngredientHistory> {

  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "purchasedIngredients.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent = new Map<String, dynamic>();

  List<Ingredient> getAllIngredients(){
    List<Ingredient> items = List();
    fileContent.forEach((key, value) {
      items.add(new Ingredient.fromJson(value));
    });
    return items;
  }

  List<Ingredient> getFromDate(DateTime date){
    List<Ingredient> items = List();
    fileContent.forEach((key, value) {
      final DateTime savedDate = DateTime.parse(key);
      final formatted = DateFormat(date.toString()).format(savedDate);
      if(formatted == date.toString()) {
        items.add(new Ingredient.fromJson(value));
      }
    });
    return items;
  }

  int getNumberOfIngredient(String ingredientTitle){
    int number = 0;
    fileContent.forEach((key, value) {
     if(Ingredient.fromJson(value).title ==  ingredientTitle){
       number += Ingredient.fromJson(value).quantity;
     }
    });
    return number;
  }

  File createFile(Map<String, dynamic> contents, Directory dir, String fileName){
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(contents));
    return file;
  }

  void writeIngredient(Ingredient ingredient){
    // print("Writing to file " + fileName);
    Map<String, dynamic> content = ingredient.toJson();
    if(fileExists){
      // print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      // print(jsonFileContent);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      getAllIngredients();
    } else {
      // print("File does not exist");
      jsonFile = createFile(content, dir, fileName);
    }
    this.setState(() {
      fileContent = json.decode(jsonFile.readAsStringSync());
      print(fileContent);
    });
  }

  void writeIngredientList(List<Ingredient> ingredient){
    for(Ingredient i in ingredient){
      writeIngredient(i);
    }
  }

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory)
    {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      jsonFile.delete(); // Delete
      jsonFile.create(); // create
      fileExists = jsonFile.existsSync();
      if(fileExists) this.setState(() {
        fileContent = jsonDecode(jsonFile.readAsStringSync());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("File content: ", style: new TextStyle(fontWeight: FontWeight.bold),),
          new Text(fileContent.toString()),
          new Padding(padding: new EdgeInsets.only(top: 10.0)),
          new Text("Add to JSON file: "),
          new TextField(
            controller: keyInputController,
          ),
          new TextField(
            controller: valueInputController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          ),
          new Padding(padding: new EdgeInsets.only(top: 20.0)),
          new RaisedButton(
            child: new Text("Add key, value pair"),
            onPressed: () => writeIngredientList([(new Ingredient(title: keyInputController.text, date: DateTime.now(),
                quantity: int.parse(valueInputController.text.isEmpty ? "0" : valueInputController.text)))]),
          )
        ],
      ),
    );
  }
}

