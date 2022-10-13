import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';






class DashboardProvider with ChangeNotifier{

  int selectedIndex = 0;
  List<Children>?  subCate;
  var products;


  List<Children>? get getSubCate => subCate;
  //var get getProducts => products;

  setSubCate(List<Children> subCategories){
    subCate = subCategories;
    notifyListeners();
  }

  setProducts(){

  }

  setSelectedIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }


}