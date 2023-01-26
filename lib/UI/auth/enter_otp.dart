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

import 'package:alt_sms_autofill/alt_sms_autofill.dart';






class EnterOtp extends StatefulWidget {
  const EnterOtp({Key? key}) : super(key: key);
  static bool checkedValue = false;

  @override
  State<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOtp> {
  
  Timer? timer;
  var otpController = TextEditingController();
 late  TextEditingController textEditingController1;

 String _comingSms = "" ;

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

     textEditingController1 = TextEditingController();
    initSmsListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
     textEditingController1.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
    timer!.cancel();
  }

    Future<void> initSmsListener() async {

    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms!;
      print("AAAAA====>Message: ${_comingSms}");
      print("ALOK ====>${_comingSms[23]}");

      textEditingController1.text = _comingSms[26] + _comingSms[27] + _comingSms[28] + _comingSms[29]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
    print("6555555 $textEditingController1.text");
  }

  @override
  Widget build(BuildContext context) {



  String _comingSms = 'Unknown';


debugPrint("textEditingController1textEditingController1 $textEditingController1");

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
                controller: textEditingController1,
                inputFormatters: [LengthLimitingTextInputFormatter(10),],
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.phone,
                decoration: CommonStyle.textFieldStyle(context,isLeading: false),
              ),
              // PinCodeTextField(
              //   appContext: context,
              //   pastedTextStyle: TextStyle(
              //     color: Colors.green.shade600,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   length: 4,
              //   obscureText: false,
              //   animationType: AnimationType.fade,
              //   pinTheme: PinTheme(
              //       shape: PinCodeFieldShape.box,
              //       borderRadius: BorderRadius.circular(10),
              //       fieldHeight: 50,
              //       fieldWidth: 40,
              //       inactiveFillColor: Colors.blue,
              //       inactiveColor: Colors.blue,
              //       selectedColor: Colors.blue,
              //       selectedFillColor: Colors.white,
              //       activeFillColor: Colors.white,
              //       activeColor: Colors.black12
              //   ),
              //   cursorColor: Colors.black,
              //   animationDuration: Duration(milliseconds: 300),
              //   enableActiveFill: true,
              //   controller: textEditingController1,
              //   keyboardType: TextInputType.number,
              //   boxShadows: [
              //     BoxShadow(
              //       offset: Offset(0, 1),
              //       color: Colors.black12,
              //       blurRadius: 10,
              //     )
              //   ],
              //   onCompleted: (v) {
              //     //do something or move to next screen when code complete
              //   },
              //   onChanged: (value) {
              //     print(value);
              //     setState(() {
              //       print('vgvg$value');
              //       value = value;
              //     });
              //   },
              // ),
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
                    print("come and check again $textEditingController1.text");
                    if(textEditingController1.text.isNotEmpty){
                      val.setLoadingBool(true);
                      print("_______UIUIUIUIU ${val} child ${child}");
                      val.hitOtpVerifyQuery(phone:
                      val.getMobileNumber,otp: textEditingController1.text).then((value){
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
