
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


class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
static bool checkedValue = false;


Widget appBarTitle(BuildContext context,String titleText){
  return Text(titleText,style:  Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),);
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
                Container(
                    height: 80,width: 200,
                    child: Image.asset("assets/images/Mobex_tp.png")),
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
                TextFormField(
                  controller: phoneController,
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon:  Text(" +91" ,style: Theme.of(context).textTheme. bodySmall,),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 15,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Utility.getColorFromHex(globalOrangeColor))
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Utility.getColorFromHex(globalOrangeColor))
                      ),
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Utility.getColorFromHex(globalOrangeColor))
                      ),
                      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))
                          ,borderSide: BorderSide(color: Utility.getColorFromHex(globalOrangeColor))
                      )
                  ),
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
                }, text: "CONTINUE"),
                SizedBox(height: getCurrentScreenHeight(context)*0.03,),
                GestureDetector(
                    onTap: ()=> Navigator.pushReplacementNamed(context, Routes.loginWithEmail),
                    child: Text("Login with Email ID & Password",style: Theme.of(context).textTheme.bodySmall,))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
