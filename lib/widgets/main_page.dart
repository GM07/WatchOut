import 'package:WatchOut/widgets/ingredient_list.dart';
import 'package:flutter/material.dart';
import '../widgets/waste_saved.dart';
import '../widgets/watch_out.dart';
import '../classes/ingredient.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> currentItems() {
    List<Ingredient> subList = List();
    if (testList.length > 5) {
      subList = testList.getRange(0, 5).toList();
    } else {
      subList = testList;
    }

    return subList.map((Ingredient e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text('Ingredient : ' + e.title),
          subtitle: Text('Quantite : ' + e.quantity.toString()),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ...currentItems(),
          // Container(height: 300, child: IngredientList()),
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
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
    );
  }
}
