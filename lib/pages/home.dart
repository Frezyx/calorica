import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

import 'package:calory_calc/utils/databaseHelper.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String name = "";
  String surname = "";

    @override
  void initState() {
    super.initState();
      DBUserProvider.db.getUser().then((res){
          name = res.name;
          surname = res.surname;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(children:<Widget>[
                                Text(name + " " + surname ,style: DesignTheme.bigWhiteText,),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 32,
                                    ),
                                 onPressed: (){

                                 })
                              ]),
                              getRangeWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          );
  }

  getRangeWidget() {
    return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Жиры',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: DesignTheme.gray50Color,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 0, top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 20,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Colors.red[500],
                                                  Colors.red[800],
                                                ]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 6),
                                    //   child: Text(
                                    //     '10г осталось',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(
                                    //       // fontFamily: FintnessAppTheme.fontName,
                                    //       fontWeight: FontWeight.w600,
                                    //       fontSize: 12,
                                    //       color: DesignTheme.gray50Color
                                    //           .withOpacity(0.5),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                );
  }
}