import 'package:flutter/material.dart';

class WatchOut extends StatefulWidget {
  @override
  _WatchOutState createState() => _WatchOutState();
}

class _WatchOutState extends State<WatchOut> {
  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Text(
        'You should be careful with your potatoes'.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
