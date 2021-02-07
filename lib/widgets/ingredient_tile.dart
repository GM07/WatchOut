import 'dart:io';
import 'dart:math';

import 'package:WatchOut/classes/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_button.dart';
import 'package:WatchOut/widgets/take_picture.dart';
import 'package:camera/camera.dart';
import 'package:WatchOut/classes/camera.dart';
import 'package:path_provider/path_provider.dart';

class IngredientTile extends StatefulWidget {
  @override
  _IngredientTile createState() => _IngredientTile();
}

class _IngredientTile extends State<IngredientTile> {
  List<Widget> currentItems() {
    return testList.map((Ingredient e) {
      TextEditingController valueInputController = new TextEditingController();
      valueInputController.text = e.quantity.toString();

      return Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  child: ListTile(
                    title: Text(
                      e.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Quantite : ' + e.quantity.toString()),
                  ),
                ),
              ),
            ),
            //Expanded(
            //flex: 1,
            IconButton(
              icon: Icon(
                Icons.remove,
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 9.0),
              iconSize: 24.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                int value = max(int.parse(valueInputController.text) - 1, 0);
                valueInputController.text = value.toString();
                setState(() {
                  e.quantity = value;
                });
              },
            ),
            //),
            Expanded(
              flex: 1,
              child: TextField(
                maxLines: 1,
                controller: valueInputController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                onSubmitted: (value) {
                  this.setState(() {
                    e.quantity = int.parse(value);
                  });
                  valueInputController.clear();
                },
              ),
            ),
            //Expanded(
            //flex: 1,
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 9.0),
              iconSize: 24.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                int value = min(int.parse(valueInputController.text) + 1,
                    9223372036854775807);
                valueInputController.text = value.toString();
                setState(() {
                  e.quantity = value;
                });
              },
            ),
            //),
          ],
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[...currentItems()],
      ),
    );
  }
}
