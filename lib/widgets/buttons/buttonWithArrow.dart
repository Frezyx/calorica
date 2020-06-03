import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

class CustomButton{
  static getButtonArrowForward(String text, String router, context){
    return FlatButton(
                color: Colors.transparent,
                padding: EdgeInsets.all(0.0),
                splashColor: DesignTheme.mainColor,
                focusColor: DesignTheme.mainColor,
                highlightColor: Colors.white,
                hoverColor: Colors.white,
                onPressed: () { Navigator.popAndPushNamed(context, router);},
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: DesignTheme.mainColor,),
                    Text(text, style: TextStyle(color: DesignTheme.mainColor,))
                  ],
                ),
              );
  }
}