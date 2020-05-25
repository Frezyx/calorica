import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';

import 'package:flutter/material.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';


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
            onPressed: (){ addClick();
              Navigator.popAndPushNamed(context, from == 'home'? '/navigator/1': '/daydata/'+from);
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("Продукт",
           style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body:
        Padding(
          padding:EdgeInsets.only(top: 0,),
          child: 
            Container(
              padding: const EdgeInsets.all(0.0),
              constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
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
                      onPressed: (){ addClick();
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
                                    onPressed: (){ addClick();
                                      DBUserProductsProvider.db.deleteById(id).then((response){
                                        Navigator.popAndPushNamed(context, from == 'home'? '/navigator/1': '/daydata/'+from);
                                      });
                                    },
                                  ),
                            ]
                          );
                          },
                        );
                      }

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