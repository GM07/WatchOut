import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        child: new charts.LineChart(seriesList, animate: animate));
  }
}
