import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/utils/constants/strings.dart';






class ProductProvider with ChangeNotifier{


bool isExpand = false;
int _itemIndex = -1;

bool  get getIsExpand => isExpand;
int get getItemIndex => _itemIndex;

setItemIndex(int val){
  _itemIndex = val;
  notifyListeners();
}


setIsExpand(){
  isExpand = !isExpand;
  notifyListeners();
}

}