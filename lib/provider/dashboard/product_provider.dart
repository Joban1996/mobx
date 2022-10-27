import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/utils/constants/strings.dart';






class ProductProvider with ChangeNotifier{


bool isExpand = false;

bool  get getIsExpand => isExpand;

setIsExpand(){
  isExpand = !isExpand;
  notifyListeners();
}

}