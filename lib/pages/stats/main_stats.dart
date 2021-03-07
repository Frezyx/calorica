import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/pages/stats/barGraph.dart';
import 'package:calory_calc/pages/stats/lineWeekGraph.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/utils/adMobHelper/adMobHelper.dart';
import 'package:calory_calc/utils/dietSelector.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/stats/prepareDataByDay.dart';
import 'package:calory_calc/utils/stats/prepareDataByWeek.dart';
import 'package:calory_calc/widgets/crads/info_card.dart';
import 'package:calory_calc/widgets/stats/paramTextColumn.dart';
import 'package:calory_calc/widgets/textHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'widgets/widgets.dart';

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
  List<Widget> chartsWidgetList = [Center(child: CircularProgressIndicator())];
  List<Widget> lineTextList = [];

  bool isAutoPlay = true;

  //TODO: REFACTOR THIS
  @override
  void initState() {
    super.initState();
    getProductsCaloryByDateList().then((_weekStats) {
      setState(() {
        weekStats = _weekStats;
      });

      DBUserProvider.db.getUser().then((res) {
        var diet = selectDiet(res);
        caloryLimit = diet.calory;
        caloryLimitDeltaL = caloryLimit * 0.7;
        caloryLimitDeltaR = caloryLimit * 1.2;
      });

      DBUserProductsProvider.db.getTodayProducts().then((todayProd) {
        DBUserProductsProvider.db.getYesterdayProducts().then((yesterdayProd) {
          setState(() {
            todayParams = getProductsParamsSum(todayProd);
            yesterdayParams = getProductsParamsSum(yesterdayProd);
          });

          setState(() {
            _chartData = createSampleData(weekStats);
            _seriesData = generateData(
              yesterdayParams,
              todayParams,
              caloryLimitDeltaR,
              caloryLimitDeltaL,
            );

            chartsWidgetList.removeLast();

            chartsWidgetList.add(
              getBarGraph(
                context,
                _seriesData,
                caloryLimitDeltaL,
                caloryLimitDeltaR,
                todayParams,
                yesterdayParams,
              ),
            );

            chartsWidgetList.add(
              getLineGraph(
                context,
                _chartData,
              ),
            );

            lineTextList.add(getOtherParamTextColumn(
              todayParams,
              yesterdayParams,
              ' кКалорий',
              getParamText(todayParams, yesterdayParams, caloryLimitDeltaR,
                  caloryLimitDeltaL),
            ));
            lineTextList.add(
              getOtherParamTextColumn(
                todayParams.squi,
                yesterdayParams.squi,
                " г. белков",
                getOtherParamText(todayParams.squi, yesterdayParams.squi),
              ),
            );
            lineTextList.add(
              getOtherParamTextColumn(
                todayParams.fat,
                yesterdayParams.fat,
                " г. жиров",
                getOtherParamText(todayParams.fat, yesterdayParams.fat),
              ),
            );
            lineTextList.add(
              getOtherParamTextColumn(
                todayParams.carboh,
                yesterdayParams.carboh,
                " г. углеводов",
                getOtherParamText(todayParams.carboh, yesterdayParams.carboh),
              ),
            );
            lineTextList.add(
              getOtherParamTextColumn(
                todayParams.grams,
                yesterdayParams.grams,
                " грамм",
                getOtherParamText(todayParams.grams, yesterdayParams.grams),
              ),
            );
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: getStartText(
                todayParams,
                yesterdayParams,
                caloryLimitDeltaR,
                caloryLimitDeltaL,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: DesignTheme.shadowByOpacity(0.05),
              ),
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "История питания",
                          style: DesignTheme.primeTextBig,
                        ),
                        Text(
                          "Узнай как ты питаешься",
                          style: DesignTheme.secondaryTextBig,
                        ),
                      ]),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      splashColor: CustomTheme.mainColor,
                      hoverColor: CustomTheme.mainColor,
                      onPressed: () {
                        Navigator.pushNamed(context, '/history');
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: CustomTheme.mainColor,
                        size: 26,
                      ),
                    ),
                  )
                ],
              ),
            ),
            InfoCard(
              title:
                  "По сравнению с ${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: -1)))}",
              enableDivider: false,
            ),
            SizedBox(
              height: 10,
            ),
            StatsParamsPanel(
              items: lineTextList,
            ),
            Container(
              height: 290.0,
              child: CarouselSlider.builder(
                itemCount: chartsWidgetList.length,
                itemBuilder: (context, index) {
                  return chartsWidgetList[index];
                },
                options: CarouselOptions(
                    height: 290.0,
                    viewportFraction: 1,
                    autoPlay: isAutoPlay,
                    autoPlayCurve: Curves.easeInExpo,
                    autoPlayInterval: const Duration(seconds: 8),
                    onPageChanged: (index, reason) {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
