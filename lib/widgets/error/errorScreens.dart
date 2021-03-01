import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/buttons/buttonWithArrow.dart';
import 'package:calory_calc/widgets/buttons/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ErrorScreens {

  static Widget getErrorScreen(String imagePath, String path, String text, String subText, String buttonText, bool isButtonUsed,  IconData icon, context){
    return 
    Container(
      width: MediaQuery.of(context).size.height * 0.46,
      height: MediaQuery.of(context).size.height -300,
      child: getScreenBody(imagePath, path, text, subText, buttonText, isButtonUsed, icon, context),
    );
  }

  static Widget getScreenBody(imagePath, path, text, subText, buttonText, isButtonUsed, icon, context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          SvgPicture.asset(imagePath),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: DesignTheme.bigErrorText,),
          ),
          CustomButton.getButtonArrowForward(path, icon, buttonText, context),
        ]
    );
  }

  
  static getNoMealScreen(context){
    return getErrorScreen("assets/svg/noMeal.svg", "/navigator/2", "Сегодня вы ничего не ели", "Добавьте прием пищи в меню поиска продукта", "Добавить", true, Icons.add, context);
  }

  static getOnDevelopmentScreen(context){
    return getErrorScreen("assets/svg/dev.svg", "/editUser", "Страница находится в разработке", "Добавьте прием пищи в меню поиска продукта", "Назад", true, Icons.arrow_back, context);
  }

}