import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    timerWithCheck(context);
  }
  Future getToken()async{
    final prefs = await SharedPreferences.getInstance();
    var sToken =  prefs.getString(PREF_TOKEN);
    return sToken;
  }
  timerWithCheck(BuildContext context){
    Timer(
        const Duration(seconds: 3),
            () =>
        {
          getToken().then((token) => {
            debugPrint("token>>>>>>> $token"),
            if(token == null || token.toString().isEmpty){
              Navigator.pushReplacementNamed(context, Routes.welcomeScreen)
              //Navigator.of(context).pushReplacementNamed(Routes.dashboardScreen)
            }else{
              Navigator.pushReplacementNamed(context, Routes.dashboardScreen)
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Utility.getColorFromHex(globalOrangeColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/mobexwhite.png',
                width: MediaQuery.of(context).size.width*0.30,),
              verticalSpacing(heightInDouble: 0.01, context: context),
              Text(
                Strings.splash_sub_title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}