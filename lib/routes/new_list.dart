import 'package:WatchOut/classes/ingredient.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class NewList extends StatefulWidget {
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  List<Widget> currentItems() {
    return testList.map((Ingredient e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text('Ingredient : ' + e.title),
          subtitle: Text('Quantite : ' + e.quantity.toString()),
        ),
      );
    }).toList();
  }

  _openCamera() {
    print('Camera open');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
            child: Center(
                child: CustomButton(
              onPressed: _openCamera,
              title: "Scan my list",
            )),
          ),
          ...currentItems()
        ],
      ),
    ));
  }
}
