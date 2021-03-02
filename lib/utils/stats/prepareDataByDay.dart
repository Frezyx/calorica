import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/utils/doubleRounder.dart';

UserProduct getProductsParamsSum(List<UserProduct> yesterdayProd) {
  var dateProducts =
      UserProduct(calory: 0.0, squi: 0.0, fat: 0.0, carboh: 0.0, grams: 0.0);

  for (var i = 0; i < yesterdayProd.length; i++) {
    dateProducts.fat += yesterdayProd[i].fat;
    dateProducts.squi += yesterdayProd[i].squi;
    dateProducts.carboh += yesterdayProd[i].carboh;
    dateProducts.calory += yesterdayProd[i].calory;
    dateProducts.grams += yesterdayProd[i].grams;
  }

  dateProducts.calory = roundDouble(dateProducts.calory, 2);

  return dateProducts;
}
