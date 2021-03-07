import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/pages/product/products_list.dart';
import 'package:calory_calc/pages/home/home.dart';
import 'package:calory_calc/pages/stats/mainStats.dart';
import 'package:flutter/material.dart';

import 'bottom_bar/bottom_bar.dart';

class NavigatorPage extends StatefulWidget {
  NavigatorPage({int index}) : _index = index;
  int _index;

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
    if (this.mounted) {
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
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [DesignTheme.originalShadow],
          color: DesignTheme.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: BottomBar(
          items: [
            Icons.bar_chart_rounded,
            Icons.home_rounded,
            Icons.add,
          ],
          onSelected: (int i) {
            setState(() {
              index = i;
            });
          },
        ),
      ),
    );
  }
}
