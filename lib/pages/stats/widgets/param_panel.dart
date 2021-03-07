import 'package:calory_calc/design/theme.dart';
import 'package:flutter/material.dart';

class StatsParamsPanel extends StatelessWidget {
  StatsParamsPanel({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    final lines = _configureItems(items, context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: lines,
      ),
    );
  }

  List<Widget> _configureItems(List<Widget> items, BuildContext context) {
    final lines = <Widget>[];
    for (var i = 0; i < items.length - 1; i += 2) {
      if (i != 0) {
        lines.add(
          SizedBox(height: 15),
        );
      }
      lines.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard(items[i], context),
            _buildCard(items[i + 1], context),
          ],
        ),
      );
    }
    return lines;
  }

  Widget _buildCard(Widget item, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.44,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: DesignTheme.shadowByOpacity(0.03),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: item,
      ),
    );
  }
}
