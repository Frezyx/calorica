import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:calory_calc/models/dbModels.dart';

class HistoryPage extends StatefulWidget{
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isSaerching = false;
  ScrollController scrollController;
  String searchText;
  List<UserProduct> prod = [UserProduct(name: "asas"),UserProduct(name: "asas"),UserProduct(name: "asas"),UserProduct(name: "asas"),];

  void startSearch(String text){
    setState(() {
      isSaerching = true;
      searchText = text;
      // print("Слушатель ответил:"+isSaerching.toString()+"Выслушал текст:"+searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
 onTap: (){ addClick(); 
    FocusScope.of(context).requestFocus(new FocusNode());
  },child:          
     Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){ addClick();
              Navigator.popAndPushNamed(context, "/navigator/0");
            },
            icon:Icon(Icons.arrow_back, size: 24,)
          ),
        elevation: 5.0,
        backgroundColor: DesignTheme.whiteColor,
        title: Text("История питания", style: TextStyle(fontWeight: FontWeight.w700),),
        // automaticallyImplyLeading: false,
      ),


      body: 
      Padding(
            padding: EdgeInsets.only(top: 15, left: 20,right: 20,),
            child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
              Padding(
            padding: EdgeInsets.only(top: 15, bottom: 20),
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
                            labelText: 'Поиск по дате...',
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
              Text("Итория приема пищи в днях:", style: DesignTheme.lilGrayText,),
          ),
          Flexible(
              child:
          Container(
        padding: const EdgeInsets.all(0.0),
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: FutureBuilder(
            future: DBDateProductsProvider.db.getDates(),
            builder: (BuildContext context, AsyncSnapshot<List<DateProducts>> snapshot) {
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
                        //Изменить
                        InkWell(
                          child: getCard(snapshot.data[i]) ,
                         onTap: (){ addClick(); 
                            Navigator.pushNamed(context, '/daydata/${snapshot.data[i].date}');
                          },
                        );
                      },
                      staggeredTileBuilder: (int i) => 
                        StaggeredTile.count(4,1));
                  }
              }
            })),),

      ]),),
        ),
    );
  }

  getCard(DateProducts data){
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
                                  Text(splitText(data.date), style: DesignTheme.primeText16,),
                                  // Text(data.calory.toString() + " кКал",
                                  // style: DesignTheme.secondaryText,),
                              ]),
                              Align(
                                alignment: Alignment.centerRight,
                                child:
                                  IconButton(
                                    splashColor: DesignTheme.mainColor,
                                    hoverColor: DesignTheme.secondColor,
                                    onPressed: (){ addClick();
                                      // print("Id:" + data.id.toString());
                                      Navigator.pushNamed(context, '/daydata/${data.date.toString()}');
                                    }, 
                                  icon: Icon(
                                    Icons.arrow_forward,
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