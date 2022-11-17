import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/utils/routes.dart';

import '../../../common_widgets/globally_common/brand_gridView.dart';
class BrandModelScreen extends StatelessWidget {
  BrandModelScreen({Key? key}) : super(key: key);
  List<Map> modelList=[
    {"image":"assets/images/iphone_mini.png","title":"Apple iPhone 12"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("Model", "Select Model of your Phone"),
        appbar: AppBar(),
        onTapCallback: () {

        },
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body:  GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.9,
            crossAxisSpacing: 16.0,
            crossAxisCount: 3,
          ),
          padding: EdgeInsets.all(16.0),
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            return BrandGridView(brandImage: 'assets/images/iphone_mini.png', brandName: 'Apple iPhone 12', callback: () {
              Navigator.pushNamed(context, Routes.deviceInfoScreen);
            },);
          }
      ),
    );
  }
}
