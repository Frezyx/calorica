import 'dart:math';

import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:gradient_widgets/gradient_widgets.dart';


class ProductPage extends StatefulWidget{
    String _id;

  ProductPage({String id}): _id = id;

  @override
  _ProductPageState createState() => _ProductPageState(_id);
}

class _ProductPageState extends State<ProductPage> {
  String id;
  _ProductPageState(this.id);
  final _grammController = new TextEditingController( );
  Product product = Product();
  String name = "";
  double calory = -1.0; double caloryConst = -1.0;
  double squi = -1.0; double squiConst = -1.0;
  double fat = -1.0; double fatConst = -1.0;
  double carboh = -1.0; double carbohConst = -1.0;
  BannerAd _bannerAd;

  bool canWriteInDB = true;

  final _formKey = GlobalKey<FormState>( );

  setWriteStatus(state){
    setState(){
      canWriteInDB = state;
    }
  }

@override
  void initState() {
    super.initState();
    _grammController.text = '100.0';
      DBProductProvider.db.getProductById(int.parse(id)).then((res){
        setState(() {
          product = res;
          calory = res.calory;
          squi = res.squi;
          fat = res.fat;
          carboh = res.carboh;
          name = res.name;
        });
      });
  }

  void multiData(double grams){
    double multiplier = grams / 100;
     setState(() {
       calory = roundDouble(product.calory * multiplier,2);
       squi = roundDouble(product.squi * multiplier, 2);
       fat = roundDouble(product.fat * multiplier, 2);
       carboh = roundDouble(product.carboh * multiplier, 2);
     });
  }

  double roundDouble(double value, int places){ 
    double mod = pow(10.0, places); 
    return ((value * mod).round().toDouble() / mod); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){ addClick();
              Navigator.popAndPushNamed(context, "/navigator/2");
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text(name == ''? 'Загрузка...' : splitText(name), style: TextStyle(fontWeight: FontWeight.w700),),
        // automaticallyImplyLeading: false,
      ),
      body:
        Padding(
          padding:EdgeInsets.only(
            top: 0,
                ),
          child: 
                Container(
              padding: const EdgeInsets.all(0.0),
              constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
              child: 
              Padding(
                padding:EdgeInsets.only(left:15, right: 15, bottom: 20, top: 20),
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: DesignTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
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
                        
                        Column(children: <Widget>[
                          
                          Text(product == null? 'Загрузка...' : name,
                            style: isStringOverSize(name)? DesignTheme.bigText20: DesignTheme.bigText24,
                            textAlign: TextAlign.start,
                            ),

                          SizedBox(height:10),

                          Form(key: _formKey, 
                            child: TextFormField(
                              onChanged: (text){
                                if(_formKey.currentState.validate()){}
                                multiData(double.parse(text));
                              },
                              controller: _grammController,
                              style: DesignTheme.inputText,
                              cursorColor: DesignTheme.mainColor,
                              decoration: InputDecoration(
                                
                                labelText: 'Введите вес...',
                                labelStyle: DesignTheme.labelSearchTextBigger,
                                suffixIcon: Icon(
                                    Icons.people,
                                  )
                            ),
                            validator: (value){
                              if (value.isEmpty){
                                setWriteStatus(false);
                                return 'Введите вес продукта';
                              } 
                              else if (!(double.parse(value) is double)){
                                setWriteStatus(false);
                                return 'Введите число';
                              } 
                              else {
                                setWriteStatus(true);
                              }
                            },
                          ),
                        ),
                        ]),
                      ),
                    ),

                    SizedBox(height:10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[
                          getParamText(calory,"кКал"),
                          getParamText(squi, "Белки г."),
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                name: name,
                                category: product.category,
                                calory: calory,
                                carboh: carboh,
                                squi: squi,
                                fat: fat,
                              );

                              print(calory.toString()+" "+fat.toString()+" "+squi.toString()+" "+carboh.toString());

                              addProduct(productSend).then((res){
                                DBDateProductsProvider.db.getPoductsByDate(res.date, res.id).then((products){
                                  try {
                                    products.ids += ";" + res.id.toString();
                                    print(products.ids);
                                  } catch (e) {

                                  }
                                  DBDateProductsProvider.db.updateDateProducts(products);
                                });

                                var now = DateTime.now();
                                var strNow = toStrDate(now);
                                
                                if(res.date == strNow){
                                    Navigator.pushNamed(context, '/navigator/1');
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
      print(nowClient.name + " --- " + nowClient.id.toString());
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