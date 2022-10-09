import 'package:flutter/material.dart';



class OtpVerify {
  Data? data;

  OtpVerify({this.data});

  OtpVerify.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  LoginOTPVerify? loginOTPVerify;

  Data({this.loginOTPVerify});

  Data.fromJson(Map<String, dynamic> json) {
    loginOTPVerify = json['loginOTPVerify'] != null
        ? new LoginOTPVerify.fromJson(json['loginOTPVerify'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loginOTPVerify != null) {
      data['loginOTPVerify'] = this.loginOTPVerify!.toJson();
    }
    return data;
  }
}

class LoginOTPVerify {
  String? message;
  bool? status;
  Null? token;

  LoginOTPVerify({this.message, this.status, this.token});

  LoginOTPVerify.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}




