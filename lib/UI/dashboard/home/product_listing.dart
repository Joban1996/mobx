import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_list.dart';
import 'package:mobx/utils/routes.dart';

import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';








class ProductListing extends StatelessWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(AppBarTitle("Refurbished Apple iPhone 12 Mini",
          "Apple  > iPhone 12 Mini > Detail"),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png"))
        ,trailingAction: [Icon(Icons.star_border_outlined,color: Colors.black,),
          Image.asset("assets/images/lock.png")],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context,index){
                return HorizontalCircleList();
              }),
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