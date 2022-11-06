import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as Http;
import 'package:http_parser/http_parser.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/log.dart';
import 'package:mobx/utils/utilities.dart';
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
class WebServiceClient {
  static const BASE_URL = "https://api.carscentro.com/graphql/";

  /// login via email or phone
  static Future<dynamic> loginUser(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "api/customer/login";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) {
      response = value;
    }).catchError((onError){
      debugPrint(onError);
    }).timeout(Duration(seconds: 120),onTimeout: (){
    });
    return response;
  }

  /// sign up user
  static Future<dynamic> signUpUser(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "api/customer";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  /// verify email api
  static Future<dynamic> verifyEmail(Map<String, dynamic> fieldMap) async
  {
    var url = BASE_URL + "api/customer/verify";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  /// verify OTP of
  static Future<dynamic> verifyOTP(
      Map<String, dynamic> fieldMap, bool isEmailVerification) async {
    var url;
    if (isEmailVerification) {
      // url = BASE_URL + "api/User/Verify/EmailOTP";
    } else {
      // url = BASE_URL + "api/User/Verify/MobileOTP";
    }
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  /// verify OTP of
  static Future<dynamic> forgotPassword(Map<String, dynamic> fieldMap) async {
    var url;
    url = BASE_URL + "api/customer/forgot-password";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  /// validate OTP of
  static Future<dynamic> validateForgotPassword(Map<String, dynamic> fieldMap) async {
    var url;
    url = BASE_URL + "api/customer/forgot-password/validate-code";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  /// update password of
  static Future<dynamic> updatePassword(Map<String, dynamic> fieldMap) async {
    var url;
    url = BASE_URL + "api/User/UpdatePassword";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  static Future<dynamic> changePassword(Map<String, dynamic> fieldMap) async {
    var url;
    url = BASE_URL + "api/customer/change-password";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    return response;
  }

  ///user profile items update
  static Future<dynamic> updateUserProfile(Map<String, dynamic> fieldMap,Map<String, File> file) async {
    var url;
    url = BASE_URL + "api/customer/update-profile";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_MULTIPART,
        TokenType.TYPE_NONE, fieldMap, files: file)
        .then((value) => {response = value});
    return response;
  }

  static Future<dynamic> logOut(Map<String, dynamic> fieldMap) async {
    var url;

    url = BASE_URL + "api/customer/logout";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE, fieldMap)
        .then((value) => {response = value});
    debugPrint(response);
    debugPrint("response_logout");
    return response;
  }


  ///this method will actually hit the service based on method(GET,PUT,POST
  static Future<dynamic> _hitService(String url, HttpMethod method,
      RequestBodyType type, TokenType tokenType, Map<String, dynamic> fieldMap,
      {Map<String, File>? files}) async {
    if (await Utility.checkInternet()) {
      var response;
      var headerMap = Map<String, String>();
      if (tokenType == TokenType.TYPE_BASIC) {
        var sp = await SharedPreferences.getInstance();
        var token = sp.getString(PREF_TOKEN);
        Log.d("$token");
        headerMap["Authorization"] = "Bearer $token" ?? "";
      } else {
        var sp = await SharedPreferences.getInstance();
        var token = await sp.get(PREF_TOKEN);
        headerMap["Authorization"] = "Bearer $token" ?? "";
      }
      switch (method) {
        case HttpMethod.HTTP_GET:
          {
            Log.d("Sending Request:: GET $url headers $headerMap");
            response = await Http.get(Uri.parse(url), headers: headerMap);
          }
          break;
        case HttpMethod.HTTP_POST:
          {
            if (type == RequestBodyType.TYPE_XX_URLENCODED_FORMDATA) {
              headerMap["Content-Type"] = "application/x-www-form-urlencoded";
              Log.d("Sending Request:: POST $url body $fieldMap");
              response = await Http.post(Uri.parse(url),
                  headers: headerMap,
                  body: fieldMap,
                  encoding: convert.Utf8Codec());
            } else if (type == RequestBodyType.TYPE_MULTIPART) {
              headerMap["Content-Type"] = "multipart/form-data";
              var request = Http.MultipartRequest("POST", Uri.parse(url));
              if (fieldMap != null) {
                Map<String, String> map = fieldMap.cast<String, String>();
                request.fields.addAll(map);
              }
              if (files != null && files.isNotEmpty) {
                files.forEach((key, file) async {
                  Http.MultipartFile multipartFile =
                  await Http.MultipartFile.fromPath(key, file.path,
                      contentType: file.path.endsWith("*.png")
                          ? MediaType('image', 'x-png')
                          : MediaType('image', 'jpeg'));
                  debugPrint(
                      "file is ${multipartFile.contentType} ${multipartFile.filename} ${multipartFile.length}");
                  request.files.add(multipartFile);
                });
              }
              request.headers.addAll(headerMap);
              response = await request.send();
            } else {
              headerMap["Content-Type"] = "application/json";
              var json = convert.jsonEncode(fieldMap);
              Log.d("Sending Request:: POST $url body $json");
              response = await Http.post(Uri.parse(url), headers: headerMap, body: json);
            }
          }
          break;
        case HttpMethod.HTTP_PUT:
          if (type == RequestBodyType.TYPE_XX_URLENCODED_FORMDATA) {
            headerMap["Content-Type"] = "application/x-www-form-urlencoded";
            Log.d("Sending Request:: PUT $url body $fieldMap");
            response = await Http.put(Uri.parse(url),
                headers: headerMap,
                body: fieldMap,
                encoding: convert.Utf8Codec());
          } else if (type == RequestBodyType.TYPE_MULTIPART) {
            headerMap["Content-Type"] = "multipart/form-data";
            var request = await Http.MultipartRequest("PUT", Uri.parse(url));
            Map<String, String> map = fieldMap.cast<String, String>();
            request.fields.addAll(map);
            if (files != null && files.isNotEmpty) {
              files.forEach((key, file) async {
                Http.MultipartFile multipartFile =
                await Http.MultipartFile.fromPath(
                  key,
                  file.path,
                );
                request.files.add(multipartFile);
              });
            }
            request.headers.addAll(headerMap);
            response = await request.send();
          } else {
            headerMap["Content-Type"] = "application/json";
            var json = convert.jsonEncode(fieldMap);
            Log.d("Sending Request:: PUT $url body $json");
            response = await Http.put(Uri.parse(url), headers: headerMap, body: json);
          }
          break;
      }
      var statusCode = response.statusCode;
      Log.d("Response Code  :: $statusCode");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (type == RequestBodyType.TYPE_MULTIPART) {
          var res = await Http.Response.fromStream(response);
          Log.d("Response is :: " + res.body);
          return res.body;
        } else
          Log.d("Response is :: " + response.body);
        return response.body;
      } else {
        switch (response.statusCode) {
          case 400:
            return WebError.BAD_REQUEST;
            break;
          case 403:
            return WebError.BAD_REQUEST;
            break;
          case 500:
            return WebError.INTERNAL_SERVER_ERROR;
            break;
          case 404:
            return WebError.NOT_FOUND;
            break;
          case 401:
            return WebError.UNAUTHORIZED;
            break;
          case 409:
            return WebError.ALREADY_EXIST;
            break;
          default:
            return WebError.UNKNOWN;
            break;
        }
      }
    } else {
      return WebError.INTERNAL_SERVER_ERROR;
    }
  }
}
