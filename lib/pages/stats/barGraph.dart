import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

getBarGraph(context, _seriesData, caloryLimitDeltaL, caloryLimitDeltaR,
    todayParams, yesterdayParams) {
  var caloryT = todayParams.calory;
  var caloryY = yesterdayParams.calory;

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
                child: charts.BarChart(
                  _seriesData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.stacked,
                  animationDuration: Duration(seconds: 3),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10.0, bottom: 10, left: 40, right: 40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Icon(
                          Icons.label,
                          color: (caloryT < caloryY ||
                                  caloryT <= caloryLimitDeltaR &&
                                      caloryT >= caloryLimitDeltaL)
                              ? CustomTheme.mainColor
                              : DesignTheme.redColor,
                        ),
                        Text("Сегодня"),
                      ]),
                      Row(children: <Widget>[
                        Icon(
                          Icons.label,
                          color: (caloryT < caloryY ||
                                  caloryT <= caloryLimitDeltaR &&
                                      caloryT >= caloryLimitDeltaL)
                              ? DesignTheme.secondChartsGreen
                              : DesignTheme.secondChartRed,
                        ),
                        Text("Вчера"),
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

generateData(
    yesterdayParams, todayParams, caloryLimitDeltaR, caloryLimitDeltaL) {
  var data2 = [
    GraphData('Белки', yesterdayParams.squi.round()),
    GraphData('Жиры', yesterdayParams.fat.round()),
    GraphData('Углеводы', yesterdayParams.carboh.round()),
  ];

  var data1 = [
    GraphData('Белки', todayParams.squi.round()),
    GraphData('Жиры', todayParams.fat.round()),
    GraphData('Углеводы', todayParams.carboh.round()),
  ];

  return [
    charts.Series(
      domainFn: (GraphData data, _) => data.place,
      measureFn: (GraphData data, _) => data.quantity,
      id: 'sssss',
      data: data2,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
      fillColorFn: (GraphData data, _) => charts.ColorUtil.fromDartColor(
          (todayParams.calory < yesterdayParams.calory ||
                  todayParams.calory <= caloryLimitDeltaR &&
                      todayParams.calory >= caloryLimitDeltaL)
              ? DesignTheme.secondChartsGreen
              : DesignTheme.secondChartRed),
    ),
    charts.Series(
      domainFn: (GraphData data, _) => data.place,
      measureFn: (GraphData data, _) => data.quantity,
      id: 'fffff',
      data: data1,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
      fillColorFn: (GraphData data, _) => charts.ColorUtil.fromDartColor(
          (todayParams.calory < yesterdayParams.calory ||
                  todayParams.calory <= caloryLimitDeltaR &&
                      todayParams.calory >= caloryLimitDeltaL)
              ? CustomTheme.mainColor
              : DesignTheme.redColor),
    ),
  ];
}

class GraphData {
  String place;
  int quantity;

  GraphData(this.place, this.quantity);
}
