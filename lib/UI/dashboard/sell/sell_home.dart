import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/brand_gridView.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

class SellHome extends StatelessWidget {
  SellHome({Key? key}) : super(key: key);
  
  List<Map> brandList=[
    {"image":"assets/images/apple_logo.png","title":"APPLE"},
    {"image":"assets/images/samsung_logo.png","title":"SAMSUNG"},
    {"image":"assets/images/Oppo_logo.png","title":"OPPO"},
    {"image":"assets/images/OnePlus_Logo.png","title":"ONEPLUS"},
    {"image":"assets/images/apple_logo.png","title":"APPLE"},
    {"image":"assets/images/samsung_logo.png","title":"SAMSUNG"},
    {"image":"assets/images/Oppo_logo.png","title":"OPPO"},
    {"image":"assets/images/OnePlus_Logo.png","title":"ONEPLUS"},
    {"image":"assets/images/samsung_logo.png","title":"SAMSUNG"},
    {"image":"assets/images/Oppo_logo.png","title":"OPPO"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          AppBarTitle("BRAND", "Sell Your Phone- Select brand of your phone"),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/back_arrow.png")),
        ),
        body: GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              crossAxisSpacing: 16.0,
              crossAxisCount: 3,
            ),
            padding: EdgeInsets.all(16.0),
            itemCount: brandList.length,
            itemBuilder: (BuildContext context, int index) {
              var model=brandList[index];
              return BrandGridView(brandImage: model['image'], brandName: model['title'],
                callback: () {
                  Navigator.pushNamed(context, Routes.brandModelScreen);
              },);
            }
        ),
    );
  }
}
