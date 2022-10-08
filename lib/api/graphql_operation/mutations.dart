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

}