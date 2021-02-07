import 'package:WatchOut/classes/client.dart';
import 'package:WatchOut/classes/ingredient.dart';
import 'package:flutter/material.dart';

class WatchOut extends StatefulWidget {
  @override
  _WatchOutState createState() => _WatchOutState();
}

class _WatchOutState extends State<WatchOut> {
  List<Widget> worstFoods() {
    List<String> list = Client.worstIngredients();

    List<Widget> w_list = List<Widget>();

    for (String s in list) {
      if (s != null) {
        w_list.add(Text(
          s,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
          textAlign: TextAlign.center,
        ));
      }
    }

    return w_list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'You should be careful with'.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        ...worstFoods()
      ],
    );
  }
}
