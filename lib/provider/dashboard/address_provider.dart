import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/client_provider.dart';
import 'package:mobx/api/graphql_client.dart';
import 'package:mobx/api/graphql_operation/customer_queries.dart';
import 'package:mobx/api/graphql_operation/mutations.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';

import '../../utils/utilities.dart';

class AddressProvider with ChangeNotifier
{

  Future hitGetRegionData() async {
    QueryOptions otpVerifyQuery = QueryOptions(
      document: gql(getRegionData),
      );
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery);
    debugPrint("enable noti mutation result >>> ${results.data!['loginOTPVerify']}");
    if(results.data != null){

    }
  }

  Future hitAddAddressMutation({required String firstName,required String lastName,required String city,required String state,required String pinCode,required String  phonNumber,required bool isBillingAddress}) async {
    debugPrint("auth token >>>> ${App.localStorage.getString(PREF_TOKEN)}");
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.addNewAddress(queryMutation.addNewAddress(firstName, lastName, city, state, pinCode, phonNumber, isBillingAddress),
        firstName, lastName, city, state, pinCode, phonNumber, isBillingAddress));
    debugPrint(" addNew Address mutation result >>> ${results.data!}");
    if (results.data != null)
    {
      return true;
    }
    else
    {
      if(results.exception != null)
      {
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint("The exception "+results.exception!.graphqlErrors[0].message.toString());
      }
      return false;
    }
  }
  
}