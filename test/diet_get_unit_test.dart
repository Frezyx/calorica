
import 'package:calory_calc/models/dbModels.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calory_calc/utils/dietSelector.dart';

void  main(){
  runTests();
}

void runTests(){

  dietTest("The diet should be taken according to the formula workFutureModel 1", 76.0, 186.0, 18.0, true, 1.2, 1, 2206.7, 165.5, 73.6, 220.7);
  dietTest("The diet should be taken according to the formula workFutureModel 2", 76.0, 186.0, 18.0, true, 1.2, 2, 2206.7, 193.1, 85.8, 248.3);
  dietTest("The diet should be taken according to the formula workFutureModel 3", 76.0, 186.0, 18.0, true, 1.2, 3, 2206.7, 179.3, 67.4, 275.8);

  dietTest("The diet should be taken according to the formula for litle thin woman", 50.0, 150.0, 30.0, false, 1.7, 1, 1919.1, 143.9, 64.0, 191.9);

}

void dietTest(_testName, _weight, _height, _age, _gender, _workModel, _workFutureModel, _calory, _squi, _fat, _carboh){
  test(_testName, (){
    var userTest = new User(id:1, name:"Тест", surname:"Тест", weight:_weight, height:_height, age:_age, gender:_gender, workModel:_workModel, workFutureModel: _workFutureModel, clickCount:0);
    var userRealDiet = DietParams(calory: _calory, squi: _squi, fat: _fat, carboh: _carboh);
    var diet = selectDiet(userTest);

    expect(diet.calory,userRealDiet.calory);
    expect(diet.squi,userRealDiet.squi);
    expect(diet.carboh,userRealDiet.carboh);
    expect(diet.fat,userRealDiet.fat);

  });

}