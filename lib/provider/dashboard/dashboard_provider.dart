import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/model/product/searchData_model.dart';
import 'package:mobx/utils/constants/strings.dart';

import '../../api/client_provider.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../utils/utilities.dart';






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
  SearchDataModel? searchData;
  int selectedTabIndex = 0;


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
  SearchDataModel? get getSearchData => searchData;
  int get getSelectedTabIndex  => selectedTabIndex;

  setTabIndex(int val){
    selectedTabIndex = val;
    notifyListeners();
  }

  setSearchData(SearchDataModel? data){
    searchData = data;
    notifyListeners();
  }

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

  Future hitSearchProductQuery({required String searchValue }) async {
    print("query results >>>> $searchValue");
    QueryOptions otpVerifyQuery = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(searchProduct),
      variables:{
        'search': searchValue,
      },);
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery);
    if(results.data != null){
          debugPrint('${results.data}');
          var _data  = SearchDataModel.fromJson(results.data!);
          setSearchData(_data);
        return true;
    }else{
      Utility.showErrorMessage("${results.data!['loginOTPVerify']['message']}");
      if(results.exception != null){
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }


}