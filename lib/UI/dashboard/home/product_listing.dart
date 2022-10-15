import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_brand_list.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_list.dart';
import 'package:mobx/utils/routes.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../provider/dashboard/dashboard_provider.dart';








class ProductListing extends StatelessWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(const AppBarTitle("Refurbished Apple iPhone 12 Mini",
          "Apple  > iPhone 12 Mini > Detail"),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png"))
        ,trailingAction: [const Icon(Icons.star_border_outlined,color: Colors.black,),
          Image.asset("assets/images/lock.png")],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Consumer<DashboardProvider>(builder: (_,val,child){
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: val.getProducts?.length,
                    itemBuilder: (context,index){
                      return HorizontalCircleBrandList(
                          brandImage: 'assets/images/iphone_mini.png',
                          brandName: val.getProducts![index].name!,
                          colorName: Colors.grey
                      );
                    });
              },),
            ),
          ),
          Expanded(
            flex: 4,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4/6,
                      crossAxisSpacing: 1,
                      crossAxisCount: 2,
                    ),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, Routes.productDetail1),
                          child: const GridItem());
                    }
                ),
              )),
        ],
      ),
    );
}

}