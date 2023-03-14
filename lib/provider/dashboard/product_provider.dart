import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import '../../api/client_provider.dart';
import '../../api/graphql_client.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../api/graphql_operation/mutations.dart';
import '../../utils/app.dart';
import '../../utils/utilities.dart';



class ProductProvider with ChangeNotifier{


int _itemIndex = -1;
String _cartItemsLength = "";
String _dropDownValue = "1";
String _tokenExpireMsg = '';
String userErrorMsg ="";
int _filterCatIndex = 0;
String priceFrom = '';
String priceTo = '';
String colorFilter = '';
String manufacturerFilter = '';
String osFilter = '';
String brandFilter = '';
String countryFilter = '';
String storageCapacityFilter = '';
List<dynamic> isCheckedList = [];

int get getItemIndex => _itemIndex;
String get getCartItemLength => _cartItemsLength;
String get getDropDownValue => _dropDownValue;
String get getTokenExpireMsg => _tokenExpireMsg;
int get getFilterCatIndex => _filterCatIndex;
String get getPriceFrom => priceFrom;
String get getPriceTo => priceTo;
String get getManufacturerFilter => manufacturerFilter;
String get getOsFilter => osFilter;
String get getBrandFilter => brandFilter;
String get getCountryFilter => countryFilter;
String get getStorageCapacityFilter => storageCapacityFilter;
String get getColorFilter => colorFilter;
List<dynamic> get getIsCheckedList => isCheckedList;


setPrice(String val){
  priceFrom = val;
  notifyListeners();
}

setPriceTo(String val){
  priceTo = val;
  notifyListeners();
}

setColor(String val){
  colorFilter = val;
  notifyListeners();
}

setManufacturer(String val){
  manufacturerFilter = val;
  notifyListeners();
}
setOs(String val){
  osFilter = val;
  notifyListeners();
}
setBrand(String val){
  brandFilter = val;
  notifyListeners();
}
setCountry(String val){
  countryFilter = val;
  notifyListeners();
}
setStorageCapacity(String val){
  storageCapacityFilter = val;
  notifyListeners();
}

setIsCheckedList(List<dynamic> data){
  isCheckedList = data;
  notifyListeners();
}

setFilterCatIndex(int index){
  _filterCatIndex = index;
  notifyListeners();
}

setTokenExpireMsg(String msg){
  _tokenExpireMsg = msg;
  notifyListeners();
}
setUserError(String msg){
  userErrorMsg = msg;
  notifyListeners();
}

setDropDownValue(String item){
  _dropDownValue = item;
  notifyListeners();
}

setItemLength(String val){
  _cartItemsLength = val;
  notifyListeners();
}

setItemIndex(int val){
  _itemIndex = val;
  notifyListeners();
}


Future hitCreateCartID() async {
  debugPrint("auth token >>>> ${App.localStorage.getString(PREF_CART_ID)}");
  QueryOptions generateCartIdQuery = QueryOptions(
    fetchPolicy: FetchPolicy.noCache,
    document: gql(generateCartId),);
  final QueryResult results = await GraphQLClientAPI()
      .mClient
      .query(generateCartIdQuery);
  //debugPrint("create cart id >>> ${results.exception}");
  if(results.data != null){
    debugPrint("create cart id >>> ${results.data}");
    App.localStorage.setString(PREF_CART_ID, results.data!['customerCart']['id']);
    return true;
  }else{
    if(results.exception != null){
      debugPrint("create cart id >>> ${results.exception}");
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
      debugPrint(results.exception!.graphqlErrors[0].message.toString());
      setTokenExpireMsg(results.exception!.graphqlErrors[0].extensions!['category'].toString());
    }return false;
  }
}

Future hitAddToCartMutation({required String cartId,required String skuId}) async {
  debugPrint("cart id >>>> $cartId");
  QueryMutations queryMutation = QueryMutations();
  QueryResult results = await GraphQLClientAPI().mClient
      .mutate(GraphQlClient.addToCart(queryMutation.addToCart(cartId,skuId),
      cartId,skuId));
  debugPrint(" add to cart mutation result >>> ${results.exception}");
  debugPrint("add to cart >>>>>${results.context.entry<HttpLinkResponseContext>()?.statusCode}");
  if (results.data != null) {
    Utility.showSuccessMessage("Item added!");
    return true;
  }else{
    if(results.exception != null){
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
        setTokenExpireMsg(results.exception!.graphqlErrors[0].extensions!['category'].toString());
    }
    return false;
  }
}
Future hitUpdateCartMutation({required String cartId,required String cartUID,required int quantity}) async {
  QueryMutations queryMutation = QueryMutations();
  QueryResult results = await GraphQLClientAPI().mClient
      .mutate(GraphQlClient.updateCartMutation(queryMutation.updateCart(cartId,cartUID,quantity),
      cartId,cartUID,quantity));
  debugPrint(" update to cart mutation result >>> ${results.data}");
  if (results.data != null) {
    return true;
  }else{
    if(results.exception != null){
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
      debugPrint(results.exception!.graphqlErrors[0].message.toString());
    }
    return false;
  }
}
Future hitApplyCouponMutation({required String cartId,required String couponCode}) async {
  QueryMutations queryMutation = QueryMutations();
  QueryResult results = await GraphQLClientAPI().mClient
      .mutate(GraphQlClient.applyCouponMutation(queryMutation.applyCoupon(cartId,couponCode),
      cartId,couponCode));
  debugPrint(" apply coupon result >>> ${results.data}");
  if (results.data != null) {
    Utility.showSuccessMessage("Successfully Applied!");
    return true;
  }else{
    if(results.exception != null){
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
      debugPrint(results.exception!.graphqlErrors[0].message.toString());
    }
    return false;
  }
}
Future hitRemoveCouponMutation({required String cartId}) async {
  QueryMutations queryMutation = QueryMutations();
  QueryResult results = await GraphQLClientAPI().mClient
      .mutate(GraphQlClient.removeCoupon(queryMutation.removeCoupon(cartId),
      cartId));
  debugPrint(" remove coupon result >>> ${results.data}");
  if (results.data != null) {
    Utility.showSuccessMessage("Coupon Removed!");
    return true;
  }else{
    if(results.exception != null){
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
      debugPrint(results.exception!.graphqlErrors[0].message.toString());
    }
    return false;
  }
}

}