import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mobx/UI/dashboard/home/product_details3.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/model/product_description_model.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../../utils/routes.dart';







class ProductDetails2 extends StatelessWidget {
  late Items dataItem;
  ProductDetails2( this.dataItem,{Key? key}) : super(key: key);

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
Widget titleRow(BuildContext context,String txt,bool val,{required VoidCallback onPressed}){
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
              onPressed: onPressed, icon: val ? Icon(Icons.keyboard_arrow_down_rounded) : Icon(Icons.keyboard_arrow_up_rounded))
    ],
  );
}
  Widget specifications(BuildContext context){
    return Column(
      children: [
        titleRow(context,"SPECIFICATIONS",false,onPressed: (){}),
        Row(
          children: [
            Expanded(child: itemColumn("Brand","${dataItem.modelName}",context)),
            Expanded(child: itemColumn("Colour",dataItem.colour.toString()??"-",context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: itemColumn("Weight",dataItem.itemWeight??"-",context)),
            Expanded(child: itemColumn("Dimensions",dataItem.productDimensions??"-",context)),
          ],
        ),
        Row(
          children: [
            Expanded(child: itemColumn("Memory Storage Capacity","${dataItem.memoryStorageCapacity ?? "-"} GB",context)),
            Expanded(child: itemColumn("Country of Origin",dataItem.countryOfManufacture??"-",context)),
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
  Widget descriptions(BuildContext context,String title,String descData,bool val,VoidCallback onPressed){
  return Column(
    children: [
      titleRow(context,title,val,onPressed: onPressed),
      SizedBox(height: getCurrentScreenHeight(context)*0.01,),
     title == "PRODUCT DESCRIPTION"  ? val ? Container() : HtmlWidget(descData,textStyle: Theme.of(context).textTheme.bodySmall,)  :
     HtmlWidget(descData,textStyle: Theme.of(context).textTheme.bodySmall,)
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
      Consumer<ProductProvider>(
      builder: (_,val,child){
    return descriptions(context,"PRODUCT DESCRIPTION",dataItem.description!.html.toString(),val.getIsExpand,(){
      context.read<ProductProvider>().setIsExpand();
    });}),
        dividerCommon(context),
        descriptions(context,
            "SHIPPING POLICY","Mobex is committed to deliver the best products to its "
                "users for which we perform 65+ quality checks. Thus, your order will b"
                "e delivered in 5-7 working days.",false,(){}),                                 //Shipping data
        dividerCommon(context),
        descriptions(context,"REFUND POLICY","We have 100% refund policy If you change your"
            " mind before the order is dispatched from our warehouse. Once the order is dispatched an"
            "d delivered to the customer then we have the Repair",false,(){}),                                   //refund policy data
        dividerCommon(context),
        descriptions(context,"FAQ","What are Refurbished Products? Refurbished products are devices "
            "restored to full working condition, as new, as they were either pre-owned or used as display models"
            " by the company or retailers.",false,(){}),
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
