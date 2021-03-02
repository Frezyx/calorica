import 'package:calory_calc/providers/local_providers/dateProvider.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';
import 'package:calory_calc/utils/doubleRounder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:calory_calc/config/adMobConfig.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/textMonth.dart';
import 'package:intl/intl.dart';

class DayDatePage extends StatefulWidget {
  String _date;
  DayDatePage({String date}) : _date = date;

  @override
  _DayDatePageState createState() => _DayDatePageState(_date);
}

class _DayDatePageState extends State<DayDatePage> {
  String date;
  _DayDatePageState(this.date);
  var intDate;

  final _controller = NativeAdmobController();

  ScrollController scrollController;
  double calory = 0.0;
  double squi = 0.0;
  double fat = 0.0;
  double carboh = 0.0;
  int dateInt;

  @override
  void initState() {
    intDate = int.parse(date);
    super.initState();

    dateInt = int.parse(date);

    DBUserProductsProvider.db.getProductsByDate(dateInt).then((products) {
      for (var product in products) {
        setState(() {
          calory += product.calory;
          squi += product.squi;
          fat += product.fat;
          carboh += product.carboh;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/history");
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            )),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text(
          "История дня",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 0,
        ),
        child: Container(
          padding: const EdgeInsets.all(0.0),
          constraints:
              BoxConstraints.expand(height: MediaQuery.of(context).size.height),
          child: Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  getDayCard(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "В этот день вы съели:",
                          style: DesignTheme.lilGrayText,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height),
                      child: FutureBuilder(
                        future: DBUserProductsProvider.db
                            .getProductsByDate(intDate),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<UserProduct>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Input a URL to start');
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                              return Text('');
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: TextStyle(color: Colors.red),
                                );
                              } else {
                                return StaggeredGridView.countBuilder(
                                    controller: scrollController,
                                    padding: const EdgeInsets.all(7.0),
                                    mainAxisSpacing: 3,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 4,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        child: getProductCard(snapshot.data[i]),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              '/addedProduct/${snapshot.data[i].id}/$intDate');
                                        },
                                      );
                                    },
                                    staggeredTileBuilder: (int i) =>
                                        StaggeredTile.count(4, 1));
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  getDayCard() {
    return Container(
      decoration: BoxDecoration(
        color: DesignTheme.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [DesignTheme.originalShadow],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.fromMillisecondsSinceEpoch(dateInt)),
                style: isStringOverSize(date)
                    ? DesignTheme.bigText
                    : DesignTheme.blackText,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 30),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getParamText(roundDouble(calory, 2), " кКал"),
                          getParamText(roundDouble(squi, 2), " Белки г."),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          getParamText(roundDouble(fat, 2), " Жир г."),
                          getParamText(roundDouble(carboh, 2), " Углеводы г."),
                        ])
                  ]),
            ]),
      ),
    );
  }

  getProductCard(UserProduct data) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignTheme.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: DesignTheme.shadowByOpacity(0.05),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5, left: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        splitText(data.name),
                        style: DesignTheme.primeText16,
                      ),
                      Text(
                        getKBGUText(data),
                        style: DesignTheme.secondaryText,
                      ),
                    ]),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    splashColor: DesignTheme.mainColor,
                    hoverColor: DesignTheme.secondColor,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/addedProduct/${data.id}/$intDate');
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: DesignTheme.mainColor,
                      size: 28,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  getParamText(double value, String name) {
    return Padding(
        padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value.toString(),
                style: DesignTheme.midleMainText,
              ),
              Text(
                name,
                style: DesignTheme.labelSearchText,
              ),
            ]));
  }

  String splitText(String text) {
    if (text.length <= 20) {
      return text;
    }
    return text.substring(0, 20) + '...';
  }

  bool isStringOverSize(String text) {
    if (text.length <= 50) {
      return false;
    }
    return true;
  }

  void addClick() {}
}

getKBGUText(data) {
  return data.calory.toString() +
      " кКал     " +
      data.squi.toString() +
      " Б     " +
      data.fat.toString() +
      " Ж     " +
      data.carboh.toString() +
      " У";
}
