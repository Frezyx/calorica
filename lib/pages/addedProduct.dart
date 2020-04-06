import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/textMonth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:gradient_widgets/gradient_widgets.dart';


class AddedProductPage extends StatefulWidget{
  String _id;
  String _from;
  AddedProductPage({String id, String from}): _id = id, _from = from;

  @override
  _AddedProductPageState createState() => _AddedProductPageState(_id, _from);
}

class _AddedProductPageState extends State<AddedProductPage> {
  String id;
  String from;
  _AddedProductPageState(this.id, this.from);

  ScrollController scrollController;
  UserProduct product = UserProduct(id:1,name:'Загрузка...',category:'Говядина и телятина', calory:0.0, squi:0.0, fat:0.0, carboh:0.0, date:"1.1.2020");

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

@override
  void initState() {
    super.initState();
    print("Пришла Дата " + id);
    DBUserProductsProvider.db.getProductById(int.parse(id)).then((prod){
      setState(() {
        product = prod;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, from == 'home'? '/': '/daydata/'+from);
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("Продукт",
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
                      child:                    
                      Padding(
                        padding:EdgeInsets.only(left:15, right: 15, bottom: 20, top: 20),
                        child:
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          
                          Text(product == null? 'Загрузка...' : product.name,
                            style: isStringOverSize(product.name)? DesignTheme.bigText20: DesignTheme.bigText24,
                            textAlign: TextAlign.start,
                            ),
// getTextMonth(product.date)
                          SizedBox(height:30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget>[
                                getParamText(roundDouble(product.calory,2)," кКал"),
                                getParamText(roundDouble(product.squi,2), " Белки г."),
                            ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget>[
                                getParamText(roundDouble(product.fat,2), " Жир г."),
                                getParamText(roundDouble(product.carboh,2), " Углеводы г."),
                            ])
                          ]),

                        ]),
                      ),
                    ),
                      Padding(
                        padding:EdgeInsets.only(left:10, right: 10, bottom: 20, top: 30),
                        child:
                    OutlineButton(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: Colors.red,
                      onPressed: () {
                        _badAllert(context, product.id);
                      },
                      child: 
                      Padding(
                        padding:EdgeInsets.only(left:10, right: 10, bottom: 10, top: 13),
                        child:Stack(
                          children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.close, color:Colors.red)
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      "Удалить",
                                      style: TextStyle(
                                        color:Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center,
                                  )
                              )
                          ],
                      ),
                      ),
                      highlightedBorderColor: Colors.red,
                      borderSide: new BorderSide(color: Colors.red),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)
                      )
                  )
                  )

                  // Padding(
                  //   padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 20),
                  //   child: 
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //     Text("В этот день вы съели:", style: DesignTheme.lilGrayText,),
                  //   ],),
                  // ),
                  // ),
                  ],
                ) 
              ),
            ),
          ),
        // ),
      );
  }

                  Future<void> _badAllert(context, id) async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return 
                           AlertDialog(
                            title: Text('Вы точно хотите удалить эту запись о приеме пищи ?'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Да', style: DesignTheme.midleMainText,),
                                    onPressed: () {
                                      DBUserProductsProvider.db.deleteById(id).then((response){
                                        Navigator.pushNamed(context, "/");
                                      });
                                    },
                                  ),
                            ]
                          );
                          },
                        );
                      }

  //   getCard(UserProduct data){
  //                   return  
  //                   Padding(
  //                   padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
  //                   child: 
  //                   Container(
  //                     decoration: BoxDecoration(
  //                       color: DesignTheme.whiteColor,
  //                       borderRadius: BorderRadius.all(Radius.circular(15)),
                        
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.black12.withOpacity(0.05),
  //                           blurRadius: 5.0, // has the effect of softening the shadow
  //                           spreadRadius: 2.0, // has the effect of extending the shadow
  //                           offset: Offset(
  //                             0.0, // horizontal, move right 10
  //                             5.0, // vertical, move down 10
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     child:
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5, left: 15),
  //                           child:
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             crossAxisAlignment:  CrossAxisAlignment.center,
  //                             children:<Widget>[
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children:<Widget>[
  //                               Text(splitText(data.name), style: DesignTheme.primeText16,),
  //                               Text(data.calory.toString() + " кКал     " +
  //                                     data.squi.toString() + " Б     " +
  //                                     data.fat.toString() + " Ж     " +
  //                                     data.carboh.toString() + " У" ,
                                  
  //                                 style: DesignTheme.secondaryText,),
  //                             ]),
  //                           ]),
  //                         ),
  //                         ),
  //                       );
  // }

  toStrDate(DateTime date){
    return date.day.toString()+'.'+date.month.toString()+'.'+date.year.toString();
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
}