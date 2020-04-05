import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/dietSelector.dart';
import 'package:calory_calc/widgets/range.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/utils/databaseHelper.dart';

class Data{
  int id;

  Data({this.id});
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController;
  List<UserProduct> userProducts;
  double caloryNow = 0.0;
  double squiNow = 0.0;
  double fatNow = 0.0;
  double carbohNow = 0.0;

  double caloryLimit = 2900.0;
  double squiLimit = 100.0;
  double fatLimit = 100.0;
  double carbohLimit = 400.0;

  double caloryPercent = 0.0;
  double squiPercent = 0.0;
  double fatPercent = 0.0;
  double carbohPercent = 0.0;

  String name = "";
  String surname = "";
  List<Data> data = [];



  RangeGraphData calory = RangeGraphData( name: "кКалории",percent: 0.0,weigth: 0);
  RangeGraphData fat = RangeGraphData( name: "Жиры",percent: 0.0,weigth: 0);
  RangeGraphData squi = RangeGraphData( name: "Белки",percent: 0.0 ,weigth: 0);
  RangeGraphData carboh = RangeGraphData( name: "Углеводы",percent: 0.0,weigth: 0);

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

  @override
  void initState() {
    super.initState();
      DBUserProvider.db.getUser().then((res){
        DBUserProductsProvider.db.getAllProducts().then((products){

          var diet = selectDiet(res);

          setState(() {
            name = res.name;
            surname = res.surname;
            caloryLimit = diet.calory;
            squiLimit = diet.squi;
            fatLimit = diet.fat;
            carbohLimit = diet.carboh;
          });

          for (var i = 0; i < products.length; i++) {
              caloryNow = roundDouble(caloryNow + products[i].calory, 2);
              squiNow = roundDouble(squiNow + products[i].squi, 2);
              fatNow = roundDouble(fatNow + products[i].fat, 2);
              carbohNow = roundDouble(carbohNow + products[i].carboh, 2);
          }
          setState(() {
            
            calory.weigth = caloryNow;
            fat.weigth = fatNow;
            squi.weigth = squiNow;
            carboh.weigth = carbohNow;

            calory.limit = caloryLimit;
            fat.limit = fatLimit;
            squi.limit = squiLimit;
            carboh.limit = carbohLimit;

            calory.percent = (caloryNow/caloryLimit)*100 <= 100? (caloryNow/caloryLimit)*100 : 100;
            fat.percent = (fatNow/fatLimit)*100 <= 100? (fatNow/fatLimit)*100 : 100;
            squi.percent = (squiNow/squiLimit)*100 <= 100? (squiNow/squiLimit)*100 : 100;
            carboh.percent = (carbohNow/carbohLimit)*100 <= 100? (carbohNow/carbohLimit)*100 : 100;
            // calory.gradient = getColor(calory);
            // fat.gradient = getColor(fat);
            // squi.gradient = getColor(squi);
            // carboh.gradient = getColor(carboh);
          });
        });
      });
    for (var i = 0; i < 6; i++) {
        data.add(Data(id:i));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTheme.bgColor,
      body:
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  constraints: BoxConstraints.expand(height: 340),
                  decoration: BoxDecoration(
                    gradient: DesignTheme.gradient,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(140), bottomRight: Radius.circular(140))
                  ),
                    
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children:<Widget>[
                                Text(name + " " + surname ,
                                  style: TextStyle(    fontWeight: FontWeight.w600,
                                  fontSize: MediaQuery.of(context).size.width*0.085,
                                  color: Colors.white
                                  )
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width*0.08,
                                    ),
                                 onPressed: (){

                                 })
                              ]),
                              getBigRangeWidget(calory),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  getRangeWidget(squi),
                                  getRangeWidget(fat),
                                  getRangeWidget(carboh),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child:
                                Text("Сегодня " + DateFormat('dd.MM.yyyy').format(DateTime.now()),
                                  textAlign: TextAlign.start,
                                  style: DesignTheme.lilWhiteText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:280, left: 30, right: 30),
                  constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height-280),
                  child: 
                    FutureBuilder<List<UserProduct>>(
                      // initialData: data,
                      future: DBUserProductsProvider.db.getAllProducts(),
                      builder:
                      (BuildContext context, AsyncSnapshot<List<UserProduct>> snapshot) {
                      switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                        return new Text('Input a URL to start');
                                      case ConnectionState.waiting:
                                        return new Center(child: new CircularProgressIndicator());
                                      case ConnectionState.active:
                                        return new Text('');
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return new Text(
                                            '${snapshot.error}',
                                            style: TextStyle(color: Colors.red),
                                          );
                                        } else{
                          return StaggeredGridView.countBuilder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(7.0),
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 3.0,
                            crossAxisCount: 6,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i){
                              return 
                              InkWell(
                          child: 
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 1.0,
                                child:
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(splitText(snapshot.data[i].name), style: DesignTheme.primeText,),
                                          Text(snapshot.data[i].calory.toString() + " кКал  "+ snapshot.data[0].fat.toString() +" Грамм", style: DesignTheme.secondaryText,)
                                        ],
                                      ),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, '/addedProduct/${snapshot.data[i].id}');
                                },
                              );
                            },
                            staggeredTileBuilder: (int i) => 
                              StaggeredTile.count(3,2));
                        }
                        }
                        // else 
                        // {
                        //   return Center(child: CircularProgressIndicator());
                        // }
                      }
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
              Icon(Icons.pie_chart_outlined, size: 30, color: Colors.black54,),
              Padding(
                child:
                  Icon(FontAwesomeIcons.userAlt, size: 26, color: DesignTheme.whiteColor),
                  padding: EdgeInsets.all(7.0),
              ),
              Icon(Icons.add, size: 30, color: Colors.black54,),
            ],
            index: 1,
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
  splitText(String text){
    if(text.length <= 20) return text;
    else return text.substring(0,20);
  }

  getRangeWidget(RangeGraphData range) {
    return  Padding(padding: EdgeInsets.only(top: 10, right: 10, left: 0),child: 
            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      range.name,
                                      style: DesignTheme.lilWhiteText,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 6,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: (range.percent * 0.01)*80,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                gradient:getColor(range.percent),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        range.weigth.toString()+" / "+ range.limit.toString()+ ' г',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: DesignTheme.whiteColor
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
  }
  getBigRangeWidget(RangeGraphData range) {
    return  Padding(padding: EdgeInsets.only(top: 10, right: 0, left: 0),
                child: 
                  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:<Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 20,),
                                          child: 
                                          Text(
                                            range.name,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context).size.width*0.051,
                                              letterSpacing: -0.2,
                                              color: DesignTheme.whiteColor,
                                            ),
                                          ),
                                        ),

                                      Text(
                                        range.weigth.toString()+" / "+ range.limit.toString(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: MediaQuery.of(context).size.width*0.051,
                                          letterSpacing: -0.2,
                                          color: DesignTheme.whiteColor,
                                        ),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 10,
                                        width: MediaQuery.of(context).size.width-122,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: (MediaQuery.of(context).size.width-122)*range.percent*0.01,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                gradient:getColor(range.percent),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
  }
}