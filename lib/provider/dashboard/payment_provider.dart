import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
   int _selectedIndex = 0;

   bool get getPayMethod => _selectPayMethod;
   int get getSelectedIndex => _selectedIndex;

   setSelectedIndex(int index){
     _selectedIndex = index;
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
     debugPrint(" addNew Address mutation result >>> ${results.data!}");
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