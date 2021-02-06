import 'dart:io';

import 'package:WatchOut/widgets/ingredient_list.dart';
import 'package:flutter/material.dart';
import '../widgets/waste_saved.dart';
import '../widgets/watch_out.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_similarity/string_similarity.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _openCamera() async {
    File awaitImage =
        File((await ImagePicker().getImage(source: ImageSource.gallery)).path);
    _recognizeText(awaitImage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}
