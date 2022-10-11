import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../common_widgets/dashboard/item_info_arrow_forward.dart';
import '../../../common_widgets/globally_common/app_button.dart';



class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

Widget cartItemView(BuildContext context){
  return Padding(
    padding: const EdgeInsets.fromLTRB(10,10,10,5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
         // width: getCurrentScreenWidth(context)/4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
          height: getCurrentScreenHeight(context)/5.5,
          child: Image.asset("assets/images/iphone_pic.png"),),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("APPLE",style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,height: 1.3),),
                SizedBox(height: 3,),
                Text("Refurbished Apple iPhone 12 Mini White 128 GB ",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,3,3,3),
                  child: Row(children: [
                    Text("Qty",style: Theme.of(context).textTheme.caption),
                    SizedBox(width: 3,),
                    Text("1",style: Theme.of(context).textTheme.bodyText2),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],),
                ),
                Row(children: [
                  Text("₹55,099",style: Theme.of(context).textTheme.bodyText2,),
                  SizedBox(width: 3,),
                  Text("₹70,900",style: Theme.of(context).textTheme.caption!.copyWith(decoration: TextDecoration.lineThrough,),)
                ],),
                Text("You Save ₹15,801 (20% OFF)",style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalGreenColor)),)
              ],
            ),
          ),
        ),
        Icon(Icons.close)
      ],
    ),
  );
}

Widget _priceDesRow(String title,String value,BuildContext context,var localColor){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style: Theme.of(context).textTheme.caption),
      Text(value, style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(localColor) ),)
    ],
  );
}
Widget _column(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text("PRICE DETAILS ( 2 Items)",style: Theme.of(context).textTheme.bodyText2,),
        verticalSpacing(heightInDouble: 0.01, context: context),
        _priceDesRow("Sub Total", "₹110,198", context, globalBlackColor),
        _priceDesRow("Discount", "₹-31,602", context, globalGreenColor),
        _priceDesRow("Delivery Fee", "₹100", context, globalBlackColor),
        _priceDesRow("Coupon", "₹0", context, globalBlackColor),
        dividerCommon(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount",style: Theme.of(context).textTheme.bodyText2),
            Text("₹110,298", style: Theme.of(context).textTheme.bodyText2,)
          ],
        ),
        SizedBox(height: getCurrentScreenHeight(context)*0.03,),
        AppButton(onTap: (){
          Navigator.pushNamed(context, Routes.payment);
        }, text: "PLACE ORDER")
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(const AppBarTitle("SHOPPING CART",
          "2 items added "),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png"))
        ,trailingAction: [Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(Icons.star_border_outlined,color: Colors.black,),
        ),],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white.withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index){return const Divider();},
                    itemCount: 2,
                    itemBuilder: (context,index){
                      return cartItemView(context);
                }),
              dividerCommon(context),
              ItemInfoArrowForward(onTap: (){}, title: "EMI OPTION", description: "3 interest-free payments of ₹ 15500 with"),
              dividerCommon(context),
              ItemInfoArrowForward(onTap: (){
                Navigator.pushNamed(context, Routes.coupon);
              }, title: "COUPONS", description: "Apply coupons"),
              dividerCommon(context),
              ItemInfoArrowForward(onTap: (){
                Navigator.pushNamed(context, Routes.address);
              }, title: "DELIVERY ADDRESS", description: "John Smith, 2nd 3rd 4th  Floor, Shashwat Business Park,Opp....."),
              dividerCommon(context),
              _column(context)
            ],
          ),
        ),
      ),
    );
  }
}
