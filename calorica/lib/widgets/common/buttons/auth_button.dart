import 'package:calorica/common/constants/assets/assets.dart';
import 'package:calorica/common/theme/theme.dart';
import 'package:calorica/widgets/common/buttons/custom_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key key,
    @required this.title,
    @required this.onTap,
    @required this.color,
    @required this.logoPath,
    @required this.titleStyle,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final Color color;
  final String logoPath;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return CustomRaisedButton(
        color: color,
        onPressed: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          logoPath,
          width: 30,
          height: 30,
        ),
        SizedBox(width: 15),
        Text(
          title,
          style: titleStyle,
        ),
        SizedBox(width: 30),
      ],
    ),);
  }
}