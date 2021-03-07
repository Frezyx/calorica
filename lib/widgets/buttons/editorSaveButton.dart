import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/models/dbModels.dart';
import 'package:calory_calc/models/diet.dart';
import 'package:calory_calc/providers/local_providers/dietProvider.dart';
import 'package:calory_calc/providers/local_providers/userProvider.dart';
import 'package:calory_calc/utils/userDietUpdate.dart';
import 'package:calory_calc/widgets/alerts/easyGoogAlert.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

getEditorSaveButton(_formKey, User user, context, bool isParams) {
  return GradientButton(
    increaseWidthBy: 60,
    increaseHeightBy: 5,
    child: Padding(
      child: Text(
        'Сохранить',
        textAlign: TextAlign.center,
        style: DesignTheme.buttonText,
      ),
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
    ),
    callback: () {
      if (_formKey.currentState.validate()) {
        DBUserProvider.db.updateUser(user).then((count) {
          if (isParams) {
            updateDiet(user);
          }
          if (count == 1) {
            goodAlert(context);
          }
        });
      }
    },
    shapeRadius: BorderRadius.circular(50.0),
    gradient: DesignTheme.gradient,
    shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.0),
  );
}

getEditorSaveButtonOnlyName(_formKey, User user, context) {
  return GradientButton(
    increaseWidthBy: 60,
    increaseHeightBy: 5,
    child: Padding(
      child: Text(
        'Сохранить',
        textAlign: TextAlign.center,
        style: DesignTheme.buttonText,
      ),
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
    ),
    callback: () {
      if (_formKey.currentState.validate()) {
        DBUserProvider.db
            .updateUserOnlyNameAndSurname(user.id, user.name, user.surname)
            .then((count) {
          if (count == 1) {
            goodAlert(context);
          }
        });
      }
    },
    shapeRadius: BorderRadius.circular(50.0),
    gradient: DesignTheme.gradient,
    shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.0),
  );
}

getEditorDietSaveButton(_formKey, Diet diet, context) {
  return GradientButton(
    increaseWidthBy: 60,
    increaseHeightBy: 5,
    child: Padding(
      child: Text(
        'Сохранить',
        textAlign: TextAlign.center,
        style: DesignTheme.buttonText,
      ),
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
    ),
    callback: () {
      if (_formKey.currentState.validate()) {
        DBDietProvider.db.updateDiet(diet).then((res) {
          if (res == 1) {
            goodAlert(context);
          }
        });
      }
      ;
    },
    shapeRadius: BorderRadius.circular(50.0),
    gradient: DesignTheme.gradient,
    shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.0),
  );
}
