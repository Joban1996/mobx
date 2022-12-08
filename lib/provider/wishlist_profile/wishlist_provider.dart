

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';

import '../../api/client_provider.dart';
import '../../api/graphql_client.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../api/graphql_operation/mutations.dart';
import '../../utils/utilities.dart';

class WishlistProvider with ChangeNotifier{

  Future hitGetWishlistId() async {
    QueryOptions otpVerifyQuery = QueryOptions(
      document: gql(getWishListId),);
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery).catchError((e){
          print("object >>> $e");
    });
    if (results.data != null) {
      debugPrint("get wishlist data >>>>> ${results.data!['customer']['wishlists'][0]['id']}");
      if(results.data!['customer']['wishlists'] != null){
        App.localStorage.setString(PREF_WISHLIST_ID, results.data!['customer']['wishlists'][0]['id']);
      }
      return true;
    }else{
      if(results.exception != null){
        debugPrint("get wishlist exception >>>>> ${results.exception}");
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

  Future addToWishList({required int id,required String sku,required int quantity}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient.mutate(
        GraphQlClient.addToWishList(queryMutation.addToWishlistMutation(id,sku,quantity), id,sku,quantity));
    if (results.data != null) {
      debugPrint(" add to wishlist mutation result >>> ${results.data!}");
      Utility.showSuccessMessage("Item added to wishlist!");
      return true;
    } else {
      if (results.exception != null) {
        debugPrint("add to wishlist mutation excepion >>> ${results.exception!}");
        Utility.showErrorMessage(
            results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

  Future hitDeleteWishlist({required int wishlistItemId,required int wishListId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.deleteOrAddWishlistToCart(queryMutation.deleteWishlist(wishlistItemId,wishListId),
        wishlistItemId,wishListId));
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

  Future hitAddWishlistToCart({required int wishlistItemId,required int wishListId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.deleteOrAddWishlistToCart(queryMutation.addWishlistToCart(wishlistItemId,wishListId),
        wishlistItemId,wishListId));
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

}