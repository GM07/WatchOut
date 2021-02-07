import 'dart:io';
import 'dart:math';

import 'package:WatchOut/classes/ingredient.dart';
import 'package:WatchOut/widgets/ingredient_tile.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'package:WatchOut/widgets/take_picture.dart';
import 'package:camera/camera.dart';
import 'package:WatchOut/classes/camera.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class NewList extends StatefulWidget {
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      Camera.mainCamera,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  List<Widget> currentItems() {
    return testList.map((Ingredient e) {
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
                    title: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                      controller: nameInputController,
                      onFieldSubmitted: (value) {
                        this.setState(() {
                          e.title = nameInputController.text;
                        });
                        nameInputController.clear();
                      },
                    ),
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

  _openCamera(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
              child: Center(
                  child: CustomButton(
                onPressed: () => _openCamera(context),
                title: "Scan my list",
              )),
            ),
          ),
          ...currentItems(),
        ],
      ),
    ));
  }
}
