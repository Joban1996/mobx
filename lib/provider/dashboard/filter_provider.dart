import 'package:flutter/material.dart';


class FilterProvider extends ChangeNotifier{

  List<dynamic>? isCheckedList;

  List<dynamic>? get getIsCheckedList => isCheckedList;

  set setValue(List<dynamic>? val){
    isCheckedList = val;
    notifyListeners();
  }

}