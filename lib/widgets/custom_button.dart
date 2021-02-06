import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  const CustomButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: this.widget.onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(
        widget.title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
