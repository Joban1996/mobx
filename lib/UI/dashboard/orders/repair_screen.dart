import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
class RepairScreen extends StatelessWidget {
  const RepairScreen({Key? key}) : super(key: key);

  Widget cartItemView(BuildContext context,String id, String status, String image, String title, String subTitle,String salePrice, String actualPrice)
  {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            // width: getCurrentScreenWidth(context)/4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
            //height: getCurrentScreenHeight(context)/5.5,
            child: Image.asset(image,fit: BoxFit.cover,),),
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(
                    text: "ID:",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.3)
                ),
                TextSpan(
                  text: id,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,height: 1.3),
                ),
              ])),
              RichText(text: TextSpan(children: [
                TextSpan(
                    text: "STATUS:",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.3)
                ),
                TextSpan(
                  text: status,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Utility.getColorFromHex(globalGreenColor)
                  ),
                ),
              ])),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)),
              Text(salePrice,style: Theme.of(context).textTheme.caption,),
              Text('11th Aug 2022 / 09.40AM',style: Theme.of(context).textTheme.caption,),
            ],
          ),
        ),
        dividerCommon(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index)
          {
            return Text('Repair');
              //cartItemView(context,"#123121213","DELIVERED", 'assets/images/iphone_pic.png', 'APPLE', 'Refurbished Apple iPhone 12 Mini White 128 GB ', '₹55,099', '₹70,099');

          }
      ),
    );
  }
}
