import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/graphql_operation/customer_queries.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/common_textfield_style.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../utils/routes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';






class EnterOtp extends StatefulWidget {
  const EnterOtp({Key? key}) : super(key: key);
  static bool checkedValue = false;

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  Timer? timer;
  var otpController = TextEditingController();
  Widget appBarTitle(BuildContext context,String titleText){
    return Text(titleText,style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
     context.read<LoginProvider>().setRemainingTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: appBarTitle(context, "ENTER OTP"),
      ), appbar: AppBar(), onTapCallback: (){}),
      body: CommonLoader(
          screenUI: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getCurrentScreenHeight(context)*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(text: TextSpan(
                      children: [
                        TextSpan(text: "We’ve sent an OTP on ",style: Theme.of(context).textTheme.caption),
                        TextSpan(text: "+91-${context.read<LoginProvider>().getMobileNumber}",style:
                        Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w600)),
                      ]
                  )
                  ),
                  Text("Change",style:  Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalOrangeColor)),)
                ],
              ),
              SizedBox(height: getCurrentScreenHeight(context)*0.02,),
              TextField(
                controller: otpController,
                inputFormatters: [LengthLimitingTextInputFormatter(10),],
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.phone,
                decoration: CommonStyle.textFieldStyle(context,isLeading: false),
              ),

              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () => context.read<LoginProvider>().remainingTime == 0 ? hitWebService(): {},
                      child: Text("Resent OTP | 00:${context.watch<LoginProvider>().getRemainingTime<10 ? "0":""}${context.watch<LoginProvider>().getRemainingTime}",
                        style:  Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex("#5F5F5F")),))),
              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              AppButton(onTap: () {
                if(otpController.text.isNotEmpty){
                context.read<LoginProvider>().setLoadingBool(true);
                context.read<LoginProvider>().hitOtpVerifyMutation(phone:
                context.read<LoginProvider>().getMobileNumber,otp: otpController.text).then((value){
                  if(value){
                    timer?.cancel();
                    //Navigator.pushReplacementNamed(context, Routes.dashboardScreen);
                    Navigator.pushNamedAndRemoveUntil(context,Routes.dashboardScreen, (route) => false);
                  }
                  context.read<LoginProvider>().setLoadingBool(false);
                });

              }}, text: "VERIFY OTP")
            ],
          ),
        ),
      )),
    );
  }
  hitWebService(){
    context.read<LoginProvider>().setLoadingBool(true);
    context.read<LoginProvider>().hitLoginMutation
      (mNumber: "91${context.read<LoginProvider>().getMobileNumber}", webSiteId: 1).then((value) {
      if(value){
        Navigator.pushNamed(context, Routes.enterOtp);
      }
      context.read<LoginProvider>().setLoadingBool(false);
    });
  }
}
