import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/config/adMobConfig.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class AddPage extends StatefulWidget{
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isSaerching = false;
  ScrollController scrollController;
  String searchText;

   final _controller = NativeAdmobController();

  void startSearch(String text){
    setState(() {
      isSaerching = true;
      searchText = text;
    });
  }

   @override
   void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
 onTap: (){ addClick(); 
    FocusScope.of(context).requestFocus(new FocusNode());
  },child:          
     Scaffold(
      body: 
      Padding(
            padding: EdgeInsets.only(top: 45, left: 20,right: 20,),
            child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15,),
            child:
          Text("Добавление приема пищи", style: DesignTheme.bigText20),),
              Padding(
            padding: EdgeInsets.only(top: 15, bottom: 20),
            child: 
            Container(
                decoration: BoxDecoration(
                  color: DesignTheme.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0, 
                      spreadRadius: 2.0,
                      offset: Offset(
                        10.0,
                        10.0,
                      ),
                    )
                  ],
                ),
                child: 
                TextFormField(
                        onChanged: (text) {
                          startSearch(text);
                        },
                          style: DesignTheme.inputText,

                          keyboardType: TextInputType.text,
                          
                          decoration: InputDecoration(
                            icon: Padding(
                              padding: EdgeInsets.only(left:15,),
                              child:
                                Icon(Icons.search, color: DesignTheme.mainColor,),
                            ),
                            contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                            labelText: 'Поиск по продуктам...',
                            border: InputBorder.none,
                            labelStyle: DesignTheme.labelSearchText,
                          ),
                          onEditingComplete: () {},
                        ),
              ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15,),
            child: 
              Text("Результаты поиска:", style: DesignTheme.lilGrayText,),
          ),
          Flexible(
              child:
          Container(
        padding: const EdgeInsets.all(0.0),
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: FutureBuilder(
            future: isSaerching? DBProductProvider.db.getAllProductsSearch(searchText): DBProductProvider.db.getAllProducts(),
            builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Input a URL to start');
                case ConnectionState.waiting:
                  return new Center(child: new CircularProgressIndicator());
                case ConnectionState.active:
                  return new Text('');
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return new Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    var count = snapshot.data.length;
                    if(count > 5){
                      snapshot.data.insert(5, Product(name:"Реклама"));
                    }
                    else if(count > 3){
                      snapshot.data.insert(3, Product(name:"Реклама"));
                    }
                    else if(count > 1){
                      snapshot.data.insert(1, Product(name:"Реклама"));
                    }
                    else{
                      snapshot.data.insert(0, Product(name:"Реклама"));
                    }
                    return StaggeredGridView.countBuilder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(7.0),
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 0,
                      crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i){
                        return snapshot.data[i].name == "Реклама"?
                        Card(
                           shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 1.0,
                          child:Container(
                          height: 330,
                          child:
                          NativeAdmob(
                            adUnitID: AdMobConfig.NATIVE_ADMOB_UNIT_ID,
                            controller: _controller,
                          )))
                        :InkWell(
                          child: getCard(snapshot.data[i]) ,
                         onTap: (){ addClick(); 
                            Navigator.pushNamed(context, '/product/'+snapshot.data[i].id.toString());
                          },
                        );
                      },
                      staggeredTileBuilder: (int i) => 
                        StaggeredTile.count(4,1));
                  }
              }
            })),),
          ]),
        ),
      ),
    );
  }

  getCard(Product data){
                    return Card(
                           shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                elevation: 1.0,
                          child: 
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5, left: 15),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:  CrossAxisAlignment.center,
                              children:<Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget>[
                                  Text(splitText(data.name), style: DesignTheme.primeText16,),
                                  Text(data.calory.toString() + " кКал     " +
                                      data.squi.toString() + " Б     " +
                                      data.fat.toString() + " Ж     " +
                                      data.carboh.toString() + " У" ,
                                  
                                  style: DesignTheme.secondaryText,),
                              ]),
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                  IconButton(
                                    splashColor: DesignTheme.mainColor,
                                    hoverColor: DesignTheme.secondColor,
                                    onPressed: (){ addClick();
                                      Navigator.pushNamed(context, '/product/'+data.id.toString());
                                    }, 
                                  icon: Icon(
                                    Icons.add,
                                    color: DesignTheme.mainColor,
                                    size: 28,
                                    ),
                                  ),
                              )
                            ]),
                          ),
                        );
  }
                                    String splitText(String text) {
                                    if(text.length <= 22){
                                      return text;
                                    }
                                    return text.substring(0, 22)+'...';
                                  }
}