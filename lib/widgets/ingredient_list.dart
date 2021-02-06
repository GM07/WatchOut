import 'package:flutter/material.dart';

class Test {
  Test({this.title, this.date, this.quantity});
  String title;
  DateTime date;
  int quantity;
}

class IngredientList extends StatefulWidget {
  IngredientList({Key key}) : super(key: key);

  @override
  _IngredientListState createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  List<Test> items = List();

  _showInfo(Test item) {}

  @override
  void initState() {
    super.initState();
    items.add(Test(title: 'Tomate', date: DateTime.now(), quantity: 4));
    items.add(Test(title: 'Patate', date: DateTime.now(), quantity: 1));
    items.add(Test(title: 'Banane', date: DateTime.now(), quantity: 5));
    items.add(Test(title: 'Orange', date: DateTime.now(), quantity: 10));
    items.add(Test(title: 'Pomme', date: DateTime.now(), quantity: 14));
    items.add(Test(title: 'Pain', date: DateTime.now(), quantity: 1));
    items.add(Test(title: 'Carotte', date: DateTime.now(), quantity: 17));
    items.add(Test(title: 'Raisins', date: DateTime.now(), quantity: 1));
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
              decoration:
                  BoxDecoration(color: Colors.redAccent[100].withAlpha(100)),
              child: Center(
                child: Text(
                  items[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ));
        });
  }
}
