import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
class CompareScreen extends StatelessWidget {
  const CompareScreen({Key? key}) : super(key: key);

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
  
  Widget TextWidget(BuildContext context, String title,String subTitle)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2,),
        Text(subTitle,style: Theme.of(context).textTheme.caption,)
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        AppBarTitle("compare".toUpperCase(), ""),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        // trailingAction: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10),
        //     child: Icon(
        //       Icons.star_border_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  _listItem(context),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Brand","Apple"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Weight","0.5 kg"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Memory Storage Capacity","64 GB"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Colour","White"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Dimensions","19 × 12 × 8 cm"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Country of Origin","India"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Quality","Excellent"),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(width: 1.0, color: Utility.getColorFromHex(globalOrangeColor)),
                        ),
                        child: Text("VIEW CART",style: TextStyle(
                            color: Colors.black
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
            VerticalDivider(thickness: 5.0,
            color: Utility.getColorFromHex(globalOrangeColor),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   _listItem(context),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Brand","Apple"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Weight","0.5 kg"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Memory Storage Capacity","64 GB"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Colour","White"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Dimensions","19 × 12 × 8 cm"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Country of Origin","India"),
                    SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                    TextWidget(context,"Quality","Excellent"),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(width: 1.0, color: Utility.getColorFromHex(globalOrangeColor)),
                        ),
                        child: Text("VIEW CART",style: TextStyle(
                          color: Colors.black
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
