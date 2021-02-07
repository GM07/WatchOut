import 'dart:math';

import 'package:WatchOut/classes/client.dart';
import 'package:WatchOut/classes/ingredient.dart';
import 'package:WatchOut/widgets/custom_button.dart';
import 'package:expandable_group/expandable_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PastLists extends StatefulWidget {
  @override
  _PastListsState createState() => _PastListsState();
}

class _PastListsState extends State<PastLists> {
  void buildBottomSheet(BuildContext context, Ingredient e) {
    TextEditingController valueInputController = new TextEditingController();
    valueInputController.text = "0";

    showModalBottomSheet<dynamic>(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        e.title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                      ),
                      Text(
                        '(' + e.quantity.toString() + ')',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Text(
                    "Number wasted:".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  //Expanded(
                  //flex: 1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 9.0),
                        iconSize: 24.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          int value =
                              max(int.parse(valueInputController.text) - 1, 0);
                          valueInputController.text = value.toString();
                        },
                      ),
                      //),
                      Container(
                        width: 100,
                        child: TextField(
                          maxLines: 1,
                          controller: valueInputController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], //  Only numbers can be entered
                        ),
                      ),
                      //Expanded(
                      //flex: 1,
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 9.0),
                        iconSize: 24.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          int value = min(
                              int.parse(valueInputController.text) + 1,
                              e.quantity);
                          valueInputController.text = value.toString();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        Client.onIngredientThrown(
                            e, int.parse(valueInputController.text));
                        Navigator.pop(context);
                      },
                      title: "Confirm",
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _header(String name) => Text(name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));

  List<ListTile> _buildItems(List<Ingredient> items) => items
      .map((e) => ListTile(
            title: Text(e.title),
            subtitle: Text(e.quantity.toString()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
            child: CustomButton(
              onPressed: () async {
                await Client.filelist.delete(recursive: false);
                setState(() {});
              },
              title: "My Lists".toUpperCase(),
            ),
          ),
        ),
        Client.backupLists == null || Client.backupLists.keys == null
            ? const SizedBox.shrink()
            : Column(
                children: Client.backupLists.keys.toList().reversed.map((key) {
                  FoodList list = Client.backupLists[key];
                  final f = new DateFormat('EEEE, d MMM, yyyy');
                  return ExpansionTile(
                      maintainState: false,
                      initiallyExpanded: false,
                      title: Text(
                        "${f.format(list.date)}",
                      ),
                      children: currentItems(list.items, context));
                }).toList(),
              )
      ],
    );
  }

  List<Widget> currentItems(List<Ingredient> list, BuildContext context) {
    if (list == null || list.isEmpty) {
      return List<Widget>();
    }

    return list.map((Ingredient e) {
      TextEditingController valueInputController = new TextEditingController();
      TextEditingController nameInputController = new TextEditingController();
      valueInputController.text = e.quantity.toString();
      nameInputController.text = e.title;

      return GestureDetector(
        onLongPress: () {
          buildBottomSheet(context, e);
        },
        child: Container(
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
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(e.quantity.toString()),
              ),
              //),
            ],
          ),
        ),
      );
    }).toList();
  }
}
