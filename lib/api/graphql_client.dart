import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as Http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // static const GRAPH_URL = "http://stgn.appsndevs.com:9095/graphql/";
  static const GRAPH_URL = "https://api.carscentro.com/graphql/graphql/";
  static var GRAPH_TOKEN = "";
  static var CUSTOMER_ID = "";

/*  static QueryOptions customerQueryOptions = QueryOptions(
    document: gql(customerQuery),

  );*/

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

  static initiateProjectMutations(String mutation, String vin) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'vin': vin,
        'description': "dev_desc_$vin",
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

  static addToWishListMutation(String mutation, String vin) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'vin': vin,
      },
    );
  }

  static enableNotificationMutation(String mutation, int value) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'enableNotification': value,
      },
    );
  }

  static deleteFromWishListMutation(String mutation, String vin) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'vin': vin,
      },
    );
  }

  static addExpensesMutation(String mutation, String expenseName, int projectId,
      double cost, int expenseId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: expenseId != 0
          ? {
        'expenseName': expenseName,
        'projectId': projectId.toString(),
        'cost': cost,
        'expenseKindId': expenseId
      }
          : {
        'expenseName': expenseName,
        'projectId': projectId.toString(),
        'cost': cost,
      },
    );
  }

  static acceptRejectMutation(
      String mutation, String projectId, String quotationId) {
    print(mutation);
    return MutationOptions(
        document: gql(mutation),
        variables: {'projectId': projectId, 'quotationId': quotationId});
  }

  static sellOutMutation(String mutation, int customerId, String vinNumber,
      String des, double price) {
    return MutationOptions(document: gql(mutation), variables: {
      'askingPrice': price,
      'vin': vinNumber,
      'customerId': customerId,
      'description': des
    });
  }

  static deleteMutation(String mutation, int id) {
    return MutationOptions(document: gql(mutation), variables: {'id': id});
  }

  static closeProjectMutations(String mutation, String vin) {
    return MutationOptions(
      document: gql(mutation),
      variables: {'vin': vin},
    );
  }

  static saveCardMutation(String mutation, String cardToken) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {'card_token': cardToken},
    );
  }

  static setDefaultCard(String mutation, String cardToken) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {'card_token': cardToken},
    );
  }

  static stripePayMutation(String mutation, int amount, int id) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {'amount': amount, 'projectId': id},
    );
  }

  static getQuotationMutations(
      String mutation, String vin, int id, String addInfo) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {'vin': vin, 'customerId': id, 'description': addInfo},
    );
  }

  static addMediaToProjectMutations(
      String mutation, List<Http.MultipartFile> file, int galleryId) {
    debugPrint(mutation);
    return MutationOptions(
      document: gql(mutation),
      onError: (error) {
        try {
          debugPrint(error?.graphqlErrors?.toString());
        } catch (e) {
          print("graph exception " + "$e");
        }
      },
      variables: {
        'file': file,
        'galleryId': galleryId,
      },
    );
  }



}
