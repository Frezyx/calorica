import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    @required this.title,
    this.enableDivider = true,
  }) : super(key: key);

  final String title;
  final bool enableDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ),
          if (enableDivider)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Divider(height: 1),
            ),
        ],
      ),
    );
  }
}
