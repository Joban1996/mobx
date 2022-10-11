import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/dashboard_screen.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../common_widgets/globally_common/richtext_widget.dart';
import '../../utils/constants/strings.dart';
class WelcomeScreen extends StatelessWidget {


  WelcomeScreen({Key? key}) : super(key: key);
  //final  size=MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Utility.getColorFromHex(globalOrangeColor),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          //left: MediaQuery.of(context).size.width*0.02,
          // right: MediaQuery.of(context).size.width*0.02,
          top: MediaQuery.of(context).size.height*0.04,
          bottom: MediaQuery.of(context).size.height*0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                //left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.04
              ),
              child: Text("Skip",
                style: const TextStyle(
                    color: Colors.white
                ),),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/images/mobexwhite.png',
                width:  MediaQuery.of(context).size.width*0.40,
              ),
              // Text(
              //   Strings.app_name,
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 24.0,
              //   ),
              // ),
            ),
            Image.asset('assets/images/mobex.png',height: MediaQuery.of(context).size.height*0.50,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.04,
                  //right: MediaQuery.of(context).size.width*0.02
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Purchase",
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                    ),
                    verticalSpacing(heightInDouble: 0.02, context: context),
                    Text("Refurbished Phones",
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                    ),
                    verticalSpacing(heightInDouble: 0.02, context: context),
                    RichTextWidget(text: Strings.welcome_subTagLine1),
                    RichTextWidget(text: Strings.welcome_subTagLine2),
                    RichTextWidget(text: Strings.welcome_subTagLine3),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: (){
                 Navigator.pushNamed(context, Routes.loginScreen);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    //left: MediaQuery.of(context).size.width*0.02,
                      right: MediaQuery.of(context).size.width*0.04
                  ),
                  child: const Icon(Icons.arrow_forward,color: Colors.white,),
                ))
          ],
        ),
      ),
    );
  }
}