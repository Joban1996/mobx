// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widgets/globally_common/app_button.dart';
import '../../provider/auth/signUpProvider.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/routes.dart';
import '../../utils/utilities.dart';

Widget appBarTitle(BuildContext context, String titleText) {
  return Text(
    titleText,
    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
  );
}

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailAddressController = TextEditingController();

  final passwordEntered = TextEditingController();

  final phoneController = TextEditingController();

 var valuefirst = false;  
  var valuesecond = false;  

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
                  child: appBarTitle(context, "Sign Up"),
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
              
              children: [
              
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "First Name",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: firstNameController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Please Enter Your First Name",
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 15,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor)))),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Last Name",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: lastNameController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Please Enter Your Last Name",
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 15,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor)))),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: emailAddressController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Please Enter Your Email Address",
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 15,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor)))),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone Number",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: phoneController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Text(
                        " +91",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      hintText: "0000000000",
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 15,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.all(8),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  Utility.getColorFromHex(globalOrangeColor)))),
                ),
                SizedBox(
                  height: getCurrentScreenHeight(context) * 0.03,
                ),
                Row(
                  children: <Widget>[
                       Checkbox(
                value: valuefirst,
                checkColor: Colors.white,
                activeColor: Colors.deepOrangeAccent,
                onChanged: ( value) {
                  setState(() => valuefirst = value!);
                },
              ), 
                    Text(
                      "I agree to the ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () async{
                        print("I was tapped!");
                        String urlString = 'https://www.mobex.in/ecommerce-tnc';
  if(await launch(urlString)){
debugPrint("293 launch success");
  }else{
debugPrint("295 launch not success.");

  }
                      },
                      child: Text("Terms & Condition",
                          style: TextStyle(
                              color: Color.fromARGB(255, 44, 101, 200))),
                    ),
                  
                  ],
                ),
                SizedBox(
                  height: getCurrentScreenHeight(context) * 0.03,
                ),
                AppButton(
                    onTap: () async {
                     print("valuefirstvaluefirst");
                     print(valuefirst);
                      if (lastNameController.text.isNotEmpty && firstNameController.text.isNotEmpty && emailAddressController.text.isNotEmpty  && phoneController.text.isNotEmpty) {

                        if(valuefirst == false){
                        Utility.showErrorMessage("Please agree terms and condition.");
                      }else{

                        context.read<SignUpProvider>().setFirstName(firstNameController.text);
                        context.read<SignUpProvider>().setLastName(lastNameController.text);
                        context.read<SignUpProvider>().setEmailAddress(emailAddressController.text);
                        context.read<SignUpProvider>().setMobileNumber(phoneController.text);
                        context.read<SignUpProvider>().setLoadingBool(true);
                        context.read<SignUpProvider>().hitMobileNumberSignUp
                          (mNumber: "91${phoneController.text}", webSiteId: 1).then((value) async {

                            print("Value_one_Two${value}");
                       
                          if(value){
                               Utility.showSuccessMessage("Message send.");
                             var appSignatureId = await SmsAutoFill().getAppSignature;
                             Map sendOtpData = {
                              "mobile_number":"91${phoneController.text}",
                              "app_signature_id":appSignatureId
                             };
                     print("Log of Signature is herer ${sendOtpData}");
                            Navigator.pushNamed(context, Routes.enterSignUpOtp);
                          }else{
                             Utility.showErrorMessage("Your mobile number is already registetred.");
                          }
                          context.read<SignUpProvider>().setLoadingBool(false);
                        });
                        // print(lastNameController);
                        // print(firstNameController);
                        // print(emailAddressController);
                        // print(phoneController);
                        // Navigator.pushNamed(context, Routes.enterOtp);
                      }
                      }
                      else {
                        Utility.showErrorMessage("Please enter your Details");
                      }
                    },
                    text: "Submit"),
                SizedBox(
                  height: getCurrentScreenHeight(context) * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
