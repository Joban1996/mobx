import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../provider/auth/login_provider.dart';

enum HttpMethod { HTTP_GET, HTTP_POST, HTTP_PUT }

enum RequestBodyType { TYPE_XX_URLENCODED_FORMDATA, TYPE_JSON, TYPE_MULTIPART }

enum TokenType {
  TYPE_BASIC,
  TYPE_BEARER,
  TYPE_NONE,
  TYPE_DEVICE_TOKEN,
}

enum WebError {
  INTERNAL_SERVER_ERROR,
  ALREADY_EXIST,
  UNAUTHORIZED,
  INVALID_JSON,
  NOT_FOUND,
  UNKNOWN,
  BAD_REQUEST,
  FORBIDDEN
}

///this class handles api calls
class GraphQlClient {
  static const GRAPH_URL = "https://stagem2r.mobex.in/graphql";
  static var GRAPH_TOKEN = "";
  static var CUSTOMER_ID = "";



  static updateCustomerMutations(
      String mutation, double latitude, double longitude, int modelYear) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      onError: (error) {
        print(error!.linkException);
        print(error.graphqlErrors);
      },
      variables: <String, dynamic>{
        'modelYear': modelYear,
        'latitude': latitude,
        'longitude': longitude
      },
    );
  }

  static loginOTP(String mutation, String mobileNo) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'mobileNumber': mobileNo,
        'websiteId': 1,

      },
    );
  }

  static addToCart(String mutation,String cartId,String skuId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cartId': cartId,
        'quantity': 1,
        'sku':skuId
      },
    );
  }

  static loginOTPVerify(String query, String mobileNo,String otp) {
    print(query);
    return QueryOptions(
      document: gql(query),
      variables: {
        'mobileNumber': mobileNo,
        'otp': otp,
        'websiteId': 1,
      },
    );
  }

  static selectMediaMutation(
      String mutation, List<int> mediaId, int galleryId) {
    return MutationOptions(document: gql(mutation), variables: {
      'mediaId': mediaId,
      'galleryId': galleryId,
    });
  }



}
