import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/model/product/getRegionModel.dart';

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
  static const GRAPH_URL = "https://stagem2r.mobex.in/graphql"/* production url - "https://www.mobex.in/graphql"*/;
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

  static loginWithEmail(String mutation, String email,String password) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'email': email,
        'password': password,

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

  static updateCartMutation(String mutation,String cartId,String cartUID,int quantity) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cartId': cartId,
        'quantity': quantity,
        'cart_item_id':cartUID
      },
    );
  }

  static applyCouponMutation(String mutation,String cartId,String couponCode) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id ': cartId,
        'coupon_code': couponCode,
      },
    );
  }

  static removeCoupon(String mutation,String cartId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id ': cartId,
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


  static addNewAddress(String mutation,String firstName, String lastName,String city, String state,
      String pinCode, String  phonNumber,bool isBillingAddress,AvailableRegions regionsAvalable,String street) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'street': [street],
        'region':regionsAvalable.name,
        'region_code':regionsAvalable.code,
        'region_id':regionsAvalable.id,
        'country_code': 'IN',
        'postcode':pinCode,
        'city':city,
        'firstname': firstName,
        'lastname': lastName,
        'telephone': phonNumber,
        'default_billing': isBillingAddress
      },
    );
  }

  static updateAddress(String mutation,String firstName, String lastName,String city, String state,
      String pinCode,String street,AvailableRegions regionsAvalable) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'street': [street],
        'region':state,
        'postcode':pinCode,
        'city':city,
        'firstname': firstName,
        'lastname': lastName,
      },
    );
  }

  static addShippingAddress(String mutation,String firstName, String lastName,String city,
      String pinCode, String  phonNumber,bool isBillingAddress,AvailableRegions regionsAvalable,
      String street,String cartId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id': cartId,
        'street': [street],
        'region':regionsAvalable.code,
        'region_id':regionsAvalable.id,
        'country_code': 'IN',
        'postcode':pinCode,
        'city':city,
        'firstname': firstName,
        'lastname': lastName,
        'telephone': phonNumber,
      },
    );
  }

  static addBillingAddress(String mutation,String firstName, String lastName,String city,
      String pinCode, String  phonNumber,AvailableRegions regionsAvalable,
      String street,String cartId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id': cartId,
        'street': [street],
        'region':regionsAvalable.code,
        'region_id':regionsAvalable.id,
        'country_code': 'IN',
        'postcode':pinCode,
        'city':city,
        'firstname': firstName,
        'lastname': lastName,
        'telephone': phonNumber,
      },
    );
  }

  static setPaymentMethod(String mutation,String cartId,String code) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id ': '$cartId',
        'code': '$code'
      },
    );
  }

  static setShippingMethod(String mutation,String cartId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id ': '$cartId',
      },
    );
  }

  static placeUserOrder(String mutation,String cartId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'cart_id': cartId,
      },
    );
  }

  static deleteAddress(String mutation,int id) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'id': id,
      },
    );
  }
  static addToWishList(String mutation,int id,String sku,int quantity) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'wishlistId': id,
        'sku': sku,
        'quantity': quantity
      },
    );
  }

  static deleteOrAddWishlistToCart(String mutation,int wishlistItemId, int wishListId) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'wishlistId': wishListId,
        'wishlistItemsIds': [wishlistItemId],
      },
    );
  }

  static updateCustomer(String mutation,String name, String email) {
    print(mutation);
    return MutationOptions(
      document: gql(mutation),
      variables: {
        'firstname': name,
        'email': email,
      },
    );
  }

}
