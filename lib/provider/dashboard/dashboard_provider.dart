import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';






class DashboardProvider with ChangeNotifier{

  int selectedIndex = 0;
  List<Children>?  _subCate;
  List<String> _innerPath = [];
  List<String> _path = [];
  String _uID = "";
  String _uIDSubCate = "";


  List<Children>? get getSubCate => _subCate;
  List<String> get getInnerPath => _innerPath;
  List<String> get getPath => _path;
  String get getCategoryID => _uID;
  String get getSubCategoryID => _uIDSubCate;

  setCategoryID(String val){
    _uID = val;
    notifyListeners();
  }

  setSubCategoryID(String val){
    _uIDSubCate = val;
    notifyListeners();
  }

  setSubCate(List<Children> subCategories){
    _subCate = subCategories;
    notifyListeners();
  }

  setInnerPath(List<String> val){
    _innerPath = val;
    notifyListeners();
  }

  setSelectedIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }

  setPath(List<String> val){
    _path = val;
    notifyListeners();
  }


}