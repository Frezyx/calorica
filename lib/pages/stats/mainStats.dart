import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/utils/dietSelector.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainStats extends StatefulWidget {
  final Widget child;

  MainStats({Key key, this.child}) : super(key: key);

  _MainStatsState createState() => _MainStatsState();
}

class _MainStatsState extends State<MainStats> {
  List<charts.Series<Pollution, String>> _seriesData = List<charts.Series<Pollution, String>>();
  List<UserProduct> userTodayProducts;
  List<UserProduct> userYesterdayProducts;
  var fatT = 0.0;
  var squiT = 0.0;
  var carbohT = 0.0;
  var caloryT = 0.0;

  var fatY = 0.0;
  var squiY = 0.0;
  var carbohY = 0.0;
  var caloryY = 0.0;

  var caloryLimit = 2900.0;
  var caloryLimitDeltaL = 2300.0;
  var caloryLimitDeltaR = 3100.0;

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }
  
  

  _generateData( ) {
    

    var data2 = [
      Pollution(1980, 'Белки', squiY.round() ),
      Pollution(1980, 'Жиры', fatY.round() ),
      Pollution(1980, 'Углеводы', carbohY.round() ),
    ];

    var data1 = [
      Pollution(1980, 'Белки', squiT.round() ),
      Pollution(1980, 'Жиры', fatT.round() ),
      Pollution(1980, 'Углеводы', carbohT.round() ),
    ];
    setState(() {
          _seriesData = [
            // _seriesData.add(
              charts.Series(
                domainFn: (Pollution pollution, _) => pollution.place,
                measureFn: (Pollution pollution, _) => pollution.quantity,
                id: 'sssss',
                data: data2,
                fillPatternFn: (_, __) => charts.FillPatternType.solid,
                fillColorFn: (Pollution pollution, _) =>
                    charts.ColorUtil.fromDartColor(
                        (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondChartsGreen : DesignTheme.secondChartRed
                      ),
              ), 
            // );

            // _seriesData.add(
              charts.Series(
                domainFn: (Pollution pollution, _) => pollution.place,
                measureFn: (Pollution pollution, _) => pollution.quantity,
                id: 'fffff',
                data: data1,
                fillPatternFn: (_, __) => charts.FillPatternType.solid,
                fillColorFn: (Pollution pollution, _) =>
                    charts.ColorUtil.fromDartColor(
                        (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondColor : DesignTheme.redColor
                      ),
              ), 
            // );
            ];
    });
  }

  @override
  void initState() {
    super.initState();
    DBUserProvider.db.getUser().then((res){
      var diet = selectDiet(res);
      caloryLimit = diet.calory;
      caloryLimitDeltaL = caloryLimit * 0.7;
      caloryLimitDeltaR = caloryLimit * 1.2;
    });

    // _seriesData = List<charts.Series<Pollution, String>>();
    DBUserProductsProvider.db.getTodayProducts().then((todayProd){
      DBUserProductsProvider.db.getYesterdayProducts().then((yesterdayProd){
        //TODO: проверка на пустоту данных со вчерашнего дня
        print(yesterdayProd[0].date);
        for (var i = 0; i < todayProd.length; i++) {
          // setState(() {
            fatT += todayProd[i].fat;
            squiT += todayProd[i].squi;
            carbohT += todayProd[i].carboh;
            caloryT += todayProd[i].calory;
          // });
        }
        setState(() {
          fatT = fatT;
          squiT = squiT;
          carbohT = carbohT;
          caloryT = roundDouble(caloryT, 2);
          });
        for (var i = 0; i < yesterdayProd.length; i++) {
          
            fatY += yesterdayProd[i].fat;
            squiY += yesterdayProd[i].squi;
            carbohY += yesterdayProd[i].carboh;
            caloryY += yesterdayProd[i].calory;
        }
        setState(() {
          fatY = fatY;
          squiY = squiY;
          carbohY = carbohY;
          caloryY = roundDouble(caloryY, 2);
          });
        _generateData(  );
      });
    });
    print("ok");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 50, left: 20, right: 20),
                child:Text(
                  (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? "Сегодня вы - молодец! " : "Старайтесь лучше!" ,style: DesignTheme.bigText,
                )
              ),

              Padding(
                  padding: EdgeInsets.only(bottom:20, top: 20, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                    
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0, // has the effect of softening the shadow
                          spreadRadius: 2.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
                  ),
                    constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height/8),
                    child:Card(
                      shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 0.0,
                      child:
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:  CrossAxisAlignment.center,
                              children:<Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget>[
                                  Text("История питания", style: DesignTheme.primeTextBig,),
                                  Text("Узнай как ты питаешься",
                                      style: DesignTheme.secondaryTextBig,
                                    ),
                              ]),
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                  IconButton(
                                    splashColor: DesignTheme.mainColor,
                                    hoverColor: DesignTheme.secondColor,
                                    onPressed: (){ addClick();
                                      Navigator.pushNamed(context, '/history');
                                    }, 
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: DesignTheme.mainColor,
                                    size: 32,
                                    ),
                                  ),
                              )
                        ]),
                      )
                    )
                  )
                ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, top: 10, left: 30, right: 20),
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:<Widget>[

                    Text((caloryT < caloryY )? "-" + checkThousands((caloryT - caloryY).abs()).toString()
                     : "+" + checkThousands((caloryT - caloryY).abs()).toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 38.0,fontWeight: FontWeight.w900, 
                        color: (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL ) ? DesignTheme.secondColor : DesignTheme.redColor,
                      ),
                    ),

                    Text(' кКалорий',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w600, color: DesignTheme.gray170Color),
                    ),
                ])
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 0, left: 45, right: 20),
                child:
                  Text('По сравнению с вчерашним днём',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400, color: DesignTheme.gray50Color),
                  ),
              ),

                Padding(
                  padding: EdgeInsets.only(bottom:20, top: 0, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                    
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0, // has the effect of softening the shadow
                          spreadRadius: 2.0, // has the effect of extending the shadow
                          offset: Offset(
                            10.0, // horizontal, move right 10
                            10.0, // vertical, move down 10
                          ),
                        )
                      ],
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
                              child: charts.BarChart(
                                _seriesData,
                                animate: true,
                                barGroupingType: charts.BarGroupingType.stacked,
                                //behaviors: [new charts.SeriesLegend()],
                                animationDuration: Duration(seconds: 3),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 40, right: 40),
                              child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:<Widget>[
                                  Row(children:<Widget>[
                                    Icon(Icons.label, color: (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondColor : DesignTheme.redColor,),
                                    Text("Сегодня"),]),
                                  Row(children:<Widget>[
                                    Icon(Icons.label, color: (caloryT < caloryY || caloryT <= caloryLimitDeltaR && caloryT >= caloryLimitDeltaL )? DesignTheme.secondChartsGreen : DesignTheme.secondChartRed,),
                                    Text("Вчера"),]),
                                ]),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ),
          ]
        ),
    );
  }
}

checkThousands(double value) {
  if(value > 1000){
    return roundDouble(value/1000, 1).toString() + "К";
  }
  return value;
}

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}