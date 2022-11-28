import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/client_provider.dart';
import 'package:mobx/api/graphql_operation/mutations.dart';
import 'package:mobx/model/opt_verify.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/graphql_client.dart';
import '../../api/graphql_operation/customer_queries.dart';
import '../../utils/utilities.dart';
import 'package:mobx/utils/app.dart';







class LoginProvider with ChangeNotifier{

  bool isLoading = false;
  String mobileNumber = "";
  int remainingTime = 59;

  bool get getIsLoading => isLoading;
  String get getMobileNumber => mobileNumber;
  int get getRemainingTime => remainingTime;

  setLoadingBool(bool val){
    isLoading = val;
    notifyListeners();
  }
  setInitialTime(){
    remainingTime = 59;
  }
  setMobileNumber(String number){
    mobileNumber = number;
    notifyListeners();
  }

  setRemainingTime(){
    if(remainingTime != 0){
      remainingTime--;
    }else{

    }
    notifyListeners();
  }

  Future hitLoginMutation({required String mNumber,required int webSiteId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.loginOTP(queryMutation.loginOTPMutation(mNumber,webSiteId),
        mNumber));
    debugPrint("${results.data}");
    if (results.data?['loginOTP']['status'] == true) {
      Utility.showSuccessMessage("${results.data!['loginOTP']['message']}");
      return true;
    }else{
      if(results.exception != null){
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }


  Future hitOtpVerifyQuery({required String phone,required String otp}) async {
    print("query results >>>> ${phone}");
    QueryOptions otpVerifyQuery = QueryOptions(
        document: gql(loginOtpVerify),
        variables: <String, dynamic>{
          'mobileNumber': "91$phone",
          'otp': otp,
          'websiteId': 1
        },);
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery);
    if(results.data != null){
      var data = await OtpVerify.fromJson(results.data!);
      if (results.data!['loginOTPVerify']['status'] == true) {
        debugPrint("enable noti mutation result >>> ${results.data!}");
        App.localStorage.setString(PREF_TOKEN,results.data!['loginOTPVerify']['token']);
        Utility.showSuccessMessage(results.data!['loginOTPVerify']['message'] == null? "Successfully LoggedIn":
        " ${data!.data!.loginOTPVerify!.message}");
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

}