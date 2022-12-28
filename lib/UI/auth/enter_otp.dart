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
    context.read<LoginProvider>().setInitialTime();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
     context.read<LoginProvider>().setRemainingTime();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
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
                  GestureDetector(
                      onTap: ()=> Navigator.pushReplacementNamed(context, Routes.loginScreen),
                      child: Text("Change",style:  Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalOrangeColor)),))
                ],
              ),
              SizedBox(height: getCurrentScreenHeight(context)*0.02,),
              TextField(
                controller: otpController,
                inputFormatters: [LengthLimitingTextInputFormatter(10),],
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.phone,
                decoration: CommonStyle.textFieldStyle(context,isLeading: false),
              ),

              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Align(
                  alignment: Alignment.center,
                  child: Consumer<LoginProvider>(
                    builder: (_,val,child){
                      return GestureDetector(
                          onTap: () => val.remainingTime == 0 ? hitWebService(val): {},
                          child: Text("Resent OTP | 00:${val.getRemainingTime<10 ? "0":""}${val.getRemainingTime}",
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(color:
                            Utility.getColorFromHex("#5F5F5F")),));
                    },
                  )),
              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Consumer<LoginProvider>(
                builder: (_,val,child){
                  return AppButton(onTap: () {
                    if(otpController.text.isNotEmpty){
                      val.setLoadingBool(true);
                      val.hitOtpVerifyQuery(phone:
                      val.getMobileNumber,otp: otpController.text).then((value){
                        if(value){
                          timer?.cancel();
                          //Navigator.pushReplacementNamed(context, Routes.dashboardScreen);
                          Navigator.pushNamedAndRemoveUntil(context,Routes.dashboardScreen, (route) => false);
                        }
                        val.setLoadingBool(false);
                      });

                    }}, text: "VERIFY OTP");
                },
              )
            ],
          ),
        ),
      )),
    );
  }
  hitWebService(LoginProvider val){
    timer?.cancel();
    val.setLoadingBool(true);
   val.hitLoginMutation
      (mNumber: "91${val.getMobileNumber}", webSiteId: 1).then((value) {
      if(value){
        val.setInitialTime();
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          val.setRemainingTime();
        });
      }
      val.setLoadingBool(false);
    });
  }
}
