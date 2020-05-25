


import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/pages/add.dart';
import 'package:calory_calc/pages/home.dart';
import 'package:calory_calc/pages/stats/mainStats.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:flutter/material.dart';

import 'navigatorBody.dart';

class NavigatorPage extends StatefulWidget{
  NavigatorPage({int index}): _index = index; int _index;

  @override
  _NavigatorPageState createState() => _NavigatorPageState(_index);
}

class _NavigatorPageState extends State<NavigatorPage> {
  _NavigatorPageState(this.index);
  int index;
  bool isFromAnotherContext;
  var _pageController = PageController();

  List<Widget> pages = <Widget>[ 
    MainStats(),
    Home(),
    AddPage(),
  ];

    @override
  void initState() {
    if(this.mounted){
      
      setState(() {
        isFromAnotherContext = index != null;
        index = index ?? 0;
      });
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
            body: PageView.builder(
              itemBuilder: (ctx, i) => pages[index],
              itemCount: pages.length,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (i) {
                
                setState(() {
                  index = i;
                });
          }),

        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0,
                              spreadRadius: 2.0, 
                              offset: Offset(
                                10.0, 
                                5.0, 
                              ),
                            )],
            color: DesignTheme.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: BubbleBottomBar(
            
            currentIndex: index,
            backgroundColor: Colors.transparent,
            onTap: (int i) {
              if(isFromAnotherContext){
                isFromAnotherContext = false;
                _pageController.jumpToPage(index);
              }
              _pageController.jumpToPage(i);
              addClick();
            },
            items: getBubbleBarBody(),
            opacity: 1,
            elevation: 0,
          ),
        ),
    );
  }
}