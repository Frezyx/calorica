import 'package:calorica/common/constants/assets/assets.dart';
import 'package:calorica/screens/home/widgets/body.dart';
import 'package:calorica/widgets/common/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: [
          Image(
            width: size.width,
            image: AssetImage(Assets.background),
            fit: BoxFit.fitWidth,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HomeBody(),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        items: [
          Icons.pie_chart_outline_rounded,
          Icons.home_outlined,
          Icons.add_box_outlined,
        ],
        onSelected: (int index) {},
      ),
    );
  }
}
