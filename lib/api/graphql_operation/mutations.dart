import 'package:flutter/material.dart';
import 'package:http/http.dart' ;






class QueryMutations{

  String loginOTPMutation(String mobileNo,int id) {
    return """
     mutation {
  loginOTP(mobileNumber: $mobileNo, 
    websiteId: $id) {
    message
    status
  }
}
  
      """;
  }

  String addToCart(String cartId,String skuID) {
    return """
mutation {
  addProductsToCart(
    cartId: $cartId
    cartItems: [
      {
        quantity: 1
        sku: $skuID
      }
    ]
  ) {
    cart {
      items {
        product {
          name
          sku
        }
        quantity
      }
    }
    user_errors {
      code
      message
    }
  }
}  
      """;
  }

}