import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/utils/dietSelector.dart';

updateDiet(User user) async{
  bool result = true;
  DietParams dietParams = selectDiet(user);

  Diet diet = Diet(
    id: 1,
    user_id: user.id,
    calory: dietParams.calory,
    fat: dietParams.fat,
    carboh: dietParams.carboh,
    squi: dietParams.squi,
  );

  try{
    await DBDietProvider.db.updateDiet(diet);
  }
  catch (error){
      result = false;
  }
  return result;
}