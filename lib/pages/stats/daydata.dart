import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:calory_calc/config/adMobConfig.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/utils/textMonth.dart';

class DayDatePage extends StatefulWidget{
  String _date;
  DayDatePage({String date}): _date = date;

  @override
  _DayDatePageState createState() => _DayDatePageState(_date);
}

class _DayDatePageState extends State<DayDatePage> {
  String date;
  _DayDatePageState(this.date);
  final _controller = NativeAdmobController();

  ScrollController scrollController;
  // Product product = new Product();
  double calory = -1.0; 
  double squi = -1.0; 
  double fat = -1.0; 
  double carboh = -1.0; 

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

@override
  void initState() {
    super.initState();
    print("Пришла Дата " + date);
    DBDateProductsProvider.db.getPoductsIDsByDate(date).then((idList){
      for (var i = 0; i < idList.length; i++) {
        DBUserProductsProvider.db.getProductById(idList[i]).then((product){
          setState(() {
            calory += product.calory;
            squi += product.squi;
            fat += product.fat;
            carboh += product.carboh;
          });
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){ addClick();
              Navigator.pushNamed(context, "/history");
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("История дня",
          // product.name == null? 'Загрузка...' : splitText(product.name),
           style: TextStyle(fontWeight: FontWeight.w700),),
        // automaticallyImplyLeading: false,
      ),
      body:
        Padding(
          padding:EdgeInsets.only(
            top: 0,
                // right: 15, left: 15,
                // top: 30,
                // bottom: MediaQuery.of(context).size.height/4,
                ),
          child: 
              // Flexible(
              //       child:
            Container(

              padding: const EdgeInsets.all(0.0),
              constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0)
              //   ),
              // elevation: 1.0,
              child: 
              Padding(
                padding:EdgeInsets.only(left:15, right: 15, bottom: 20, top: 20),
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: DesignTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        
                        boxShadow: [DesignTheme.originalShadow],
                      ),
                      child:                    
                      Padding(
                        padding:EdgeInsets.only(left:15, right: 15, bottom: 20, top: 20),
                        child:
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          
                          Text(getTextMonth(date),
                            // product == null? 'Загрузка...' : product.name,
                            style: isStringOverSize("Привет")? DesignTheme.bigText: DesignTheme.blackText,
                            textAlign: TextAlign.start,
                            ),

                          SizedBox(height:30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget>[
                                getParamText(roundDouble(calory,2)," кКал"),
                                getParamText(roundDouble(squi,2), " Белки г."),
                            ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget>[
                                getParamText(roundDouble(fat,2), " Жир г."),
                                getParamText(roundDouble(carboh,2), " Углеводы г."),
                            ])
                          ]),
                        ]),
                      ),
                    ),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 20),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                      Text("В этот день вы съели:", style: DesignTheme.lilGrayText,),
                    ],),
                  ),
                  // ),
                    Flexible(
                      child:
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
                      child: FutureBuilder(
                        future: DBUserProductsProvider.db.getProductsByDate(date),
                        builder: (BuildContext context, AsyncSnapshot<List<UserProduct>> snapshot) {
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
                              } else {
                                  var count = snapshot.data.length;
                                  if(count > 5){
                                    snapshot.data.insert(5, UserProduct(date:"Реклама"));
                                  }
                                  else if(count > 3){
                                    snapshot.data.insert(3, UserProduct(date:"Реклама"));
                                  }
                                  else if(count > 1){
                                    snapshot.data.insert(1, UserProduct(date:"Реклама"));
                                  }
                                  else{
                                    snapshot.data.insert(0, UserProduct(date:"Реклама"));
                                  }
                                return StaggeredGridView.countBuilder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.all(7.0),
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 0,
                                  crossAxisCount: 4,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i){
                                  return snapshot.data[i].date == "Реклама"?Card(
                                    shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          elevation: 1.0,
                                    child:Container(
                                    height: 330,
                                    child:
                                    NativeAdmob(
                                      adUnitID: AdMobConfig.NATIVE_ADMOB_UNIT_ID,
                                      controller: _controller,
                                    ))):
                                    //Изменить
                                    InkWell(
                                      child: getCard(snapshot.data[i]) ,
                                     onTap: (){ addClick(); 
                                        Navigator.pushNamed(context, '/daydata/${snapshot.data[i].date}');
                                      },
                                    );
                                  },
                                  staggeredTileBuilder: (int i) => 
                                    StaggeredTile.count(4,1));
                              }
                          }
                        })
                      ),
                    ),
                  ],
                ) 
              ),
            ),
          ),
        // ),
      );
  }

    getCard(UserProduct data){
                    return  
                    Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                    child: 
                    Container(
                      decoration: BoxDecoration(
                        color: DesignTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 5.0, // has the effect of softening the shadow
                            spreadRadius: 2.0, // has the effect of extending the shadow
                            offset: Offset(
                              0.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child:
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5, left: 15),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:  CrossAxisAlignment.center,
                              children:<Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget>[
                                Text(splitText(data.name), style: DesignTheme.primeText16,),
                                Text(data.calory.toString() + " кКал     " +
                                      data.squi.toString() + " Б     " +
                                      data.fat.toString() + " Ж     " +
                                      data.carboh.toString() + " У" ,
                                  
                                  style: DesignTheme.secondaryText,),
                              ]),
                               Align(
                                alignment: Alignment.centerRight,
                                child:
                                  IconButton(
                                    splashColor: DesignTheme.mainColor,
                                    hoverColor: DesignTheme.secondColor,
                                    onPressed: (){ addClick();
                                      Navigator.pushNamed(context, '/addedProduct/${data.id}/$date');
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

  toStrDate(DateTime date){
    return date.day.toString()+'.'+date.month.toString()+'.'+date.year.toString();
  }

  Future<DateAndCalory> addProduct(UserProduct nowClient) async{
      // print(nowClient.name + " --- " + nowClient.surname);
      DateAndCalory res = await DBUserProductsProvider.db.addProduct(nowClient);
      return res;
  }

  getParamText(double value, String name){
    return 
    Padding(
      padding: EdgeInsets.only(left:5, bottom: 5, top: 5),
      child:
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget>[
      Text(value.toString(), style: DesignTheme.midleMainText,),
      Text(name, style: DesignTheme.labelSearchText,),
      ]));
  }
                                      String splitText(String text) {
                                    if(text.length <= 20){
                                      return text;
                                    }
                                    return text.substring(0, 20)+'...';
                                  }
                                  bool isStringOverSize(String text) {
                                    if(text.length <= 50){
                                      return false;
                                    }
                                    return true;
                                  }

  void addClick() {}
}