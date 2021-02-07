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
  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CustomButton(
              onPressed: () => {},
              title: "Watch Out for that Potatoe",
            ),
          ),
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
            child: Center(
                child: CustomButton(
              onPressed: () async {
                await Client.filelist.delete(recursive: false);
                setState(() {});
              },
              title: "My Lists",
            )),
          ),
        ),
        Client.backupLists == null || Client.backupLists.keys == null
            ? const SizedBox.shrink()
            : Column(
                children: Client.backupLists.keys.map((key) {
                  FoodList list = Client.backupLists[key];
                  final f = new DateFormat('EEEE, d MMM, yyyy');
                  return GestureDetector(
                    onLongPress: () {
                      buildBottomSheet(context);
                    },
                    child: ExpansionTile(
                        maintainState: false,
                        initiallyExpanded: false,
                        title: Text(
                          "${f.format(list.date)}",
                        ),
                        children: currentItems(list.items)),
                  );
                }).toList(),
              )
      ],
    );
  }

  List<Widget> currentItems(List<Ingredient> list) {
    if (list == null || list.isEmpty) {
      return List<Widget>();
    }

    return list.map((Ingredient e) {
      TextEditingController valueInputController = new TextEditingController();
      TextEditingController nameInputController = new TextEditingController();
      valueInputController.text = e.quantity.toString();
      nameInputController.text = e.title;

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
      );
    }).toList();
  }
}
