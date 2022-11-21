import 'package:flutter/material.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:mobx/model/product_model.dart' as pro;
import 'package:provider/provider.dart';

import '../../utils/routes.dart';





class GridItem extends StatelessWidget {
   GridItem({this.productData,required this.skuID,Key? key}) : super(key: key);

pro.Items? productData;
String skuID;

  Widget _listItem(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: getCurrentScreenWidth(context)/2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
              height: getCurrentScreenHeight(context)/5,
              child: productData != null ? Image.network(productData!.image!.url.toString(),) :
              Image.asset("assets/images/iphone_pic.png"),),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(8,4,8,4),
                  decoration: BoxDecoration(color: Utility.getColorFromHex(globalGreenColor)
                  ,borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                  child: Text(productData != null ? "${productData?.priceRange?.minimumPrice?.discount?.percentOff?.round()}% OFF" :"40% OFF",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 8,color: Colors.white),))
          ],
        ),
        const SizedBox(height: 5,),
          Container(
              width: getCurrentScreenWidth(context)/2,
              child: Text(productData != null ? productData!.name.toString() :
              "Refurbished Apple iPhone 12 128 GB",
                style: Theme.of(context).textTheme.caption,maxLines: 2,overflow: TextOverflow.ellipsis,)),
          const SizedBox(height: 5,),
          Row(children: [
            Text(productData != null ? productData!.priceRange!.minimumPrice!.finalPrice!.value.toString() :"₹55,099",style: Theme.of(context).textTheme.bodyText2,),
            SizedBox(width: 3,),
            Text(productData != null ? "₹${productData!.priceRange!.minimumPrice!.regularPrice!.value}" :"₹70,900",style: Theme.of(context).textTheme.caption!.copyWith(decoration: TextDecoration.lineThrough,),)
          ],)
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: GestureDetector(
            onTap:(){
              context.read<DashboardProvider>().setSkuId(skuID);
              Navigator.pushNamed(
                  context, Routes.productDetail1);
            },
            child: _listItem(context)),
      ),
    );
  }
}
