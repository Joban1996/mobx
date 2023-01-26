import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/filter_view.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_brand_list.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../model/categories_model.dart';
import '../../../model/product_model.dart' as pro;
import '../../../provider/dashboard/dashboard_provider.dart';
import '../../../utils/app.dart';
import '../../../utils/constants/constants_colors.dart';
import '../../../utils/constants/strings.dart';

class ProductListing extends StatelessWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
         AppBarTitle(context.read<DashboardProvider>().getCategoryName,
             context.read<DashboardProvider>().getSubCategoryName),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () {
              context.read<DashboardProvider>().setSubCategoryName(Strings.refurbished_mobiles);
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          // const Icon(
          //   Icons.star_border_outlined,
          //   color: Colors.black,
          // ),
          GestureDetector(
              onTap: (){
                if(App.localStorage.getString(PREF_CART_ID) != null){
                Navigator.pushNamed(
                  context, Routes.shoppingCart);}},
              child: Image.asset("assets/images/lock.png"))
        ],
      ),
      body: Query(
          options: QueryOptions(document: gql(categories), variables: {
            'filters': {
              'ids': {
                'in': [
                  context.read<DashboardProvider>().getInnerPath[0],
                  context.read<DashboardProvider>().getInnerPath[1],
                  context.read<DashboardProvider>().getInnerPath[2]
                ]
              },
              'parent_id': const {
                'in': ['2']
              }
            }
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return globalLoader();

            }
            debugPrint("sub cate inner >>>>>>> ${result.data}");
            var parsed = CategoriesModel.fromJson(result.data!);
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    parsed.categories!.items!.isEmpty ? const Text("No Data Found..") : parsed.categories!.items![0].children!.isEmpty ? Container()
                        : Container(
                      alignment: Alignment.centerLeft,
                      height: getCurrentScreenHeight(context)/7,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              parsed.categories!.items![0].children!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<DashboardProvider>().setInnerSubCateId(parsed.categories!.items![0].children![index].uid!);
                              },
                              child: HorizontalCircleBrandList(
                                  brandImage: parsed.categories!.items![0].children![index].image.toString(),
                                  brandName: parsed
                                      .categories!.items![0].children![index].name!,
                                  colorName: Colors.grey),
                            );
                          }),
                    ),
    Query(
    options: QueryOptions(
    document: gql(products),
    variables:  {
    'filter':{
    'category_uid': {'eq': context.read<DashboardProvider>().getSubCategoryID},
    }
    }
    ),
    builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
    if (result.hasException) {
    return Text(result.exception.toString());
    }

    if (result.isLoading) {
    return globalLoader();
    }
    var subCateProductData = pro.ProductModel.fromJson(result.data!);
    return
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                            gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: getItemWidth(context) / getItemHeight(context) ,
                              crossAxisSpacing: 1,
                              crossAxisCount: 2,
                            ),
                            itemCount: subCateProductData!.products!.items!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridItem(
                                itemWidth: 2,
                                itemHeight: 4.5,
                                skuID: subCateProductData!.products!.items![index].sku!,
                                productData: subCateProductData!.products!.items![index],);
                            }
                            ),
                      ),
                    );})
                  ],
                ),
                GestureDetector(
                    onTap: (){showModalBottomSheet(
                        context: context, builder: (context){
                      return Wrap(
                        children: [
                          FilterView()
                        ],
                      );
                    });},
                    child: Container(
                      alignment: Alignment.center,
                      decoration:  BoxDecoration(
                          border: Border.all(),color: Utility.getColorFromHex(globalWhiteColor)
                         ),
                      height: 50,width: getCurrentScreenWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/filter_icon.png"),
                        horizontalSpacing(widthInDouble: 0.02, context: context),
                         Text("Filter",style: Theme.of(context).textTheme.bodyMedium,),
                      ],
                    ),))
              ],
            );
          }),
    );
  }
}
