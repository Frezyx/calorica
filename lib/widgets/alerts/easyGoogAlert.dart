import 'package:calory_calc/design/theme.dart';
import 'package:calory_calc/utils/adClickHelper.dart';
import 'package:flutter/material.dart';

Future<void> goodAlert(context) async {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Данные сохранены'),
                            actions: <Widget>[
                                  FlatButton(
                                    child: Text('Отлично', style: TextStyle(color: DesignTheme.mainColor ),),
                                    
                                    onPressed: (){ addClick();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]
                              );
                            
                          },
                        );
                      }