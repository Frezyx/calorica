import 'package:calory_calc/widgets/navigation/bottom_bar/src/src.dart';
import 'package:flutter/material.dart';

export 'src/src.dart';

class BottomBar extends StatefulWidget {
  final List<IconData> items;
  final Function(int index) onSelected;

  const BottomBar({
    Key key,
    @required this.items,
    @required this.onSelected,
  }) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 60,
      color: theme.cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildItems(widget.items),
      ),
    );
  }

  List<Widget> _buildItems(List<IconData> items) {
    final buildedItems = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      buildedItems.add(
        BottomBarItem(
          iconData: items[i],
          isSelected: _selectedItem == i,
          onTap: () => _onSelectItem(i),
        ),
      );
    }
    return buildedItems;
  }

  void _onSelectItem(int i) {
    setState(() => _selectedItem = i);
    widget.onSelected(i);
  }
}
