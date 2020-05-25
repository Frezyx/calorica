import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioSelector extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioSelectorState();
  }
}

class CustomRadioSelectorState extends State<CustomRadioSelector> {
  List<RadioModel> sampleData = new List<RadioModel>();
  int workModel = 1;

  @override
  void initState() {

    super.initState();
    sampleData.add(new RadioModel(true, 1, 'Минимум физической активности', "slim", "Похудеть", "Диета для быстрого похудения", 20));
    sampleData.add(new RadioModel(false, 2, 'Занимаюсь спортом 1-3 раза в неделю', "normal", "Сохранить вес", "Стандартное, здоровое питание", 5));
    sampleData.add(new RadioModel(false, 3, 'Занимаюсь спортом 3-4 раза в неделю', "strong", "Набрать вес", "Диета для набора массы", 20));
  }
  
                  
                      
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 110,left: 30.0),
        child:
      Text("Выберите свою цель: ", style: DesignTheme.selectorLabel,),),
      Padding(padding: EdgeInsets.only(top:110),
        child:
        Column(
          children: <Widget>[
            
        Container(
          height: MediaQuery.of(context).size.height/2.2,
          child:
          ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,

                splashColor: Colors.transparent,
               onTap: (){
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                    workModel = sampleData[index].multiplaier;
                  });
                  // DBUserProvider.db.updateDateProducts("workModel", sampleData[index].multiplaier).then((count1){
                  //     if(count1 == 1){
                  //       Navigator.pushNamed(context, '/selectActiviti');
                  //     }
                  //     else{
                  //       // Implement
                  //     }
                  // });
                },
                child: new RadioItem(sampleData[index]),
              );
            },
          )
        ),

                      GradientButton(
                        increaseWidthBy: 60,
                        increaseHeightBy: 5,
                        child: 
                        Padding(
                          child:Text(
                          'Далее',
                          textAlign: TextAlign.center,
                          style: DesignTheme.buttonText,
                          ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                        ),
                        callback: () {
                           DBUserProvider.db.updateDateProducts("workFutureModel", workModel).then((count1){
                              if(count1 == 1){
                                _goodAllert(context);
                                // Navigator.pushNamed(context, '/selectActiviti');
                              }
                              else{
                                _badAllert(context);
                                // Implement
                              }
                          });
                        },
                        shapeRadius: BorderRadius.circular(50.0),
                        gradient: DesignTheme.gradient,
                        shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
                      ),

          ],
        )
        ),
      ]
    );
  }
}

  Future<void> _goodAllert(context) async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Ваша диета сформированна'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Открыть', style: TextStyle(color: DesignTheme.mainColor ),),
                                    
                                    onPressed: (){ addClick();
                                      Navigator.pushNamed(context, '/navigator/1');
                                    },
                                  ),
                                ]
                              );
                            
                          },
                        );
                      }

                    Future<void> _badAllert(context) async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return 
                           AlertDialog(
                            title: Text('Что-то пошло не так'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ещё раз'),
                                    onPressed: (){ addClick();
                                      Navigator.pop(context);
                                    },
                                  ),
                            ]
                          );
                          },
                        );
                      }

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // color:  DesignTheme.secondColor,
        decoration: new BoxDecoration(
          boxShadow: _item.isSelected? [DesignTheme.selectorShadow] : [DesignTheme.transperentShadow],
          color: _item.isSelected ? DesignTheme.whiteColor: DesignTheme.selectorGrayBackGround,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected? DesignTheme.mainColor: Colors.transparent),
              borderRadius: const BorderRadius.all(const Radius.circular(12.0)),
            ),
      margin: new EdgeInsets.only(bottom: 15, left: 30.0, right: 30.0,),
      padding: new EdgeInsets.only(left:20, right:20, top: 7.5,bottom: 7.5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(_item.title, style: _item.isSelected? DesignTheme.selectorBigTextAction : DesignTheme.selectorBigText,),
            Text(_item.subtitle, style: DesignTheme.selectorMiniLabel )
          ],),
          Padding(
            padding: new EdgeInsets.only(right:_item.padding),
            child: Container(
              child: _item.isSelected ? Image.asset("assets/selector/"+_item.icon+"Color.png", height: 80,) : Image.asset("assets/selector/"+_item.icon+".png", height: 80,),
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final int multiplaier;
  final String text;
  final String icon;
  final String title;
  final String subtitle;
  final double padding;

  RadioModel(this.isSelected, this.multiplaier, this.text, this.icon, this.title, this.subtitle, this.padding);
}