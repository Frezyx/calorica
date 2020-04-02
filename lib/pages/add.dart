import 'package:calory_calc/design/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';

class AddPage extends StatefulWidget{
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isSaerching = false;
  ScrollController scrollController;
  String searchText;
  List<Product> prod = [Product(name: "asas"),Product(name: "asas"),Product(name: "asas"),Product(name: "asas"),];

  void startSearch(String text){
    setState(() {
      isSaerching = true;
      searchText = text;
      print("Слушатель ответил:"+isSaerching.toString()+"Выслушал текст:"+searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
  onTap: () {
    FocusScope.of(context).requestFocus(new FocusNode());
  },child:          
     Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, size: 24,),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("Добавление приема пищи", style: TextStyle(fontWeight: FontWeight.w700),),
        // automaticallyImplyLeading: false,
      ),


      body: 
      Padding(
            padding: EdgeInsets.only(left: 20,right: 20,),
            child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
              Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: 
            Container(
              // padding: build(),
                decoration: BoxDecoration(
                  color: DesignTheme.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0, // has the effect of softening the shadow
                      spreadRadius: 2.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
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
                            labelText: 'Поиск по заметкам...',
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
                    return StaggeredGridView.countBuilder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(7.0),
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 0,
                      crossAxisCount: 4,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i){
                        return 
                        InkWell(
                          child: getCard(snapshot.data[i]) ,
                          onTap: (){
                            Navigator.pushNamed(context, '/product/'+snapshot.data[i].id.toString());
                          },
                        );
                      },
                      staggeredTileBuilder: (int i) => 
                        StaggeredTile.count(4,1));
                  }
              }
            })),),

      ]),),

      bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor:DesignTheme.mainColor,
                height: 50.0,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(microseconds: 1000),
            items: <Widget>[
              Icon(Icons.pie_chart_outlined, size: 28, color: Colors.black54,),
              Icon(FontAwesomeIcons.userAlt, size: 23, color: Colors.black54,),
              Padding(
                child:
                  Icon(Icons.add, size: 30, color: DesignTheme.whiteColor),
                  padding: EdgeInsets.all(3.0),
              ),
            ],
            index: 2,
            animationCurve: Curves.easeInExpo,
            onTap: (index) {
              if(index == 0){
                Navigator.pushNamed(context, '/');
              }
              if(index == 1){
                Navigator.pushNamed(context, '/');
              }
              if(index == 2){
                Navigator.pushNamed(context, '/add');
              }
            },
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
                                      data.fat.toString() + " У" ,
                                  
                                  style: DesignTheme.secondaryText,),
                              ]),
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                  IconButton(
                                    splashColor: DesignTheme.mainColor,
                                    hoverColor: DesignTheme.secondColor,
                                    onPressed: () {
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