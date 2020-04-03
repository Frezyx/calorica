import 'package:calory_calc/design/theme.dart';
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
  List<charts.Series<Pollution, String>> _seriesData;

  _generateData() {
    var data1 = [
      new Pollution(1980, 'Белки', 30),
      new Pollution(1980, 'Жиры', 40),
      new Pollution(1980, 'Углеводы', 10),
    ];

    var data2 = [
      new Pollution(1980, 'Белки', 30),
      new Pollution(1980, 'Жиры', 40),
      new Pollution(1980, 'Углеводы', 10),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2.4.2020',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(DesignTheme.secondChartsGreen),
      ), 
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '3.4.2020',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(DesignTheme.secondColor),
      ), 
    );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 40, left: 20, right: 20),
                child:Text(
                  "Сегодня вы - молодец!",style: DesignTheme.bigText,
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
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/historyEat');
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

                    Text('-557',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 38.0,fontWeight: FontWeight.w900, color: DesignTheme.secondColor),
                    ),

                    Text(' калорий',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.w600, color: DesignTheme.gray170Color),
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
                                    Icon(Icons.label, color: DesignTheme.secondColor,),
                                    Text("Сегодня"),]),
                                  Row(children:<Widget>[
                                    Icon(Icons.label, color: DesignTheme.secondChartsGreen,),
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

        bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor:DesignTheme.mainColor,
                height: 50.0,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(microseconds: 1000),
            items: <Widget>[
              Padding(
                child:
                  Icon(Icons.pie_chart_outlined, size: 26, color: DesignTheme.whiteColor),
                  padding: EdgeInsets.all(7.0),
              ),
              Icon(FontAwesomeIcons.userAlt, size: 30, color: Colors.black54,),
              Icon(Icons.add, size: 30, color: Colors.black54,),
            ],
            index: 0,
            animationCurve: Curves.easeInExpo,
            onTap: (index) {
              if(index == 0){
                Navigator.pushNamed(context, '/stats');
                // DBUserProductsProvider.db.deleteAll();
                // Navigator.pushNamed(context, '/');
              }
              if(index == 1){
                Navigator.pushNamed(context, '/');
              }
              if(index == 2){
                Navigator.pushNamed(context, '/add');
              }
            },
          ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}