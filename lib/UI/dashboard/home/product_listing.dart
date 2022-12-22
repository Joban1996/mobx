import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          // const Icon(
          //   Icons.star_border_outlined,
          //   color: Colors.black,
          // ),
          GestureDetector(
              onTap: (){Navigator.pushNamed(
                  context, Routes.shoppingCart);},
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
            return Column(
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
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4 / 6,
                          crossAxisSpacing: 1,
                          crossAxisCount: 2,
                        ),
                        itemCount: subCateProductData!.products!.items!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GridItem(
                            skuID: subCateProductData!.products!.items![index].sku!,
                            productData: subCateProductData!.products!.items![index],);
                        }
                        ),
                  ),
                );})
              ],
            );
          }),
    );
  }
}
