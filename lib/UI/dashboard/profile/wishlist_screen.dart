import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../common_widgets/dashboard/app_bar_title.dart';

class WishListScreeen extends StatelessWidget {
  WishListScreeen({Key? key}) : super(key: key);

  List<Map> wishList = [
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'APPLE',
      'subTitle': 'Refurbished Apple iPhone 13 Mini White 128 GB ',
      'salePrice': '₹52,099',
      'actualPrice': '₹70,099'
    },
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'APPLE',
      'subTitle': 'Refurbished Apple iPhone 12 Mini White 128 GB ',
      'salePrice': '₹55,099',
      'actualPrice': '₹70,099'
    },
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'APPLE',
      'subTitle': 'Refurbished Apple iPhone 12 Mini White 128 GB ',
      'salePrice': '₹55,099',
      'actualPrice': '₹70,099'
    }
  ];

  Widget cartItemView(BuildContext context, String image, String title, String subTitle,String salePrice, String actualPrice)
  {
    return Column(
      children: [
        Padding(
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
                child: Image.asset(image),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,height: 1.3),),
                      SizedBox(height: 3,),
                      Text(subTitle,
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
                        Text(salePrice,style: Theme.of(context).textTheme.bodyText2,),
                        SizedBox(width: 3,),
                        Text(actualPrice,style: Theme.of(context).textTheme.caption!.copyWith(decoration: TextDecoration.lineThrough,),)
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("You Save ₹15,801 (20% OFF)",style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalGreenColor)),)),
                          Expanded(
                            child: OutLineButtonWidget(
                                onTap: (){},
                                text: Strings.addToCart),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Icon(Icons.close)
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle(
            "WISHLISTS", "Add to carts items from your Wish Lists"),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.star_border_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: wishList.length,
          itemBuilder: (BuildContext context, int index)
              {
                var model=wishList[index];
                return cartItemView(context,model['image'],model['title'],model['subTitle'],model['salePrice'],model['actualPrice']);
              }
      ),
    );
  }
}
