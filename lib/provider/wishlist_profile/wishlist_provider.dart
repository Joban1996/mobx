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

  Future hitGetUserDetails() async {
    print("hitGetUserDetailscall");
    QueryOptions otpVerifyQuery = QueryOptions(
      document: gql(getUserDetails),);
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery);
    if (results.data != null) {
      debugPrint("customer data joban ${results.data!['customer']}");
      if(results.data!['customer']['wishlists'] != null) {
       await App.localStorage.setString(
            PREF_WISHLIST_ID, results.data!['customer']['wishlists'][0]['id']);
      }
       await App.localStorage.setString(PREF_NAME, "${results.data!['customer']['firstname']}");
       await App.localStorage.setString(PREF_LASTNAME, "${results.data!['customer']['lastname']}");
       await App.localStorage.setString(PREF_EMAIL, results.data!['customer']['email']);
       await App.localStorage.setString(PREF_MOBILE, results.data!['customer']['mobilenumber']);
        if(results.data!['customer']['date_of_birth'] != null){
        await App.localStorage.setString(PREF_DOB, results.data!['customer']['date_of_birth']);}
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
      Utility.showSuccessMessage("Product Added Successfully in Wishlist!");
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
      Utility.showSuccessMessage("Product added successfully in Cart");
      return true;
    }else{
      if(results.exception != null){
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

  Future hitUpdateCustomer({required String name,required String lastname,required int gender,required String dob,required String email}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.updateCustomer(queryMutation.updateCustomer(name,lastname,gender,dob,email),
        name,lastname,gender,dob,email));
    debugPrint(" Update customer result >>> ${results.data}");
    if (results.data != null) {
      Utility.showSuccessMessage("Profile Updated Successfully!");
      await App.localStorage.setString(PREF_NAME, "${results.data!['updateCustomer']['customer']['firstname']}");
      await App.localStorage.setString(PREF_LASTNAME, "${results.data!['updateCustomer']['customer']['lastname']}");
      await App.localStorage.setString(PREF_GEN, "${results.data!['updateCustomer']['customer']['gender']}");
      await App.localStorage.setString(PREF_DOB, "${results.data!['updateCustomer']['customer']['date_of_birth']}");
      await App.localStorage.setString(PREF_EMAIL, results.data!['updateCustomer']['customer']['email']);
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