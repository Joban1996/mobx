import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

class ProductDetails3 extends StatelessWidget {
  ProductDetails3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("RELATED PRODUCTS",
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.40,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GridItem();
                  })),
          // Row(
          //   children: [
          //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
          //       btnColor: Utility.getColorFromHex("#E0E0E0"),)),
          //     SizedBox(width: getCurrentScreenWidth(context)*0.03,),
          //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
          //       onTap: (){Navigator.pushNamed(context, Routes.shoppingCart);}, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
          //   ],
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
    //   body:
    //   Container(
    //     padding: EdgeInsets.all(10),
    //     color: Colors.white.withOpacity(0.8),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text("RELATED PRODUCTS",style: Theme.of(context).textTheme.bodyText2),
    //         Expanded(child: ListView.builder(
    //           shrinkWrap: true,
    //             scrollDirection: Axis.horizontal,
    //             itemCount: 6,
    //             itemBuilder: (context,index){
    //           return GridItem();
    //         })),
    //         // Row(
    //         //   children: [
    //         //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
    //         //       btnColor: Utility.getColorFromHex("#E0E0E0"),)),
    //         //     SizedBox(width: getCurrentScreenWidth(context)*0.03,),
    //         //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
    //         //       onTap: (){Navigator.pushNamed(context, Routes.shoppingCart);}, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
    //         //   ],
    //         // ),
    //         // SizedBox(height: getCurrentScreenHeight(context)*0.02,),
    //       ],
    //     ),
    //   ),
    // );
  }
}
