import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/common_textfield_style.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/globally_common/common_loader.dart';







class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
static bool checkedValue = false;


Widget appBarTitle(BuildContext context,String titleText){
  return Text(titleText,style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600),);
}

final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: appBarTitle(context, "LOGIN"),
      ), appbar: AppBar(), onTapCallback: (){}),
      body: CommonLoader(
          screenUI: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/mobex2.png"),
                SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                Text("SELL | PURCHASE | REPAIR | INSURANCE",
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
                  textAlign: TextAlign.center,),
                SizedBox(height: getCurrentScreenHeight(context)/7,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Please enter your phone number",
                    style: Theme.of(context).textTheme.caption,),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextField(
                  controller: phoneController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(context),
                ),
                CheckboxListTile(
                    title: RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "I agree to the",style: Theme.of(context).textTheme.caption),
                          TextSpan(text: "Terms & Conditions",style:
                          Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex("#1D4AE7"))),
                        ]
                    )
                    ), //    <-- label
                    value: checkedValue,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (newValue) {  },
                    controlAffinity: ListTileControlAffinity.leading
                ),
                SizedBox(height: getCurrentScreenHeight(context)*0.03,),
                AppButton(onTap: (){
                  if(phoneController.text.isNotEmpty){
                    context.read<LoginProvider>().setMobileNumber(phoneController.text);
                    context.read<LoginProvider>().setLoadingBool(true);
                    context.read<LoginProvider>().hitLoginMutation
                      (mNumber: "91${phoneController.text}", webSiteId: 1).then((value) {
                      if(value){
                        Navigator.pushNamed(context, Routes.enterOtp);
                      }
                      context.read<LoginProvider>().setLoadingBool(false);
                    });
                  }else{
                    Utility.showErrorMessage("Please enter your phone number");
                  }
                }, text: "CONTINUE")
              ],
            ),
          ),
        ),
      )),
    );
  }
}
