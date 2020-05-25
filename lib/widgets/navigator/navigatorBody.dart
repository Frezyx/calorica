import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

getBubbleBarBody(){
  return <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                backgroundColor: DesignTheme.mainColor,
                icon: Icon(
                  Icons.pie_chart_outlined,
                  size: 25.0,
                  color: DesignTheme.gray50Color
                ),
                activeIcon: Icon(
                  Icons.pie_chart_outlined,
                  size: 25.0,
                  color: Colors.white,
                ),
                title: Text(
                  'Статистика',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BubbleBottomBarItem(
                backgroundColor: DesignTheme.mainColor,
                icon: Icon(
                  Icons.person,
                  size: 25.0,
                  color: DesignTheme.gray50Color,
                ),
                activeIcon: Icon(
                  Icons.person,
                  size: 25.0,
                  color: Colors.white,
                ),
                title: Text(
                  'Главная',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BubbleBottomBarItem(
                backgroundColor: DesignTheme.mainColor,
                icon: Icon(
                  Icons.add,
                  size: 25.0,
                  color: DesignTheme.gray50Color,
                ),
                activeIcon: Icon(
                  Icons.add,
                  size: 25.0,
                  color: Colors.white,
                ),
                title: Text(
                  'Продукты',
                  style: TextStyle(color: Colors.white),
                ),
              )];
}