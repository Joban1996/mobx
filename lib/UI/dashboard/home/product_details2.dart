import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/home/product_details3.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../utils/routes.dart';







class ProductDetails2 extends StatelessWidget {
  ProductDetails2({Key? key}) : super(key: key);

  bool _checkbox = false;

Widget itemColumn(String txt1,String txt2,BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
    children: [
      Text(txt1,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11,height: 3)),
      Text(txt2,style: Theme.of(context).textTheme.caption,)
    ],
  );
}
Widget titleRow(BuildContext context,String txt){
  return Row(
    children: [
      Expanded(child: Text(txt,style: Theme.of(context).textTheme.bodyText2)),
      Visibility(
        visible: txt=="SPECIFICATIONS",
        child: Checkbox(
            value: _checkbox,
            onChanged: (value){
              _checkbox=value!;
              Navigator.pushNamed(context, Routes.compare);
            }
        ),
      ),
      IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_rounded))
    ],
  );
}
  Widget specifications(BuildContext context){
    return Column(
      children: [
        titleRow(context,"SPECIFICATIONS"),
        Row(
          children: [
            Expanded(child: itemColumn("Brand","Apple",context)),
            Expanded(child: itemColumn("Colour","White",context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: itemColumn("Weight","0.5 kg",context)),
            Expanded(child: itemColumn("Dimensions","19 × 12 × 8 cm",context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: itemColumn("Memory Storage Capacity","64 GB",context)),
            Expanded(child: itemColumn("Country of Origin","India",context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: itemColumn("Whats in the box","1 Year Warranty Card, Charger, ‎Handset",context)),
            Expanded(child: itemColumn("Quality","Excellent",context)),
          ],
        )
      ],
    );
  }
  Widget descriptions(BuildContext context,String title){
  return Column(
    children: [
      titleRow(context,title),
      SizedBox(height: getCurrentScreenHeight(context)*0.01,),
      Text("Phone 11 Pro is the 13th generation premium flagship smartphone developed, manufactured, and marketed by the tech giant Apple Inc.",
      style: Theme.of(context).textTheme.caption,)
    ],
  );
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    color: Colors.white.withOpacity(0.8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        specifications(context),
        dividerCommon(context),
        descriptions(context,"PRODUCT DESCRIPTION"),
        dividerCommon(context),
        descriptions(context,"SHIPPING POLICY"),
        dividerCommon(context),
        descriptions(context,"REFUND POLICY"),
        dividerCommon(context),
        descriptions(context,"FAQ"),
        dividerCommon(context),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Row(
        //     children: [
        //       Expanded(child: AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
        //         btnColor: Utility.getColorFromHex("#E0E0E0"),)),
        //       SizedBox(width: getCurrentScreenWidth(context)*0.03,),
        //       Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
        //         onTap: (){Navigator.pushNamed(context, Routes.productDetail3);}, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
        //     ],
        //   ),
        // ),
        // SizedBox(height: getCurrentScreenHeight(context)*0.02,),
      ],
    ),
  );
    // return Scaffold(
    //   appBar: AppBarCommon(AppBarTitle("Refurbished Apple iPhone 12 Mini",
    //       "Apple  > iPhone 12 Mini > Detail"),
    //     appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
    //         onTap: ()=> Navigator.pop(context),
    //         child: Image.asset("assets/images/back_arrow.png"))
    //     ,trailingAction: [Icon(Icons.star_border_outlined,color: Colors.black,),
    //       Image.asset("assets/images/lock.png")],
    //   ),
    //   body: SingleChildScrollView(
    //     child:
    //     Container(
    //               color: Colors.white.withOpacity(0.8),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           specifications(context),
    //           dividerCommon(context),
    //           descriptions(context,"PRODUCT DESCRIPTION"),
    //           dividerCommon(context),
    //           descriptions(context,"SHIPPING POLICY"),
    //           dividerCommon(context),
    //           descriptions(context,"REFUND POLICY"),
    //           dividerCommon(context),
    //           descriptions(context,"FAQ"),
    //           dividerCommon(context),
    //           Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             child: Row(
    //               children: [
    //                 Expanded(child: AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
    //                   btnColor: Utility.getColorFromHex("#E0E0E0"),)),
    //                 SizedBox(width: getCurrentScreenWidth(context)*0.03,),
    //                 Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
    //                     onTap: (){Navigator.pushNamed(context, Routes.productDetail3);}, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: getCurrentScreenHeight(context)*0.02,),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
