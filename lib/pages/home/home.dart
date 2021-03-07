import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/common/theme/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/pages/home/widgets/widgets.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/doubleRounder.dart';
import 'package:calory_calc/widgets/error/errorScreens.dart';
import 'package:calory_calc/models/range.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';

class Data {
  int id;

  Data({this.id});
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController;
  List<UserProduct> userProducts;
  double caloryNow = 0.0;
  double squiNow = 0.0;
  double fatNow = 0.0;
  double carbohNow = 0.0;

  double caloryLimit = 2900.0;
  double squiLimit = 100.0;
  double fatLimit = 100.0;
  double carbohLimit = 400.0;

  double caloryPercent = 0.0;
  double squiPercent = 0.0;
  double fatPercent = 0.0;
  double carbohPercent = 0.0;

  bool isNameSurnameBig = false;
  bool isNameBiggerSurname = false;

  String name = "";
  String surname = "";
  List<Data> data = [];
  List<UserProduct> emptyProduct = [];

  double paddingTop = 280;

  RangeGraphData calory =
      RangeGraphData(name: "кКалории", percent: 0.0, weigth: 0);
  RangeGraphData fat = RangeGraphData(name: "Жиры", percent: 0.0, weigth: 0);
  RangeGraphData squi = RangeGraphData(name: "Белки", percent: 0.0, weigth: 0);
  RangeGraphData carboh =
      RangeGraphData(name: "Углеводы", percent: 0.0, weigth: 0);

  @override
  void initState() {
    super.initState();
    DBUserProvider.db.getUser().then((res) {
      DBUserProductsProvider.db.getAllProducts().then((products) {
        paddingTop = products.length > 0 ? paddingTop : 200;
        Diet diet;

        DBDietProvider.db.getDietById(1).then((_diet) {
          diet = _diet;

          if (this.mounted) {
            setState(() {
              name = res.name;

              surname = res.surname;
              caloryLimit = diet.calory;
              squiLimit = diet.squi;
              fatLimit = diet.fat;
              carbohLimit = diet.carboh;

              isNameSurnameBig = !((name + " " + surname).length <= 11);
              isNameBiggerSurname = name.length > surname.length;
              emptyProduct.add(UserProduct(name: "Кнопка добавления"));
            });
          }

          for (var i = 0; i < products.length; i++) {
            caloryNow = roundDouble(caloryNow + products[i].calory, 2);
            squiNow = roundDouble(squiNow + products[i].squi, 2);
            fatNow = roundDouble(fatNow + products[i].fat, 2);
            carbohNow = roundDouble(carbohNow + products[i].carboh, 2);
          }

          if (this.mounted) {
            setState(() {
              calory.weigth = caloryNow;
              fat.weigth = fatNow;
              squi.weigth = squiNow;
              carboh.weigth = carbohNow;

              calory.limit = caloryLimit;
              fat.limit = fatLimit;
              squi.limit = squiLimit;
              carboh.limit = carbohLimit;

              calory.percent = (caloryNow / caloryLimit) * 100 <= 100
                  ? (caloryNow / caloryLimit) * 100
                  : 100;
              fat.percent = (fatNow / fatLimit) * 100 <= 100
                  ? (fatNow / fatLimit) * 100
                  : 100;
              squi.percent = (squiNow / squiLimit) * 100 <= 100
                  ? (squiNow / squiLimit) * 100
                  : 100;
              carboh.percent = (carbohNow / carbohLimit) * 100 <= 100
                  ? (carbohNow / carbohLimit) * 100
                  : 100;
            });
          }
        });
      });
    });
    for (var i = 0; i < 6; i++) {
      data.add(Data(id: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: DesignTheme.backgroundColor,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 190),
            decoration: BoxDecoration(
              gradient: DesignTheme.gradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: HomeAppBar(
                      name: name,
                      surname: surname,
                      calory: calory,
                      squi: squi,
                      fat: fat,
                      carboh: carboh,
                    ),
                  ),
                ],
              ),

              // TODO: enable in new UI version
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                child: Text(
                  "Сегодня вы ели".toUpperCase(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 25, right: 25),
                child: Divider(height: 1),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: FutureBuilder<List<UserProduct>>(
                      initialData: emptyProduct,
                      future: DBUserProductsProvider.db.getAllProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<UserProduct>> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return ErrorScreens.getNoMealScreen(context);
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                            return Text('');
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return ErrorScreens.getNoMealScreen(context);
                            } else {
                              if (snapshot.data.length > 0) {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  controller: scrollController,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return AddedProductCard(
                                      product: snapshot.data[i],
                                    );
                                  },
                                );
                              } else {
                                return ErrorScreens.getNoMealScreen(context);
                              }
                            }
                        }
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
