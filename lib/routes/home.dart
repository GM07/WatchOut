<<<<<<< HEAD
import 'dart:io';

import 'package:WatchOut/widgets/ingredient_list.dart';
import 'package:flutter/material.dart';
import '../widgets/waste_saved.dart';
import '../widgets/watch_out.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_similarity/string_similarity.dart';
=======
import 'package:flutter/material.dart';
import '../widgets/main_page.dart';
import 'package:bottom_bars/bottom_bars.dart';
import 'new_list.dart';
>>>>>>> 3be08bfe468d01b5b1987e5c96328ec6f0dce6d1

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  _openCamera() async {
  }

  _recognizeText(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          print(element.text
              .bestMatch(['tomato', 'pizza', 'ananas', 'linguine']));
        }
      }
    }
    textRecognizer.close();
  }


  @override
  void initState() {
    super.initState();
  }

  Widget _getCurrentWidget() {
    if (_currentIndex == 0) {
      return Container(
        color: Colors.green,
      );
    } else if (_currentIndex == 1) {
      return MainPage();
    } else {
      return NewList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _openCamera(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Watch Out'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
            WatchOut(),
            Padding(
              padding: EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Shopping List'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: 300, child: IngredientList()),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () => {},
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Waste Saved'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              padding: EdgeInsets.all(8.0),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(
                const Radius.circular(10.0),
              )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  child: WasteSaved(),
                ),
              ),
            ),
=======
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          fixedColor: Colors.red,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text('')),
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
            BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('')),
>>>>>>> 3be08bfe468d01b5b1987e5c96328ec6f0dce6d1
          ],
        ),
        body: _getCurrentWidget());
  }
}
