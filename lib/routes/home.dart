
import 'package:WatchOut/widgets/IngredientHistoryHandler.dart';
import 'dart:io';
import 'package:WatchOut/widgets/ingredient_list.dart';
import 'package:WatchOut/widgets/ingredient_tile.dart';
import 'package:flutter/material.dart';
import '../widgets/waste_saved.dart';
import '../widgets/watch_out.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import '../widgets/main_page.dart';
import 'new_list.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  Widget _getCurrentWidget() {
    if (_currentIndex == 0) {
      return IngredientTile();
    } else if (_currentIndex == 1) {
      return MainPage();
    } else {
      return NewList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
        body: _getCurrentWidget());
  }
}
