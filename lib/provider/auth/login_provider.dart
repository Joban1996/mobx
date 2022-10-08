import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/client_provider.dart';
import 'package:mobx/api/graphql_operation/mutations.dart';

import '../../api/graphql_client.dart';
import '../../utils/utilities.dart';








class LoginProvider with ChangeNotifier{


  bool isLoading = false;
  String mobileNumber = "";

  bool get getIsLoading => isLoading;
  String get getMobileNumber => mobileNumber;

  setLoadingBool(bool val){
    isLoading = val;
    notifyListeners();
  }
  setMobileNumber(String number){
    mobileNumber = "+91-$number";
    notifyListeners();
  }

  Future hitLoginMutation({required String mNumber,required int webSiteId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.loginOTP(queryMutation.loginOTPMutation(mNumber,webSiteId),
        mNumber));
    if (results.data!['loginOTP']['status'] == true) {
      debugPrint("enable noti mutation result >>> ${results.data!['loginOTP']}");
      Utility.showSuccessMessage("${results.data!['loginOTP']['message']}");
      return true;
    }else{
      Utility.showErrorMessage("${results.data!['loginOTP']['message']}");
      if(results.exception != null){
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

}