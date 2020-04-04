import 'dart:math';

import 'package:calory_calc/design/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:gradient_widgets/gradient_widgets.dart';


class DayDatePage extends StatefulWidget{
  String _id;
  DayDatePage({String id}): _id = id;

  @override
  _DayDatePageState createState() => _DayDatePageState(_id);
}

class _DayDatePageState extends State<DayDatePage> {
  String id;
  _DayDatePageState(this.id);
  
  Product product = new Product();
  double calory = -1.0; double caloryConst = -1.0;
  double squi = -1.0; double squiConst = -1.0;
  double fat = -1.0; double fatConst = -1.0;
  double carboh = -1.0; double carbohConst = -1.0;

@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/add");
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text(product.name == null? 'Загрузка...' : splitText(product.name), style: TextStyle(fontWeight: FontWeight.w700),),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Card(
                      child:                    
                      Padding(
                        padding:EdgeInsets.only(left:15, right: 15, bottom: 20, top: 20),
                        child:
                        
                        Column(children: <Widget>[
                          
                          Text(product == null? 'Загрузка...' : product.name,
                            style: isStringOverSize(product.name)? DesignTheme.bigText20: DesignTheme.bigText24,
                            textAlign: TextAlign.start,
                            ),

                          SizedBox(height:10),

                        // Padding(
                        //   padding: EdgeInsets.only(left:15, right: 15, bottom: 3, top: 3),
                          // child:
                          //   TextFormField(
                          //     onChanged: (text){
                          //       multiData(int.parse(text));
                          //     },
                          //     style: DesignTheme.inputText,
                          //     cursorColor: DesignTheme.mainColor,
                          //     decoration: InputDecoration(
                                
                          //       labelText: 'Введите вес...',
                          //       labelStyle: DesignTheme.labelSearchTextBigger,
                          //       suffixIcon: Icon(
                          //           Icons.people,
                          //           // color: DesignTheme.blackColor,
                          //         )
                          //   ),
                          // ),

                        ]),
                      ),
                    ),
                  // ),

                    SizedBox(height:10),

                    Column(children:<Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          getParamText(calory,"кКал"),
                          getParamText(squi, "Белки г."),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          getParamText(fat, "Жир г."),
                          getParamText(carboh, "Углеводы г."),
                      ])
                    ]),
                    Padding(
                      child: GradientButton(
                        increaseWidthBy: 60,
                        increaseHeightBy: 5,
                        child: 
                        Padding(
                          child:Text(
                          'Добавить',
                          textAlign: TextAlign.center,
                          style: DesignTheme.buttonText,
                          ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                        ),
                        callback: () {

                              UserProduct productSend = UserProduct(
                                name: product.name,
                                category: product.category,
                                calory: calory,
                                carboh: carboh,
                                squi: squi,
                                fat: fat,
                              );

                              print(calory.toString()+" "+fat.toString()+" "+squi.toString()+" "+carboh.toString());

                              addProduct(productSend).then((res){
                                DBDateProductsProvider.db.getPoductsByDate(res.date).then((products){
                                  products.ids += ";" + res.id.toString();
                                  DBDateProductsProvider.db.updateDateProducts(products);
                                });

                                var now = DateTime.now();
                                var strNow = toStrDate(now);
                                
                                if(res.date == strNow){
                                    Navigator.pushNamed(context, '/');
                                }

                              });
                        },
                        shapeRadius: BorderRadius.circular(50.0),
                        gradient: DesignTheme.gradient,
                        shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
                      ),
                    padding: EdgeInsets.only(left:15, right: 15, bottom: 10, top: 10)),
                  ],
                ) 
              ),
            ),
          ),
        // ),
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
      padding: EdgeInsets.only(left:30, right: 30, bottom: 3, top: 3),
      child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
      Text(value.toString(), style: DesignTheme.bigMainText,),
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
}