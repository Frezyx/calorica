import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

getLineGraph(context, chartData) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [DesignTheme.originalShadowLil],
      ),
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height / 3),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.OrdinalComboChart(chartData,
                    animate: true,
                    defaultRenderer: charts.LineRendererConfig(),
                    customSeriesRenderers: [
                      charts.PointRendererConfig(
                          customRendererId: 'customPoint')
                    ]),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10.0, bottom: 10, left: 40, right: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(Icons.label, color: DesignTheme.secondColor),
                        Text("кКалории в день"),
                      ]),
                    ]),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

List<charts.Series<GraphLinarData, String>> createSampleData(
    List<UserProduct> weekStats) {
  List<GraphLinarData> tableSalesData = [];
  List<GraphLinarData> mobileSalesData = [];

  for (int i = 0; i < weekStats.length; i++) {
    mobileSalesData.add(GraphLinarData(
        i, weekStats[i].date.day.toString(), weekStats[i].calory));
    tableSalesData.add(GraphLinarData(
        i, weekStats[i].date.day.toString(), weekStats[i].calory));
  }

  return [
    charts.Series<GraphLinarData, String>(
      id: 'Tablet',
      colorFn: (_, __) =>
          charts.ColorUtil.fromDartColor(DesignTheme.secondChartsGreen),
      domainFn: (GraphLinarData data, _) => data.date,
      measureFn: (GraphLinarData data, _) => data.param,
      data: tableSalesData,
    ),
    charts.Series<GraphLinarData, String>(
        id: 'Mobile',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(DesignTheme.secondColor),
        domainFn: (GraphLinarData data, _) => data.date,
        measureFn: (GraphLinarData data, _) => data.param,
        data: mobileSalesData)
      ..setAttribute(charts.rendererIdKey, 'customPoint'),
  ];
}

class GraphLinarData {
  final int id;
  final String date;
  final double param;

  GraphLinarData(this.id, this.date, this.param);
}
