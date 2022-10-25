import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'constants/constants_colors.dart';


class Utility {
  delayed(Duration duration, VoidCallback voidCallback) => Timer(duration, voidCallback);
  static String helpText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";

  static String aboutUsContent =
      "SMART OTOMATION SOLUTIONS FZCO Otomations: Is a digital transformation solutions that links all aftermarket cars related services from car sales, repair services and spare parts under one umbrella that hooks the customers to the showrooms to buy his ride, or to spare parts to buy required used parts and also service centers to repair his car. This 360 solution will enable a one stop shop that can save the time and efforts of all parties and bring them together under the Otomations center to do business.";
  static Widget loadingWidget(){
    return Container(
      color: Colors.grey,
      margin: EdgeInsets.only(right: 5, left: 5),
      width: 75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }



  ///hide keyboard from screen
  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static String customerId = "";


  ///show error message
  static void showErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal message
  static void showNormalMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal message
  static void showSuccessMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Utility.getColorFromHex("#00800B"),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal in center message
  static void showSuccessMessageCenter(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Utility.getColorFromHex("#00800B"),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///alert dialog for camera gallery section
  static Future<void> optionsDialogBox(BuildContext context,
      GestureTapCallback camera, GestureTapCallback gallery) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Expanded(
                    child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.3,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        children: <Widget>[
                          GestureDetector(
                            child: new Text('Take a picture',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            onTap: camera,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          GestureDetector(
                            child: new Text(
                              'Select from gallery',
                              style:
                              TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            onTap: gallery,
                          ),
                          /*      _gridTile(context, 'Take a photo',
                              Icons.camera_alt, () => camera),
                          _gridTile(context, 'Take a video', Icons.photo_library, () => gallery())*/
                        ]),
                  ),
                  GestureDetector(
                    child: new Text('Take a picture',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    onTap: camera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: new Text(
                      'Select from gallery',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onTap: gallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Future<bool> assetExists(String asset) async {
    bool status = true;
    var abc = await rootBundle.load(asset).catchError(() => {status = false});
    abc == null ? status = false : status = true;
    return status;
  }

  /// converts HEX to RGB Color
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  ///check internet connection
  static Future<bool> checkInternet() async
  {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static String getTimeAgo(createdAt) {
    var date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "Just now";
  }



}

Size getCurrentScreenSize(BuildContext context) => MediaQuery.of(context).size;

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}
double getCurrentScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double getCurrentScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

verticalSpacing({required double heightInDouble,required BuildContext context}){
  return SizedBox(height: getCurrentScreenHeight(context)*heightInDouble);
}
horizontalSpacing({required double widthInDouble,required BuildContext context}){
  return SizedBox(width: getCurrentScreenWidth(context)*widthInDouble);
}
Widget globalLoader(){
  return  Center(child: CircularProgressIndicator(valueColor:
  AlwaysStoppedAnimation<Color>(Utility.getColorFromHex(globalOrangeColor))));
}

Widget dividerCommon(BuildContext context){
  return Divider(height: getCurrentScreenHeight(context)*0.02);
}

int timeInMillis = 1586348737122;
var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
var formattedDate = DateFormat.yMMMd().format(date); // Apr 8, 2

greenTextStyle(double _fontSize) {
  return TextStyle(
      height: 1.5,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w600,
      color: Color(0xFF43B65B),
      fontSize: _fontSize);
}

whiteTextStyle(double _fontSize) {
  return TextStyle(
      height: 1.5,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: _fontSize);
}

bool validateStructure(String value)
{
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
