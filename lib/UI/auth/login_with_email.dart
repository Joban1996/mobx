
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/common_textfield_style.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/globally_common/common_loader.dart';
import 'package:flutter/cupertino.dart';


class LoginWithEmail extends StatelessWidget {
  LoginWithEmail({Key? key}) : super(key: key);
  static bool checkedValue = false;


  Widget appBarTitle(BuildContext context,String titleText){
    return Text(titleText,style:  Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),);
  }

  final emailCont = TextEditingController();
  final passCont = TextEditingController();


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
                    SizedBox(
                        width: getCurrentScreenWidth(context)*0.5,height: getCurrentScreenHeight(context)*0.1,
                        child: Image.asset("assets/images/ic_launcher.png",fit: BoxFit.contain,)),
                    Text("SELL | PURCHASE | REPAIR | INSURANCE",
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
                      textAlign: TextAlign.center,),
                    SizedBox(height: getCurrentScreenHeight(context)/7,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Please enter your Email Address",
                        style: Theme.of(context).textTheme.caption,),
                    ),
                    verticalSpacing(heightInDouble: 0.01, context: context),
                    TextFormField(
                      controller: emailCont,
                      inputFormatters: [LengthLimitingTextInputFormatter(25),],
                      style: Theme.of(context).textTheme.bodyMedium,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: CommonStyle.textFieldStyle(context,isLeading: false),
                    ),
                    verticalSpacing(heightInDouble: 0.03, context: context),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Please enter your Password",
                        style: Theme.of(context).textTheme.caption,),
                    ),
                    verticalSpacing(heightInDouble: 0.01, context: context),
                    TextFormField(
                      controller: passCont,
                      inputFormatters: [LengthLimitingTextInputFormatter(15),],
                      style: Theme.of(context).textTheme.bodyMedium,
                      keyboardType: TextInputType.text,
                      decoration: CommonStyle.textFieldStyle(context,isLeading: false),
                    ),
                    // CheckboxListTile(
                    //     title: RichText(text: TextSpan(
                    //         children: [
                    //           TextSpan(text: "I agree to the",style: Theme.of(context).textTheme.bodySmall),
                    //           TextSpan(text: "Terms & Conditions",style:
                    //           Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex("#1D4AE7"))),
                    //         ]
                    //     )
                    //     ), //    <-- label
                    //     value: checkedValue,
                    //     contentPadding: EdgeInsets.zero,
                    //     onChanged: (newValue) {  },
                    //     controlAffinity: ListTileControlAffinity.leading
                    // ),
                    verticalSpacing(heightInDouble: 0.03, context: context),
                    AppButton(onTap: (){
                      if(emailCont.text.isNotEmpty && passCont.text.isNotEmpty){
                        context.read<LoginProvider>().setLoadingBool(true);
                        context.read<LoginProvider>().hitLoginWithEmail
                          (email: emailCont.text,password: passCont.text, webSiteId: 1).then((value) {
                          if(value){
                            Navigator.pushNamed(context, Routes.dashboardScreen);
                          }
                          context.read<LoginProvider>().setLoadingBool(false);
                        });
                      }else{
                        Utility.showErrorMessage("Both fields are required");
                      }
                    }, text: "CONTINUE"),
                    verticalSpacing(heightInDouble: 0.03, context: context),
                    GestureDetector(
                        onTap: ()=> Navigator.pushReplacementNamed(context, Routes.loginScreen),
                        child: Text("Login with Phone Number & OTP",style: Theme.of(context).textTheme.bodySmall,))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
