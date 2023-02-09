import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobx/model/product/getRegionModel.dart';

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

  String createAccountNumberMutation(String mobileNo, int id) {
    return """
     mutation {
  createAccountOTP(mobileNumber: $mobileNo, 
    websiteId: $id) {
    message
    status
  }
}
  
      """;
  }

  String signUpOTPMutation(String mobileNo, int id) {
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

  // String createAccountMutation(String mobileNumber, String otp,String firstname, String lastname, String email) {
  //   return """
  //    mutation  {
  //     createCustomerAccount(
  //   mobileNumber:$mobileNumber
  //   otp:$otp
  //  input:{
  //  firstname: $firstname
  //   lastname: $lastname
  //   email: $email
  //   }
  //     )

  //   customer {
  //       firstname
  //       lastname
  //       email
  //     }
  //         token
  //     status
  //     message
  // }

  //     """;
  // }

  String createAccountMutation(String mobileNumber, String otp,
      String firstname, String lastname, String email) {
    return """

mutation{
  createCustomerAccount(
  mobileNumber:$mobileNumber
      otp:$otp
     input:{
     firstname:"$firstname"
      lastname: "$lastname"
      email: "$email"
      }
  ){
 customer {
        firstname
        lastname
        email
      }
 token
      status
      message
  }
  
}
  
      """;
  }

  String loginWithEmailMutation(String email, String password) {
    return """
mutation {
  generateCustomerToken(
    email: "$email"
    password: "$password"
  ) {
    token
  }
}

  
      """;
  }

  String addToCart(String cartId, String skuID) {
    return """
mutation {
  addProductsToCart(
    cartId: "$cartId"
    cartItems: [
      {
        quantity: 1
        sku: "$skuID"
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
      cart_id: "$cartId",
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
      cart_id: "$cartId"
      coupon_code: "$couponCode"
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
      { cart_id: "$cartId" }
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

  String addNewAddress(
      AvailableRegions regions,
      String firstName,
      String lastName,
      String city,
      String state,
      String pinCode,
      String phonNumber,
      bool isBillingAddress,
      String street) {
    return """
mutation {
  createCustomerAddress(
  input: {
    region: {
      region: "${regions.name}"
      region_code: "${regions.code}"
      region_id: "${regions.id}"
    }
    country_code: IN
    street: ["$street"]     
    postcode: "$pinCode"
    city: "$city"
    firstname: "$firstName"
    lastname: "$lastName"
    telephone: "$phonNumber"
    default_shipping: true
    default_billing: $isBillingAddress
  }) {
    id
    region {
      region
      region_code
    }
    country_code
    street
    telephone
    postcode
    city
    default_shipping
    default_billing
  }
}

    """;
  }

  String updateAddressMutation(String firstName, String lastName,String city, String state,
      String pinCode,String street,int id,AvailableRegions regions)
  {
    return """
mutation {
  updateCustomerAddress(id: $id, input: {
    street: ["$street"]     
    postcode: "$pinCode"
    city: "$city"
    firstname: "$firstName"
    lastname: "$lastName"
    region: {
      region: "${regions.name}"
      region_code: "${regions.code}"
      region_id: "${regions.id}"
    }
  }) {
    id
    city
    postcode
  }
}

    """;
  }

  String addShippingAddress(
      AvailableRegions regions,
      String firstName,
      String lastName,
      String city,
      String pinCode,
      String phonNumber,
      bool isBillingAddress,
      String street,
      String cartId) {
    return """
mutation {
  setShippingAddressesOnCart(
    input: {
      cart_id: "$cartId"
      shipping_addresses: [
        {
          address: {
            firstname: "$firstName"
            lastname: "$lastName"
            company: ""
            street: ["$street"]
            city: "$city"
            region: "${regions.code}"
            region_id: "${regions.id}"
            postcode: "$pinCode"
            country_code: "IN"
            telephone: "$phonNumber"
            save_in_address_book: false
          }
        }
      ]
    }
  ) {
    cart {
      shipping_addresses {
        firstname
        lastname
        company
        street
        city
        region {
          code
          label
        }
        postcode
        telephone
        country {
          code
          label
        }
        available_shipping_methods{
          carrier_code
          carrier_title
          method_code
          method_title
        }
      }
    }
  }
}
    """;
  }

  String addBillingAddress(
      AvailableRegions regions,
      String firstName,
      String lastName,
      String city,
      String pinCode,
      String phonNumber,
      String street,
      String cartId) {
    return '''
    mutation {
  setBillingAddressOnCart(
    input: {
      cart_id: "$cartId"
      billing_address: {
        address: {
            firstname: "$firstName"
            lastname: "$lastName"
            company: ""
            street: ["$street"]
            city: "$city"
            region: "${regions.code}"
            region_id: "${regions.id}"
            postcode: "$pinCode"
            country_code: "IN"
            telephone: "$phonNumber"
            save_in_address_book: false
          }
      }
    }
  ) {
    cart {
      billing_address {
        firstname
        lastname
        company
        street
        city
        region{
          code
          label
        }
        postcode
        telephone
        country {
          code
          label
        }
      }
    }
  }
}

    ''';
  }

  String setPayMethod(String cartId, String code) {
    return """
    mutation {
  setPaymentMethodOnCart(input: {
      cart_id: "$cartId"
      payment_method: {
          code: $code
      }
  }) {
    cart {
      selected_payment_method {
        code
      }
    }
  }
}  
      """;
  }

  String setShippingMethod(String cartId) {
    return """
mutation {
  setShippingMethodsOnCart(input: {
    cart_id: "$cartId"
    shipping_methods: [
      {
      carrier_code: "tablerate"
        method_code: "bestway"
      }
    ]
  }) {
    cart {
      shipping_addresses {
        selected_shipping_method {
          carrier_code
          method_code
          carrier_title
          method_title
        }
      }
    }
  }
}
 
      """;
  }

  String placeOrder(String cartId) {
    return """
   mutation {
  placeOrder(input: {cart_id: "$cartId"}) {
    order {
      order_number
    }
  }
}
      """;
  }

  String placeRazorpayOrderMutation(String cartId){
    return """
      mutation {
    placeRazorpayOrder(cart_id: "$cartId") {
      success
      rzp_order_id
      order_quote_id
      amount
      currency
      message
    }
  }
    """;
  }

  String deleteAddress(int id) {
    return """
mutation {
  deleteCustomerAddress(id: $id)
}
      """;
  }

  String addToWishlistMutation(int id, String sku, int quantity) {
    return """
mutation {
  addProductsToWishlist(
    wishlistId: $id
    wishlistItems: [
      {
        sku: "$sku"
        quantity: $quantity
      }
    ]
  ) {
    wishlist {
      id

    }
    user_errors {
      code
      message
    }
  }
}

      """;
  }

  String deleteWishlist(
    int wishlistItemId,
    int wishListId,
  ) {
    return """
mutation {
  removeProductsFromWishlist(
  wishlistId: $wishListId
  wishlistItemsIds: [
    $wishlistItemId
  ]){
    wishlist {
      id
      items_count
      items_v2 {
        items {
          id
          quantity
          product {
            uid
            name
            sku
            price_range {
              minimum_price {
                regular_price  {
                  currency
                  value
                }
              }
              maximum_price {
                regular_price {
                  currency
                  value
                }
              }
            }
          }
        }
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

  String addWishlistToCart(int wishlistItemId, int wishListId) {
    return """
mutation {
  addWishlistItemsToCart(
    wishlistId: $wishListId
    wishlistItemIds: [$wishlistItemId])
  {
    status
    add_wishlist_items_to_cart_user_errors {
      code
      message
    }
    wishlist {
      id
      items_v2 {
        items {
          id
          product {
            uid
            sku
            name
          }
        }
      }
    }
  }
} 
      """;
  }

  String updateCustomer(String name, String lastname ,int gender,String date_of_birth ,String email) {
    return """
mutation {
  updateCustomer(
    input: {
      firstname: "$name"
      lastname:"$lastname"
      email: "$email"
      gender:"$gender"
      date_of_birth:"$date_of_birth"
    }
  ) {
    customer {
      firstname
      lastname
      email
      date_of_birth
      gender
    }
  }
}

      """;
  }

  String setRazorpayDetails(String cartId,String paymentId, String orderID,String signature) {
    return """
mutation {
    setRzpPaymentDetailsOnCart(
      input: {
        cart_id: "$cartId"
        rzp_payment_id: "$paymentId"
        rzp_order_id: "$orderID"
        rzp_signature: "$signature"
      }
    ) {
      cart {
        id
      }
    }
  }
      """;
  }

}
