import 'package:flutter/material.dart';
import 'package:http/http.dart' ;






class QueryMutations {

  String loginOTPMutation(String mobileNo, int id) {
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

  String addToCart(String cartId, String skuID) {
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


  String updateCart(String cartId, String cartUID, int quantity) {
    return """
mutation {
  updateCartItems(
    input: {
      cart_id: $cartId,
      cart_items: [
        {
          cart_item_id: $cartUID
          quantity: $quantity
        }
      ]
    }
  ){
    cart {
      items {
        uid
        product {
          name
        }
        quantity
      }
      prices {
        grand_total{
          value
          currency
        }
      }
    }
  }
}
  
      """;
  }

  String applyCoupon(String cartId, String couponCode) {
    return """
mutation {
  applyCouponToCart(
    input: {
      cart_id: $cartId
      coupon_code: $couponCode
    }
  ) {
    cart {
      applied_coupons {
        code
      }
    }
  }
}
      """;
  }

  String removeCoupon(String cartId) {
    return """
mutation {
  removeCouponFromCart(
    input:
      { cart_id: $cartId }
    ) {
    cart {
      items {
        product {
          name
        }
        quantity
      }
      applied_coupons {
        code
      }
      prices {
        grand_total{
          value
          currency
        }
      }
    }
  }
}
      """;
  }


}
