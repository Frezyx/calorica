import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

getLineGraph(context, chartData){
              return Padding(
                  padding: EdgeInsets.only(bottom:20, top: 10, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                    
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [DesignTheme.originalShadowLil],
                  ),
                    constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height/3),
                    child:Card(
                      shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 0.0,
                      child:
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: charts.NumericComboChart(

                              chartData,
                              animate: true,
                              // Configure the default renderer as a line renderer. This will be used
                              // for any series that does not define a rendererIdKey.
                              defaultRenderer: new charts.LineRendererConfig(),
                              // Custom renderer configuration for the point series.
                              customSeriesRenderers: [
                                new charts.PointRendererConfig(
                                    // ID used to link series to this renderer.
                                    customRendererId: 'customPoint')
                              ]),
                            ),

                            // Padding(
                            //   padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 40, right: 40),
                            //   child:
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children:<Widget>[
                            //       Row(children:<Widget>[
                            //         Icon(Icons.label, color: (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondColor : DesignTheme.redColor,),
                            //         Text("Сегодня"),]),
                            //       Row(children:<Widget>[
                            //         Icon(Icons.label, color: (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondChartsGreen : DesignTheme.secondChartRed,),
                            //         Text("Вчера"),]),
                            //     ]),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ),
            );
}

List<charts.Series<GraphLinarData, int>> createSampleData(List<UserProduct> weekStats) {

    // var desktopSalesData = [
    //   new GraphLinarData(0, 5),
    //   new GraphLinarData(1, 25),
    //   new GraphLinarData(2, 100),
    //   new GraphLinarData(3, 75),
    // ];

    List<GraphLinarData> tableSalesData = [];
    List<GraphLinarData> mobileSalesData = [];
    
    for (int i = 0; i < weekStats.length; i++){
      mobileSalesData.add(new GraphLinarData(i, weekStats[i].calory));
      tableSalesData.add(new GraphLinarData(i, weekStats[i].calory));
    }

    return [
      // new charts.Series<GraphLinarData, int>(
      //   id: 'Desktop',
      //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //   domainFn: (GraphLinarData sales, _) => sales.year,
      //   measureFn: (GraphLinarData sales, _) => sales.sales,
      //   data: desktopSalesData,
      // ),
      new charts.Series<GraphLinarData, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (GraphLinarData sales, _) => sales.year,
        measureFn: (GraphLinarData sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<GraphLinarData, int>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (GraphLinarData sales, _) => sales.year,
          measureFn: (GraphLinarData sales, _) => sales.sales,
          data: mobileSalesData)
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }

class GraphLinarData {
  final int year;
  final double sales;

  GraphLinarData(this.year, this.sales);
}