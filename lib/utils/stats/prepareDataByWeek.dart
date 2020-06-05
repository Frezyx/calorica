import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/providers/local_providers/userProductsProvider.dart';
import 'package:calory_calc/utils/dateHelpers/dateFromInt.dart';

Future<List<UserProduct>> getProductsCaloryByDateList() async{
    final now = DateTime.now();

    var productsByDateList = <UserProduct>[];

    for(int i = 0; i < 7; i++){

        int date = epochFromDate(DateTime(now.year, now.month, now.day - i));
        var userProduct = new UserProduct(id:i, calory: 0.0, squi: 0.0, fat: 0.0, carboh: 0.0, grams: 0.0, date: DateTime.fromMillisecondsSinceEpoch(date));
        userProduct = getCaloryOfDay(await DBUserProductsProvider.db.getProductsByDate(date), userProduct);
        
        productsByDateList.add(userProduct);
    }

    return productsByDateList;
  }

UserProduct getCaloryOfDay(List<UserProduct> userProducts, UserProduct dayStats){

  for (UserProduct product in userProducts) {
    dayStats.calory += product.calory;
    dayStats.squi += product.squi;
    dayStats.fat += product.fat;
    dayStats.carboh += product.carboh;
    dayStats.grams += product.grams;
  }

  return dayStats;
}
