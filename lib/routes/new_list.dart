import 'dart:io';

import 'package:WatchOut/classes/ingredient.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'package:WatchOut/widgets/take_picture.dart';
import 'package:camera/camera.dart';
import 'package:WatchOut/classes/camera.dart';
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text('Ingredient : ' + e.title),
          subtitle: Text('Quantite : ' + e.quantity.toString()),
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
          Padding(
            padding: const EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
            child: Center(
                child: CustomButton(
              onPressed: () => _openCamera(context),
              title: "Scan my list",
            )),
          ),
          ...currentItems()
        ],
      ),
    ));
  }
}
