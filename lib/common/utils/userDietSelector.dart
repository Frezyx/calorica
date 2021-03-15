import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/common/utils/dietSelector.dart';

abstract class DietSelector {
  static Future<bool> slectUserDiet() async {
    bool result = true;
    User user = await DBUserProvider.db.getUser();

    DietParams dietParams = selectDiet(user);

    Diet diet = Diet(
      user_id: user.id,
      calory: dietParams.calory,
      fat: dietParams.fat,
      carboh: dietParams.carboh,
      squi: dietParams.squi,
    );

    try {
      await DBDietProvider.db.adddiet(diet);
    } catch (error) {
      result = false;
    }
    return result;
  }
}
