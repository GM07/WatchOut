import 'package:flutter/material.dart';

int waste_saved = 100;

class WasteSaved extends StatefulWidget {
  @override
  _WasteSavedState createState() => _WasteSavedState();
}

class _WasteSavedState extends State<WasteSaved> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              'images/trash-icon.png',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            heightFactor: 1,
            child: Text(
              'You\'ve saved ${waste_saved} aliments !'.toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                        blurRadius: 2,
                        offset: Offset(-1, 0),
                        color: Colors.black)
                  ]),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
