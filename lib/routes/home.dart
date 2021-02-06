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
