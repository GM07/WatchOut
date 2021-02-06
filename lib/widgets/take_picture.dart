import 'dart:io';
import 'package:WatchOut/classes/ingredient.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:WatchOut/classes/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:WatchOut/classes/file_handler.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key key,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
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
      ResolutionPreset.ultraHigh,
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

  void takePicture() async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/list';
      await Directory(dirPath).create(recursive: true);
      final String filePath =
          '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

      if (_controller.value.isTakingPicture) {
        // A capture is already pending, do nothing.
        return null;
      }

      await Future.delayed(Duration(milliseconds: 500), () async {
        await _controller.initialize();
        await _controller.takePicture(filePath);
      });

      await _controller.dispose();

      Navigator.pop(context, filePath);

      List<Ingredient> ingredients = await _recognizeText(File(filePath));
    } catch (e) {
      // If an error occurs, log the error to the console.
      print('CAMERA : ' + Camera.mainCamera.toString());
    }
  }

  static Future<List<Ingredient>> _recognizeText(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer cloudTextRecognizer =
        FirebaseVision.instance.cloudTextRecognizer();
    final VisionText visionText =
        await cloudTextRecognizer.processImage(visionImage);
    List<Ingredient> ingredientList = [];
    String item;
    int quantite = 0;
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          if (isNumeric(element.text)) {
            quantite = int.parse(element.text);
            ingredientList.add(Ingredient(
                date: DateTime.now(), quantity: quantite, title: item));
            item = null;
          } else {
            if (item != null) {
              ingredientList.add(
                  Ingredient(date: DateTime.now(), quantity: 1, title: item));
            }
            item = element.text;
          }
        }
      }
    }
    if (item != null) {
      ingredientList
          .add(Ingredient(date: DateTime.now(), quantity: 1, title: item));
    }
    cloudTextRecognizer.close();
    for (Ingredient ingredient in ingredientList) {
      print(ingredient.title + " " + ingredient.quantity.toString());
    }
    return ingredientList;
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                CameraPreview(_controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Clear button
                        FloatingActionButton(
                          heroTag: 'clearButtonCamera',
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          child: Icon(
                            Icons.clear,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                        // Search button
                        FloatingActionButton(
                          heroTag: 'TakePictureButtonCamera',
                          onPressed: takePicture,
                          child: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
