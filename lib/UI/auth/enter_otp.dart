import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/common_textfield_style.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../utils/routes.dart';







class EnterOtp extends StatelessWidget {
  const EnterOtp({Key? key}) : super(key: key);
  static bool checkedValue = false;

  Widget appBarTitle(BuildContext context,String titleText){
    return Text(titleText,style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600),);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarCommon(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: appBarTitle(context, "ENTER OTP"),
      ), appbar: AppBar(), onTapCallback: (){}),
      body: SingleChildScrollView(
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
                        TextSpan(text: context.read<LoginProvider>().getMobileNumber,style:
                        Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w600)),
                      ]
                  )
                  ),
                  Text("Change",style:  Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalOrangeColor)),)
                ],
              ),

              SizedBox(height: getCurrentScreenHeight(context)*0.02,),
              TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(10),],
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.phone,
                decoration: CommonStyle.textFieldStyle(context),
              ),

              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              Align(
                  alignment: Alignment.center,
                  child: Text("Resent OTP | 00:20",style:  Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex("#5F5F5F")),)),
              SizedBox(height: getCurrentScreenHeight(context)*0.03,),
              AppButton(onTap: () {
                Navigator.pushNamed(context, Routes.dashboardScreen);
              }, text: "VERIFY OTP")
            ],
          ),
        ),
      ),
    );
  }
}
