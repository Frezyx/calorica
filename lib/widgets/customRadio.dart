import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 1.2, 'Минимум физической активности'));
    sampleData.add(new RadioModel(false, 1.375, 'Занимаюсь спортом 1-3 раза в неделю'));
    sampleData.add(new RadioModel(false, 1.55, 'Занимаюсь спортом 3-4 раза в неделю'));
    sampleData.add(new RadioModel(false, 1.7, 'Занимаюсь спортом каждый день'));
    sampleData.add(new RadioModel(false, 1.9, 'Тренируюсь по несколько раз в день'));
  }
  
                    Future<void> _goodAllert() async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Ваша диета сформированна'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Открыть'),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                ]
                              );
                            
                          },
                        );
                      }

                    Future<void> _badAllert() async {
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
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                            ]
                          );
                          },
                        );
                      }
                      
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      Padding(padding: EdgeInsets.only(top:120),
        child:
      Text("Выберите Степень вашей физической активности: ", style: DesignTheme.label,),),

      Padding(padding: EdgeInsets.only(top:170),
        child:
          ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                highlightColor: DesignTheme.secondColor,
                focusColor: DesignTheme.secondColor,

                splashColor: DesignTheme.secondColor,
                onTap: () {
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;
                  });
                  DBUserProvider.db.updateDateProducts("workModel", sampleData[index].multiplaier).then((count1){
                      if(count1 == 1){
                        _goodAllert();
                      }
                      else{
                        _badAllert();
                      }
                  });
                },
                child: new RadioItem(sampleData[index]),
              );
            },
          )
        ),
// Padding(padding: EdgeInsets.only(bottom:150),
//         child:
//         GradientButton(
//                         increaseWidthBy: 60,
//                         increaseHeightBy: 5,
//                         child: 
//                         Padding(
//                           child:Text(
//                           'Далее',
//                           textAlign: TextAlign.center,
//                           style: DesignTheme.buttonText,
//                           ), padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
//                         ),
//                         callback: () {
//                           // if(_formKey2.currentState.validate()){
//                           //   if(_age != null){
//                           //     setState(() {
//                           //       isSP = false;
//                           //     });
//                           //     // print("------------Все хорошо-------------" +_weight.toString() +" "+ _height.toString());
//                           //   }
//                           // }
//                         },
//                         shapeRadius: BorderRadius.circular(50.0),
//                         gradient: DesignTheme.gradient,
//                         shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
//                       ),),

      ]
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:0),
            child:
          new Container(
            height: 25.0,
            width: 25.0,
            child: new Center(
              child: new Icon(
                Icons.check,
                      color:
                          _item.isSelected ? Colors.white : Colors.black,
                      size: 18.0
                    ),
            ),
            decoration: new BoxDecoration(

              color: _item.isSelected
                  ? DesignTheme.secondColor
                  : Colors.transparent,

              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? DesignTheme.secondColor
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Column(children:[
              Text(_item.text, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)
            ]),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final double multiplaier;
  final String text;

  RadioModel(this.isSelected, this.multiplaier, this.text);
}