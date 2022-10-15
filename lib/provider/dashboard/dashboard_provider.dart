import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';






class DashboardProvider with ChangeNotifier{

  int selectedIndex = 0;
  List<Children>?  subCate;
  List<Children>? products;


  List<Children>? get getSubCate => subCate;
  List<Children>? get getProducts => products;

  setSubCate(List<Children> subCategories){
    subCate = subCategories;
    notifyListeners();
  }

  setProducts(List<Children> val){
    products = val;
    notifyListeners();
  }

  setSelectedIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }


}