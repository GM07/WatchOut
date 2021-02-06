import 'package:flutter/material.dart';

class NewList extends StatefulWidget {
  @override
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Ingredients'),
          ),
        ),
        body: Container(
          color: Colors.blue,
        ));
  }
}
