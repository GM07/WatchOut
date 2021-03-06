import 'package:WatchOut/classes/client.dart';
import 'package:WatchOut/classes/ingredient.dart';
import 'package:WatchOut/widgets/simple_line_chart.dart';
import 'package:flutter/material.dart';
import '../widgets/watch_out.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> currentItems() {
    FoodList foodList = Client.getLastFoodList();

    if (foodList == null) {
      return [const SizedBox.shrink()];
    }

    List<Ingredient> items = foodList.items;

    List<Ingredient> subList = List();
    if (items == null || items.length == 0) {
      return [const SizedBox.shrink()];
    } else {
      subList = items;
    }

    return getWidgets(subList, context);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GraphData, int>> _createSampleData() {
    final List<GraphData> data = List<GraphData>();

    for (int i = 0; i < Client.backupLists.values.length; i++) {
      data.add(
          GraphData(i, Client.backupLists.values.elementAt(i).numberWasted));
    }
    return [
      new charts.Series<GraphData, int>(
        id: 'wasted',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (GraphData wasted, _) => wasted.date,
        measureFn: (GraphData wasted, _) => wasted.wasted,
        data: data,
      )
    ];
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
          // Container(height: 300, child: IngredientList()),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () => {},
              color: Theme.of(context).primaryColor,
              child: Text(
                'Chart of Wasted Items'.toUpperCase(),
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
                child: SimpleLineChart(_createSampleData()),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0).add(EdgeInsets.only(top: 8.0)),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () => {},
              color: Theme.of(context).primaryColor,
              child: Text(
                'Last Shopping List'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...currentItems(),
        ],
      ),
    );
  }

  List<Widget> getWidgets(List<Ingredient> list, BuildContext context) {
    if (list == null || list.isEmpty) {
      return List<Widget>();
    }

    return list.map((Ingredient e) {
      TextEditingController valueInputController = new TextEditingController();
      TextEditingController nameInputController = new TextEditingController();
      valueInputController.text = e.quantity.toString();
      nameInputController.text = e.title;

      return Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  child: ListTile(
                    title: Text(
                      e.title,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(e.quantity.toString()),
            ),
            //),
          ],
        ),
      );
    }).toList();
  }
}

/// Sample linear data type.
class GraphData {
  final int date;
  final int wasted;

  GraphData(this.date, this.wasted);
}
