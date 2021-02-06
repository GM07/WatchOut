
import 'package:flutter/material.dart';

class Ingredient {
  Ingredient({this.title, this.date, this.quantity});
  String title;
  DateTime date;
  int quantity;

  Map<String, dynamic> toJson() {
    return {
      date.toString(): {
        'date': date.toString(),
        'title': title,
        'quantity': quantity
      }
    };
  }

  Ingredient.fromJson(Map json){
    this.date = DateTime.parse(json['date']);
    this.title = json['title'];
    this.quantity = json['quantity'];
  }

}


class IngredientList extends StatefulWidget {
  IngredientList({Key key}) : super(key: key);

  @override
  _IngredientListState createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  List<Ingredient> items = List();

  _showInfo(Ingredient item) {}

  @override
  void initState() {
    super.initState();
    items.add(Ingredient(title: 'Tomate', date: DateTime.now(), quantity: 4));
    items.add(Ingredient(title: 'Patate', date: DateTime.now(), quantity: 1));
    items.add(Ingredient(title: 'Banane', date: DateTime.now(), quantity: 5));
    items.add(Ingredient(title: 'Orange', date: DateTime.now(), quantity: 10));
    items.add(Ingredient(title: 'Orange', date: DateTime.now(), quantity: 10));
    items.add(Ingredient(title: 'Orange', date: DateTime.now(), quantity: 10));
    items.add(Ingredient(title: 'Orange', date: DateTime.now(), quantity: 10));
    items.add(Ingredient(title: 'Orange', date: DateTime.now(), quantity: 10));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(color: Colors.red.withAlpha(100)),
              child: Center(
                child: Text(
                  items[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ));
        });
  }
}
