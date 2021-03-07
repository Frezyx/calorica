import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/widgets/range.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
    @required this.name,
    @required this.surname,
    @required this.calory,
    @required this.squi,
    @required this.fat,
    @required this.carboh,
  }) : super(key: key);

  final String name;
  final String surname;
  final RangeGraphData calory;
  final RangeGraphData squi;
  final RangeGraphData fat;
  final RangeGraphData carboh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getSubText(name, surname, context),
                    getIconButton(context),
                  ],
                ),
                getBigRangeWidget(calory, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getRangeWidget(squi, context),
                    getRangeWidget(fat, context),
                    getRangeWidget(carboh, context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  splitBigTxt(String text) {
    if (text.length <= 13)
      return text;
    else
      return text.substring(0, 13);
  }

  getIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Colors.white,
        size: MediaQuery.of(context).size.width * 0.08,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/editUser');
      },
    );
  }

  getSubText(String name, String surname, BuildContext context) {
    if ((name + " " + surname).length <= 11) {
      return Text(
        name + " " + surname,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.085,
            color: Colors.white),
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                splitBigTxt(name) + " " + splitBigTxt(surname),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width *
                        0.11 *
                        (name + " " + surname).length *
                        0.04,
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      );
    }
  }

  getRangeWidget(RangeGraphData range, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10, left: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            range.name,
            style: DesignTheme.lilWhiteText,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0, top: 4),
            child: Container(
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: (range.percent * 0.01) * 80,
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: getColor(range.percent),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              range.weigth.toString() + " / " + range.limit.toString() + ' г',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: DesignTheme.whiteColor),
            ),
          ),
        ],
      ),
    );
  }

  getBigRangeWidget(RangeGraphData range, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 0, left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    range.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width * 0.051,
                      letterSpacing: -0.2,
                      color: DesignTheme.whiteColor,
                    ),
                  ),
                ),
                Text(
                  range.weigth.toString() + " / " + range.limit.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * 0.051,
                    letterSpacing: -0.2,
                    color: DesignTheme.whiteColor,
                  ),
                ),
              ]),
          Padding(
            padding: const EdgeInsets.only(right: 0, top: 4),
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width - 122,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width - 122) *
                        range.percent *
                        0.01,
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: getColor(range.percent),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
