import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/providers/local_providers/productProvider.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/adMobHelper/adMobHelper.dart';
import 'package:calory_calc/utils/doubleRounder.dart';
import 'package:calory_calc/widgets/alerts/badEditionAlert.dart';

import 'package:flutter/material.dart';

import 'package:calory_calc/models/dbModels.dart';

class AddedProductPage extends StatefulWidget {
  String _id;
  String _from;

  AddedProductPage({String id, String from})
      : _id = id,
        _from = from;

  @override
  _AddedProductPageState createState() => _AddedProductPageState(_id, _from);
}

class _AddedProductPageState extends State<AddedProductPage> {
  String id;
  String from;
  _AddedProductPageState(this.id, this.from);

  String productParamTxt = "";
  bool isEdited = false;
  var productParams = Product();
  final _formKey = GlobalKey<FormState>();

  ScrollController scrollController;
  UserProduct product = UserProduct(
      id: 1,
      name: 'Загрузка...',
      category: 'Говядина и телятина',
      calory: 0.0,
      squi: 0.0,
      fat: 0.0,
      carboh: 0.0,
      date: DateTime.now());

  @override
  void initState() {
    super.initState();
    DBUserProductsProvider.db.getProductById(int.parse(id)).then((prod) {
      setState(() {
        product = prod;
        productParamTxt = product.grams.toString();
      });
      DBProductProvider.db.getProductById(product.productId).then((res) {
        setState(() {
          productParams = res;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context,
                  from == 'home' ? '/navigator/1' : '/daydata/' + from);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
            )),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text(
          "Продукт",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 0,
          ),
          child: Container(
            padding: const EdgeInsets.all(0.0),
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height),
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: DesignTheme.whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [DesignTheme.originalShadow],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, bottom: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product == null ? 'Загрузка...' : product.name,
                              style: isStringOverSize(product.name)
                                  ? DesignTheme.bigText20
                                  : DesignTheme.bigText24,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 5),
                            isEdited
                                ? getTextForm()
                                : getBigParamText(product.grams, " грамм"),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        getParamText(
                                            roundDouble(product.calory, 2),
                                            " кКал"),
                                        getParamText(
                                            roundDouble(product.squi, 2),
                                            " Белки г."),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        getParamText(
                                            roundDouble(product.fat, 2),
                                            " Жир г."),
                                        getParamText(
                                            roundDouble(product.carboh, 2),
                                            " Углеводы г."),
                                      ])
                                ]),
                          ],
                        ),
                      ),
                    ),
                    isEdited ? getSaveButton(_formKey) : getDeleteButton(),
                    isEdited ? getChangeEditButton() : getEditingButton(),
                    SizedBox(height: 20),
                    AdMobHelper.getAdBigBlock(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  getTextForm() {
    final TextEditingController _ageController = TextEditingController();
    _ageController.text = productParamTxt;

    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Form(
            key: _formKey,
            child: TextFormField(
              cursorColor: CustomTheme.mainColor,
              decoration: InputDecoration(
                labelText: 'Кол-во грамм',
                labelStyle: DesignTheme.selectorLabel,
              ),
              onChanged: (text) {
                if (_formKey.currentState.validate()) {}
                multiData(double.parse(text));
              },
              validator: (value) {
                if (value.isEmpty) return 'Введите кол-во грамм приема пищи';
                if (!(double.parse(value) is double))
                  return 'Введите число';
                else {
                  product.grams = double.parse(value);
                }
              },
            )));
  }

  void multiData(double grams) {
    double multiplier = grams / 100;
    setState(() {
      product.calory = roundDouble(productParams.calory * multiplier, 2);
      product.squi = roundDouble(productParams.squi * multiplier, 2);
      product.fat = roundDouble(productParams.fat * multiplier, 2);
      product.carboh = roundDouble(productParams.carboh * multiplier, 2);
    });
  }

  getChangeEditButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: OutlineButton(
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            splashColor: Colors.red,
            onPressed: () {
              setState(() {
                isEdited = false;
              });
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 13),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.close, color: Colors.red)),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Отменить",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            highlightedBorderColor: Colors.red,
            borderSide: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
  }

  getEditingButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: OutlineButton(
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            splashColor: DesignTheme.darkBlue,
            onPressed: () {
              setState(() {
                isEdited = true;
              });
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 13),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.edit, color: DesignTheme.darkBlue)),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Редактировать",
                        style: TextStyle(
                            color: DesignTheme.darkBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            highlightedBorderColor: DesignTheme.darkBlue,
            borderSide: BorderSide(color: DesignTheme.darkBlue),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
  }

  getSaveButton(_formKey) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 30),
        child: OutlineButton(
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            splashColor: CustomTheme.mainColor,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                DBUserProductsProvider.db.updateProduct(product).then((res) {
                  if (res) {
                    setState(() {
                      isEdited = false;
                    });
                  } else {
                    badEditAlert(context);
                  }
                });
              }
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 13),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.check, color: CustomTheme.mainColor)),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Сохранить",
                        style: TextStyle(
                            color: CustomTheme.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            highlightedBorderColor: CustomTheme.mainColor,
            borderSide: BorderSide(color: CustomTheme.mainColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
  }

  getDeleteButton() {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 30),
        child: OutlineButton(
            hoverColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            splashColor: Colors.red,
            onPressed: () {
              _badAllert(context, product.id);
            },
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 13),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.close, color: Colors.red)),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Удалить",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
            highlightedBorderColor: Colors.red,
            borderSide: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))));
  }

  Future<void> _badAllert(context, id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Вы точно хотите удалить эту запись о приеме пищи ?'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Да',
                  style: DesignTheme.midleMainText,
                ),
                onPressed: () {
                  DBUserProductsProvider.db.deleteById(id).then((response) {
                    Navigator.popAndPushNamed(context,
                        from == 'home' ? '/navigator/1' : '/daydata/' + from);
                  });
                },
              ),
              FlatButton(
                child: Text(
                  'Нет',
                  style: DesignTheme.midleMainText,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]);
      },
    );
  }

  toStrDate(DateTime date) {
    return date.day.toString() +
        '.' +
        date.month.toString() +
        '.' +
        date.year.toString();
  }

  getParamText(double value, String name) {
    return Padding(
        padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value.toString(),
                style: DesignTheme.midleMainText,
              ),
              Text(
                name,
                style: DesignTheme.labelSearchText,
              ),
            ]));
  }

  getBigParamText(double value, String name) {
    return Padding(
        padding: EdgeInsets.only(left: 5, top: 10, bottom: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                value.toString(),
                style: DesignTheme.midleMainTextBig,
              ),
              Text(
                name,
                style: DesignTheme.labelSearchTextBig,
              ),
            ]));
  }

  String splitText(String text) {
    if (text.length <= 20) {
      return text;
    }
    return text.substring(0, 20) + '...';
  }

  bool isStringOverSize(String text) {
    if (text.length <= 50) {
      return false;
    }
    return true;
  }
}
