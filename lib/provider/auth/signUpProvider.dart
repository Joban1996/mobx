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

class SignUpProvider with ChangeNotifier {
  bool isLoading = false;
  String firstName = "";
  String lastName = "";
  String emailAddress = "";
  String mobileNumber = "";
  int remainingTime = 59;

  bool get getIsLoading => isLoading;
  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getEmailAddress => emailAddress;
  String get getMobileNumber => mobileNumber;
  int get getRemainingTime => remainingTime;

  setLoadingBool(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setInitialTime() {
    remainingTime = 59;
  }

  setFirstName(String number) {
    firstName = number;
    print("setFirstName_object${number}");
    notifyListeners();
  }

  setLastName(String number) {
    lastName = number;
    print("lastName_object${number}");
    notifyListeners();
  }

  setEmailAddress(String number) {
    emailAddress = number;
    print("emailAddress_object${number}");
    notifyListeners();
  }

  setMobileNumber(String number) {
    mobileNumber = number;
    notifyListeners();
  }

  setRemainingTime() {
    if (remainingTime != 0) {
      remainingTime--;
    } else {}
    notifyListeners();
  }

  Future hitSignUpMutation(
      {required String mobileNumber,
      required String otp,
      required String firstname,
      required String lastname,
      required String email}) async {
    try {
      QueryMutations queryMutation = QueryMutations();
      QueryResult results = await GraphQLClientAPI().mClient.mutate(
          GraphQlClient.createCustomer(
              queryMutation.createAccountMutation(
                  mobileNumber, otp, firstname, lastname, email),
              mobileNumber,
              otp,
              firstname,
              lastName,
              email));
      debugPrint("${results.data}");
      print("ONE PHASE SIGN UP SUGGESS DONE FROM MY END");
      if (results.data?['createCustomerAccount']['status'] == true) {
        print("SIGN UP SUGGESS DONE FROM MY END");
        App.localStorage.setString(
            PREF_TOKEN, results.data!['createCustomerAccount']['token']);
        // Utility.showSuccessMessage(
        //     "${results.data!['createAccount']['message']}");
        return true;
      }if (results.data?['createCustomerAccount']['status'] == false) {
        print("Already Registerted UP SUGGESS DONE FROM MY END");
        Utility.showSuccessMessage(
            "${results.data!['createCustomerAccount']['message']}");
        return false;
      }
       else {
        if (results.exception != null) {
          Utility.showErrorMessage(
              results.exception!.graphqlErrors[0].message.toString());
          debugPrint(results.exception!.graphqlErrors[0].message.toString());
        }
        return false;
      }
    } catch (error) {
      print("errrororo77}");
      print(error);
    }
  }

// Calling for Mobile Number OTP creation for a new user
  Future hitMobileNumberSignUp(
      {required String mNumber, required int webSiteId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient.mutate(
        GraphQlClient.createAccountOTP(
            queryMutation.createAccountNumberMutation(mNumber, webSiteId),
            mNumber));
    debugPrint("${results.data}");
    if (results.data?['createAccountOTP']['status'] == false) {
      //var data = await OtpVerify.fromJson(results.data!);
      debugPrint("enable noti mutation result >>> ${results.data!}");
      // Utility.showSuccessMessage("${results.data!['loginOTP']['message']}");
      return false;
    }
    if (results.data?['createAccountOTP']['status'] == true) {
      //var data = await OtpVerify.fromJson(results.data!);
      debugPrint("enable noti mutation result >>> ${results.data!}");
      // Utility.showSuccessMessage("${results.data!['loginOTP']['message']}");
      return true;
    } else {
      if (results.exception != null) {
        Utility.showErrorMessage(
            results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

// Calling for Mobile Number Registration creation for a new user
  Future hitSignOtpMutation(
      {required String mNumber, required int webSiteId}) async {
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient.mutate(
        GraphQlClient.createAccountOTP(
            queryMutation.signUpOTPMutation(mNumber, webSiteId), mNumber));
    debugPrint("${results.data}");
    if (results.data?['createAccountOTP']['status'] == true) {
      Utility.showSuccessMessage(
          "${results.data!['createAccountOTP']['message']}");
      return true;
    } else {
      if (results.exception != null) {
        Utility.showErrorMessage(
            results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }

  // Calling for Mobile Number OTP creation for a new user

  Future hitOtpVerifyQuery({required String phone, required String otp}) async {
    print("query results >>>> ${phone}");
    print("Otp=====>query results >>>> ${otp}");
    QueryOptions otpVerifyQuery = QueryOptions(
      document: gql(signUpOtpVerify),
      variables: <String, dynamic>{
        'mobileNumber': "91$phone",
        'otp': otp,
        'websiteId': 1
      },
    );
    final QueryResult results =
        await GraphQLClientAPI().mClient.query(otpVerifyQuery);
    if (results.data != null) {
      var data = await OtpVerify.fromJson(results.data!);
      if (results.data!['createAccountOTPVerify']['status'] == true) {
        debugPrint("Sign UP Success result >>> ${results.data!}");
        // App.localStorage.setString(PREF_TOKEN,results.data!['createAccountOTPVerify']['token']);

        // Utility.showSuccessMessage(results.data!['loginOTPVerify']['message'] == null? "Successfully LoggedIn":
        // " ${data!.data!.loginOTPVerify!.message}");

        return true;
      } else {
        Utility.showErrorMessage(
            "${results.data!['createAccountOTPVerify']['message']}");
        if (results.exception != null) {
          Utility.showErrorMessage(
              results.exception!.graphqlErrors[0].message.toString());
          debugPrint(results.exception!.graphqlErrors[0].message.toString());
        }
        return false;
      }
    }
  }
}
