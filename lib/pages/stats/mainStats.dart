
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/pages/stats/barGraph.dart';
import 'package:calory_calc/pages/stats/lineWeekGraph.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/utils/adMobHelper/adMobHelper.dart';
import 'package:calory_calc/utils/dietSelector.dart';
import 'package:calory_calc/utils/doubleRounder.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/stats/prepareDataByDay.dart';
import 'package:calory_calc/utils/stats/prepareDataByWeek.dart';
import 'package:calory_calc/widgets/stats/caloryTextColumn.dart';
import 'package:calory_calc/widgets/stats/paramTextColumn.dart';
import 'package:calory_calc/widgets/textHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MainStats extends StatefulWidget {
  final Widget child;

  MainStats({Key key, this.child}) : super(key: key);

  _MainStatsState createState() => _MainStatsState();
}

class _MainStatsState extends State<MainStats> {

  List<charts.Series<GraphData, String>> _seriesData = [];
  List<charts.Series<GraphLinarData, String>> _chartData = [];

  List<UserProduct> userTodayProducts;
  List<UserProduct> userYesterdayProducts;

  UserProduct todayParams = null;
  UserProduct yesterdayParams = null;
  List<UserProduct> weekStats;

  var caloryLimit = 0.0;
  var caloryLimitDeltaL = 0.0;
  var caloryLimitDeltaR = 0.0;
  List<Widget> chartsWidgetList = [CircularProgressIndicator()];
  List<Widget> lineTextList = [CircularProgressIndicator()];

  bool isAutoPlay = true;

  @override
  void initState() {
    super.initState();
    getProductsCaloryByDateList().then((_weekStats){

      setState(() {
        weekStats = _weekStats;
      });

      DBUserProvider.db.getUser().then((res){
        var diet = selectDiet(res);
        caloryLimit = diet.calory;
        caloryLimitDeltaL = caloryLimit * 0.7;
        caloryLimitDeltaR = caloryLimit * 1.2;
      });

      DBUserProductsProvider.db.getTodayProducts().then((todayProd){
        DBUserProductsProvider.db.getYesterdayProducts().then((yesterdayProd){
          
          setState(() {
            todayParams = getProductsParamsSum(todayProd);
            yesterdayParams = getProductsParamsSum(yesterdayProd);
          });

            setState((){
              _chartData = createSampleData(weekStats);
              _seriesData = generateData(yesterdayParams, todayParams, caloryLimitDeltaR , caloryLimitDeltaL );

              chartsWidgetList.removeLast();
              lineTextList.removeLast();

              chartsWidgetList.add(getBarGraph(context, _seriesData, caloryLimitDeltaL, caloryLimitDeltaR, todayParams, yesterdayParams));
              chartsWidgetList.add(getLineGraph(context, _chartData));
              chartsWidgetList.add(AdMobHelper.getAdMobGraphBaner(context));
              lineTextList.add(getCaloryTextColumn(todayParams, yesterdayParams, caloryLimitDeltaR, caloryLimitDeltaL));
              lineTextList.add(getOtherParamTextColumn(todayParams.squi, yesterdayParams.squi, " г. белков"));
              lineTextList.add(getOtherParamTextColumn(todayParams.fat, yesterdayParams.fat, " г. жиров"));
              lineTextList.add(getOtherParamTextColumn(todayParams.carboh, yesterdayParams.carboh, " г. углеводов"));
              lineTextList.add(getOtherParamTextColumn(todayParams.grams, yesterdayParams.grams, " грамм"));
            });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 50, left: 30, right: 20),
                child: getStartText(todayParams, yesterdayParams, caloryLimitDeltaR, caloryLimitDeltaL),
              ),

              Padding(
                  padding: EdgeInsets.only(bottom:20, top: 20, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [DesignTheme.originalShadow]
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

                Container(
                  height: 93.0,
                  child:
                  CarouselSlider.builder(
                    itemCount: lineTextList.length,
                    itemBuilder:  (context, index){
                      return lineTextList[index];
                      },
                      options: CarouselOptions(
                            height: 93.0,
                            viewportFraction: 1,
                            autoPlay: isAutoPlay,
                            autoPlayCurve: Curves.easeInExpo,
                            autoPlayInterval: const Duration(seconds: 6),
                            onPageChanged: (index, reason) {
                            }
                      ),
                    ),
                ),

              Container(
                  height: 300.0,
                  child:
                  CarouselSlider.builder(
                    itemCount: chartsWidgetList.length,
                    itemBuilder:  (context, index){
                      return chartsWidgetList[index];
                      },
                      options: CarouselOptions(
                            height: 300.0,
                            viewportFraction: 1,
                            autoPlay: isAutoPlay,
                            autoPlayCurve: Curves.easeInExpo,
                            autoPlayInterval: const Duration(seconds: 8),
                            onPageChanged: (index, reason) {
                            }
                      ),
                    ),
                ),
          ]
        ),
      )
    );
  }
}