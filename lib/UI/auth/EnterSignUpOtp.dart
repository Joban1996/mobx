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
import '../../provider/auth/signUpProvider.dart';
import '../../utils/routes.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter_hooks/flutter_hooks.dart';






class EnterSignUpOtp extends StatefulWidget {
  const EnterSignUpOtp({Key? key}) : super(key: key);
  static bool checkedValue = false;

  @override
  State<EnterSignUpOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterSignUpOtp> {
  Timer? timer;
  var otpController = TextEditingController();

  Widget appBarTitle(BuildContext context,String titleText){
    return Text(titleText,style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SignUpProvider>().setInitialTime();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
     context.read<SignUpProvider>().setRemainingTime();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => {
                  Navigator.of(context).pop()
                  }),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: appBarTitle(context, "ENTER OTP"),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
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
                        TextSpan(text: "+91-${context.read<SignUpProvider>().getMobileNumber}",style:
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
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.phone,
                decoration: CommonStyle.textFieldStyle(context,isLeading: false),
              ),

              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Align(
                  alignment: Alignment.center,
                  child: Consumer<SignUpProvider>(
                    builder: (_,val,child){
                      return GestureDetector(
                          onTap: () => val.remainingTime == 0 ? hitWebService(val): {},
                          child: Text("Resent OTP | 00:${val.getRemainingTime<10 ? "0":""}${val.getRemainingTime}",
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(color:
                            Utility.getColorFromHex("#5F5F5F")),));
                    },
                  )),
              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Consumer<SignUpProvider>(
                builder: (_,val,child){
                  return AppButton(onTap: () {
                    if(otpController.text.isNotEmpty){
                      print("SSSSSSSSSSSSSquery results >>>> ${otpController.text}}");
                      print("hvjsfbsmfb===>${val}");
                      val.setLoadingBool(true);
                      val.hitOtpVerifyQuery(phone:
                      val.getMobileNumber,otp: otpController.text).then((value){
                        if(value){
                          print("Call_Inside_Page");

                        

                          val.hitSignUpMutation
                          (

                            mobileNumber: "91${context.read<SignUpProvider>().getMobileNumber}",
                            otp: "${otpController.text}",
                            firstname:context.read<SignUpProvider>().firstName,
                            lastname:context.read<SignUpProvider>().lastName,
                            email:context.read<SignUpProvider>().emailAddress,

                          ).then((value) {
                            print("OOOOOOOOO379_____===> Value${value}");
                         
                          if(value){
                              timer?.cancel();
                          //Navigator.pushReplacementNamed(context, Routes.dashboardScreen);
                          Navigator.pushNamedAndRemoveUntil(context,Routes.dashboardScreen, (route) => false);
                             val.setLoadingBool(false);
                               context.read<SignUpProvider>().setLoadingBool(false);
                          }else{
                               Navigator.of(context).pop();
                          }
                        
                        });
                       
                        }
                       
                      });

                    }}, text: "VERIFY OTP");;
                },
              )
            ],
          ),
        ),
      )),
    );
  }
   hitWebService(SignUpProvider val){
    timer?.cancel();
    val.setLoadingBool(true);
   val.hitSignOtpMutation
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
