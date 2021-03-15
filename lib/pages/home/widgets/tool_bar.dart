import 'package:calory_calc/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeToolBar extends StatelessWidget {
  const HomeToolBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // TODO: create settings page button
          // ToolBarIconButton(
          //   icon: Icon(
          //     Icons.settings,
          //     color: theme.accentColor,
          //   ),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/editUser');
          //   },
          // ),
          // SizedBox(width: 4),
          ToolBarIconButton(
            icon: Icon(
              FontAwesomeIcons.userCircle,
              color: theme.accentColor,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/editUser');
            },
          ),
        ],
      ),
    );
  }
}
