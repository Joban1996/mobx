import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/model/product/CartListModel.dart';

import '../../api/client_provider.dart';
import '../../api/graphql_client.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../api/graphql_operation/mutations.dart';
import '../../model/product/getRegionModel.dart';
import '../../utils/app.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';



class PaymentProvider with ChangeNotifier{

   bool _selectPayMethod = false;
   int _selectedIndex = -1;
   String _selectedCode = "";
    CartListModel? cartData;

   bool get getPayMethod => _selectPayMethod;
   int get getSelectedIndex => _selectedIndex;
   String get getSelectedCode => _selectedCode;
   CartListModel?  get getCartData  => cartData;

   setCartListData(var data){
     cartData = data;
     notifyListeners();
   }

   setSelectedIndex(int index,String code){
     _selectedIndex = index;
     _selectedCode = code;
   }

   toggle(){
     _selectPayMethod = !_selectPayMethod;
     notifyListeners();
   }

   Future hitSetPaymentMethod({required String cartId,required String code}) async {
     debugPrint("auth token >>>> ${App.localStorage.getString(PREF_TOKEN)}");
     QueryMutations queryMutation = QueryMutations();
     QueryResult results = await GraphQLClientAPI().mClient
         .mutate(GraphQlClient.setPaymentMethod(queryMutation.setPayMethod(cartId,code),
         cartId,code));
     if (results.data != null) {
       debugPrint(" addNew Address mutation result >>> ${results.data!}");
       return true;
     }else{
       if(results.exception != null){
         //debugPrint(" addNew Address mutation result >>> ${results.exception!.linkException!.originalException}");
         debugPrint(" addNew Address mutation result >>> ${results.exception!}");
         Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
         debugPrint(results.exception!.graphqlErrors[0].message.toString());

       }
       return false;
     }
   }

   Future hitSetShippingMethod({required String cartId}) async {
     debugPrint("auth token >>>> ${App.localStorage.getString(PREF_TOKEN)}");
     QueryMutations queryMutation = QueryMutations();
     QueryResult results = await GraphQLClientAPI().mClient
         .mutate(GraphQlClient.setShippingMethod(queryMutation.setShippingMethod(cartId),
         cartId));
     if (results.data != null) {
       debugPrint(" addNew Address mutation result >>> ${results.data!}");
       return true;
     }else{
       if(results.exception != null){
         //debugPrint(" addNew Address mutation result >>> ${results.exception!.linkException!.originalException}");
         debugPrint(" addNew Address mutation result >>> ${results.exception!}");
         Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
         debugPrint(results.exception!.graphqlErrors[0].message.toString());

       }
       return false;
     }
   }

   Future hitPlaceOrder({required String cartId}) async {
     QueryMutations queryMutation = QueryMutations();
     QueryResult results = await GraphQLClientAPI().mClient
         .mutate(GraphQlClient.placeUserOrder(queryMutation.placeOrder(cartId),
         cartId));
     if (results.data != null) {
       debugPrint(" addNew Address mutation result >>> ${results.data!}");
       return true;
     }else{
       if(results.exception != null){
         debugPrint(" addNew Address mutation result >>> ${results.exception!}");
         Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
         debugPrint(results.exception!.graphqlErrors[0].message.toString());
       }
       return false;
     }
   }

}