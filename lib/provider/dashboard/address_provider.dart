import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/client_provider.dart';
import 'package:mobx/api/graphql_client.dart';
import 'package:mobx/api/graphql_operation/customer_queries.dart';
import 'package:mobx/api/graphql_operation/mutations.dart';
import 'package:mobx/model/product/getRegionModel.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';

import '../../utils/utilities.dart';

class AddressProvider with ChangeNotifier
{

  String stateName = "";
  AvailableRegions regions = AvailableRegions(id: 578,code: "DL",name: "Delhi");

  String get getStateName => stateName;
  AvailableRegions get getAvailableRegions => regions;

  setStateName(String val){
    stateName = val;
    notifyListeners();
  }

  setAvailableRegions(AvailableRegions val){
    regions = val;
    notifyListeners();
  }

  Future hitGetRegionData() async {
    QueryOptions otpVerifyQuery = QueryOptions(
      document: gql(getRegionData),
      );
    final QueryResult results = await GraphQLClientAPI()
        .mClient
        .query(otpVerifyQuery);
    debugPrint("enable noti mutation result >>> ${results.data!}");
    if(results.data != null){
       var data =  GetRegionsModel.fromJson(results.data!);
       print("region state selected >>> $getStateName");
       for(int i=0;i<data.country!.availableRegions!.length;i++){
            if(data.country!.availableRegions![i].name.toString() == getStateName){
              //set available region object
              setAvailableRegions(data.country!.availableRegions![i]);
            }
       }
    }
  }

  Future hitAddAddressMutation({required String street,required String firstName,required String lastName,required String city,required
  String state,required String pinCode,required String  phonNumber,required bool isBillingAddress}) async {
    debugPrint("auth token >>>> ${App.localStorage.getString(PREF_TOKEN)}");
    QueryMutations queryMutation = QueryMutations();
    QueryResult results = await GraphQLClientAPI().mClient
        .mutate(GraphQlClient.addNewAddress(queryMutation.addNewAddress(getAvailableRegions,firstName,
        lastName, city, state, pinCode, phonNumber, isBillingAddress,street),
        firstName, lastName, city, state, pinCode, phonNumber, isBillingAddress,getAvailableRegions,street));
    debugPrint(" addNew Address mutation result >>> ${results.data!}");
    if (results.data != null) {
      return true;
    }else{
      if(results.exception != null){
        Utility.showErrorMessage(results.exception!.graphqlErrors[0].message.toString());
        debugPrint(results.exception!.graphqlErrors[0].message.toString());
        // if(results.exception!.graphqlErrors[0].extensions!['category'] == "graphql-authorization"){
        //   App.localStorage.clear();
        //   Navigator.pushReplacementNamed(context, Routes.loginScreen);
        // }
      }
      return false;
    }
  }
  
}