import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        AppBarTitle(Strings.order_confirmed_app_title,''),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          Image.asset("assets/images/lock.png")
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.03,
                right: MediaQuery.of(context).size.width*0.03,
                top: MediaQuery.of(context).size.height*0.02,
                bottom: MediaQuery.of(context).size.height*0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color:  Utility.getColorFromHex(globalParrotColor),
              ),
            child: Icon(Icons.check_outlined,color: Colors.white,size: 42.0,),
            ),
            verticalSpacing(heightInDouble: 0.02, context: context),
            Text(Strings.thanksMessage,),
            verticalSpacing(heightInDouble: 0.02, context: context),
            Text(Strings.confirmationMessage1),
           // verticalSpacing(heightInDouble: 0.02, context: context),
            Text(Strings.confirmationMessage2),
            verticalSpacing(heightInDouble: 0.02, context: context),
            OutLineButtonWidget(
              onTap: (){},
                text: Strings.viewDetailsButton),

          ],
        ),
      )
    );
  }
}
