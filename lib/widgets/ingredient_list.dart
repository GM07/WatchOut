
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
          return Card(
            child: GridTile(
              child: Center(child: Text(items[index].title)),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  items[index].quantity.toString(),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          );
        });

    // return ReorderableListView(
    //   children: items
    //       .map((item) => Padding(
    //             key: Key("${item.title}${item.date.millisecondsSinceEpoch}"),
    //             padding: const EdgeInsets.all(4.0),
    //             child: Container(
    //               child: ListTile(
    //                 onTap: () => _showInfo(item),
    //                 title: Text("${item.title}"),
    //                 subtitle: Text("${item.date.toUtc()}"),
    //                 trailing: Icon(Icons.menu),
    //               ),
    //             ),
    //           ))
    //       .toList(),
    //   onReorder: (int start, int current) {
    //     // dragging from top to bottom
    //     if (start < current) {
    //       int end = current - 1;
    //       Test startItem = items[start];
    //       int i = 0;
    //       int local = start;
    //       do {
    //         items[local] = items[++local];
    //         i++;
    //       } while (i < end - start);
    //       items[end] = startItem;
    //     }
    //     // dragging from bottom to top
    //     else if (start > current) {
    //       Test startItem = items[start];
    //       for (int i = start; i > current; i--) {
    //         items[i] = items[i - 1];
    //       }
    //       items[current] = startItem;
    //     }
    //     setState(() {});
    //   },
    // );
  }
}