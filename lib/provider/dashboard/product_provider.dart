import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';

import '../../api/client_provider.dart';
import '../../api/graphql_client.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../api/graphql_operation/mutations.dart';
import '../../utils/app.dart';
import '../../utils/utilities.dart';






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

Future hitCreateCartID() async {
  debugPrint("auth token >>>> ${App.localStorage.getString(PREF_TOKEN)}");
  QueryOptions generateCartIdQuery = QueryOptions(
    document: gql(generateCartId),);
  final QueryResult results = await GraphQLClientAPI()
      .mClient
      .query(generateCartIdQuery);
  debugPrint("enable noti mutation result >>> ${results.data}");
  if(results.data != null){
    App.localStorage.setString(PREF_CARD_ID, results.data!['customerCart']['id']);
    return true;
  }else{
    if(results.exception != null){
      Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
      debugPrint(results.exception!.graphqlErrors[0].message.toString());

      // session expired,login again code pending
    }
  }
}

Future hitAddToCartMutation({required String cartId,required String skuId}) async {
  QueryMutations queryMutation = QueryMutations();
  QueryResult results = await GraphQLClientAPI().mClient
      .mutate(GraphQlClient.addToCart(queryMutation.addToCart(cartId,skuId),
      cartId,skuId));
  debugPrint(" add to cart mutation result >>> ${results.data}");
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

}