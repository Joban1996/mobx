import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool _isExpandable=false;
  bool _isExpandable1=false;
  bool _isExpandable2=false;
  bool _isExpandable3=false;

  Widget FAQWidget(BuildContext context,String title, VoidCallback onTap, String content,bool isExpandable, )
  {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(title,style: Theme.of(context).textTheme.caption)),
              IconButton(onPressed:onTap,
                icon: isExpandable?const Icon(Icons.keyboard_arrow_up)
                    :const Icon(Icons.keyboard_arrow_down),
              )
            ],
          ),
          Visibility(
            child: Text(content,style: Theme.of(context).textTheme.caption),
            visible: isExpandable,
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle(
            Strings.faqScreenAppTitle, Strings.faqScreenAppsubTitle),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body: ListView(
        //padding: const EdgeInsets.all(8.0),
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,
                  top: MediaQuery.of(context).size.height*0.02,
                  bottom: MediaQuery.of(context).size.height*0.02,
                ),
                child: Text(Strings.faqPurchase,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
             // verticalSpacing(heightInDouble: 0.01, context: context),
              FAQWidget(context, Strings.faqPurchasePhone, () {
                setState(() {
                  _isExpandable=!_isExpandable;
                });
              }, Strings.faqPurchaseContent, _isExpandable),
              FAQWidget(context, Strings.faqPurchaseWarrenty, () {
                setState(() {
                  _isExpandable=!_isExpandable;
                });
              }, '', _isExpandable),
              FAQWidget(context, Strings.faqPurchaseInclude, () {
                setState(() {
                  _isExpandable=!_isExpandable;
                });
              }, '', _isExpandable),
              Divider(thickness: 1.0,
              color: Utility.getColorFromHex(globalGreyColor),
              )
            ],
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,
                  top: MediaQuery.of(context).size.height*0.02,
                  bottom: MediaQuery.of(context).size.height*0.02,
                ),
                child: Text(Strings.faqSell,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              FAQWidget(context, Strings.faqSellCalculate, () {
                setState(() {
                  _isExpandable1=!_isExpandable1;
                });
              }, '', _isExpandable1),
              FAQWidget(context, Strings.faqSellSafe, () {
                setState(() {
                  _isExpandable1=!_isExpandable1;
                });
              }, '', _isExpandable1),
              FAQWidget(context, Strings.faqSellPaid, () {
                setState(() {
                  _isExpandable1=!_isExpandable1;
                });
              }, '', _isExpandable1),
              Divider(thickness: 1.0,
                color: Utility.getColorFromHex(globalGreyColor),
              )
            ],
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,
                  top: MediaQuery.of(context).size.height*0.02,
                  bottom: MediaQuery.of(context).size.height*0.02,
                ),
                child: Text(Strings.faqRepair,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              FAQWidget(context, Strings.faqRepairPickUp, () {
                setState(() {
                  _isExpandable2=!_isExpandable2;
                });
              }, '', _isExpandable2),
              FAQWidget(context, Strings.faqRepairPhone, () {
                setState(() {
                  _isExpandable2=!_isExpandable2;
                });
              }, '', _isExpandable2),
              FAQWidget(context, Strings.faqRepairWarrenty, () {
                setState(() {
                  _isExpandable2=!_isExpandable2;
                });
              }, '', _isExpandable2),
              Divider(thickness: 1.0,
                color: Utility.getColorFromHex(globalGreyColor),
              )
            ],
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,
                  top: MediaQuery.of(context).size.height*0.02,
                  bottom: MediaQuery.of(context).size.height*0.02,
                ),
                child: Text(Strings.faqInsurance,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              FAQWidget(context, Strings.faqInsuranceOldPhone, () {
                setState(() {
                  _isExpandable3=!_isExpandable3;
                });
              }, '', _isExpandable3),
              FAQWidget(context, Strings.faqInsuranceWatches, () {
                setState(() {
                  _isExpandable3=!_isExpandable3;
                });
              }, '', _isExpandable3),
              FAQWidget(context, Strings.faqInsuranceRefurbished, () {
                setState(() {
                  _isExpandable3=!_isExpandable3;
                });
              }, '', _isExpandable3),
              // Divider(thickness: 1.0,
              //   color: Utility.getColorFromHex(globalGreyColor),
              // )
            ],
          )


        ],
      ),
    );
  }
}

