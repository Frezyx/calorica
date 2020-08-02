import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  runTests();
}

void runTests() {
  dietTest();
}

void dietTest() {
  test("DataBase must be implemented", () async {
    var user = User(id: 1);
    var raw = await DBDietProvider.db.firstCreateTable(user);
    expect(1, raw);
  });
}
