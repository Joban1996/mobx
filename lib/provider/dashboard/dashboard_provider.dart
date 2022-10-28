import 'package:flutter/material.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/utils/constants/strings.dart';






class  DashboardProvider with ChangeNotifier{

  int selectedIndex = 0;
  List<Children>?  _subCate;
  List<String> _innerPath = [];
  List<String> _path = [];
  String _uID = "";
  String _uIDSubCate = "";
  String name = Strings.refurbished_mobiles;
  String subCateName = Strings.refurbished_mobiles;
  String _uIDInnerSubCate = "";
  String _skuID = "";
  int currentPage = 0;
  int currentPageDetail = 0;


  List<Children>? get getSubCate => _subCate;
  List<String> get getInnerPath => _innerPath;
  List<String> get getPath => _path;
  String get getCategoryID => _uID;
  String get getSubCategoryID => _uIDSubCate;
  String get getInnerSubCateID => _uIDInnerSubCate;
  String get getCategoryName => name;
  String get getSubCategoryName => subCateName;
  String get getSkuID => _skuID;
  int get   getCurrentPage =>  currentPage;
  int get   getCurrentPageDetail =>  currentPageDetail;

  setCurrentPage(int val)
  {
    currentPage = val;
    notifyListeners();
  }
  setCurrentPageDetail(int val)
  {
    currentPageDetail = val;
    notifyListeners();
  }

  setSkuId(String valId){
    _skuID = valId;
  }
  setInnerSubCateId(String valId){
    _uIDInnerSubCate = valId;
  }
  setCategoryID(String val){
    _uID = val;
    notifyListeners();
  }
  setSubCategoryName(String val){
    subCateName = val;
    notifyListeners();
  }
  setCateName(String val){
    name = val;
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