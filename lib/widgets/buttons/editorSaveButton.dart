import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/widgets/alerts/easyGoogAlert.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

getEditorSaveButton(_formKey, user, context){
  return        GradientButton(
                  increaseWidthBy: 60,
                  increaseHeightBy: 5,
                  child: 
                  Padding(
                    child:Text(
                    'Сохранить',
                    textAlign: TextAlign.center,
                    style: DesignTheme.buttonText,
                    ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                  ),
                  callback: () {
                    if(_formKey.currentState.validate()){
                      DBUserProvider.db.updateUser(user).then((count){
                        if(count == 1){
                          goodAllert(context);
                        }
                      });
                    }
                  },
                  shapeRadius: BorderRadius.circular(50.0),
                  gradient: DesignTheme.gradient,
                  shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.0),
                );
}