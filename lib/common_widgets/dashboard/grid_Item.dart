import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:mobx/model/product_model.dart' as pro;





class GridItem extends StatelessWidget {
   GridItem({this.productData,Key? key}) : super(key: key);

pro.Items? productData;

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
              height: getCurrentScreenHeight(context)/4,
              child: Image.asset("assets/images/iphone_pic.png"),),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(8,4,8,4),
                  decoration: BoxDecoration(color: Utility.getColorFromHex(globalGreenColor)
                  ,borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                  child: Text("40% OFF",style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 8,color: Colors.white),))
          ],
        ),
          SizedBox(height: 5,),
          Container(
              width: getCurrentScreenWidth(context)/2,
              child: Text("Refurbished Apple iPhone 12 128 GB",style: Theme.of(context).textTheme.caption,)),
          SizedBox(height: 5,),
          Row(children: [
            Text("₹55,099",style: Theme.of(context).textTheme.bodyText2,),
            SizedBox(width: 3,),
            Text("₹70,900",style: Theme.of(context).textTheme.caption!.copyWith(decoration: TextDecoration.lineThrough,),)
          ],)
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: _listItem(context),
      ),
    );
  }
}
