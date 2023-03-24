import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_brand_list.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
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
   ProductListing({Key? key}) : super(key: key);

   VoidCallback? reFetchData;

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
              context.read<ProductProvider>().setFilterAttributes({});
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.filterScreen).then((value) {
                  if(value == true){
                    reFetchData!.call();
                  }
                });
              },
              child: Image.asset("assets/images/filter_icon.png")),
          GestureDetector(
              onTap: (){
                if(App.localStorage.getString(PREF_CART_ID) != null){
                Navigator.pushNamed(
                  context, Routes.shoppingCart);}},
              child: Image.asset("assets/images/lock.png"))
        ],
      ),
      body: Query(
          options: QueryOptions(
              fetchPolicy: FetchPolicy.noCache,
              document: gql(categories), variables: {
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
            reFetchData = refetch;
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView(
                    children: [
                      parsed.categories!.items!.isEmpty ? const Text("No Data Found..") : parsed.categories!.items![0].children!.isEmpty ? Container()
                          : Container(
                        // alignment: Alignment.topLeft,
                        // height: MediaQuery.of(context).size.height * 0.16,
                        // padding:EdgeInsets.only(
                        //   left: MediaQuery.of(context).size.width * 0.02,
                        //   right: MediaQuery.of(context).size.width * 0.02,
                        // ),
                        // child: ListView.builder(
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount:
                        //         parsed.categories!.items![0].children!.length,
                        //     itemBuilder: (context, index) {
                        //       return Column(
                        //         children: [
                        //           GestureDetector(
                        //             onTap: () {
                        //               context.read<DashboardProvider>().setInnerSubCateId(parsed.categories!.items![0].children![index].uid!);
                        //             },
                        //             child: HorizontalCircleBrandList(
                        //                 brandImage: parsed.categories!.items![0].children![index].image.toString(),
                        //                 brandName: parsed
                        //                     .categories!.items![0].children![index].name!,
                        //                 colorName: Colors.grey),
                        //           ),
                        //           verticalSpacing(heightInDouble: 0.01, context: context),
                        //         ],
                        //       );
                        //     }),
                      ),
    Query(
    options: QueryOptions(
    fetchPolicy: FetchPolicy.noCache,
    document: gql(products),
    variables:  {
    'filter': context.read<ProductProvider>().getFilterAttributes.isNotEmpty ? context.read<ProductProvider>().getFilterAttributes:{

    'category_uid':  {'eq': context.read<DashboardProvider>().getSubCategoryID},
      // 'price':   {'from': context.read<ProductProvider>().getPriceFrom, 'to' : context.read<ProductProvider>().getPriceTo},
      // 'color':  {'eq': context.read<ProductProvider>().getColorFilter},
      // 'manufacturer':{'eq': context.read<ProductProvider>().getManufacturerFilter},
      // //'os':{'eq': context.read<ProductProvider>().getOsFilter},
      // 'brand':{'eq': context.read<ProductProvider>().getBrandFilter},
      // //'country_of_origin':{'eq': context.read<ProductProvider>().getCountryFilter},
      // 'memory_storage_capacity':{'eq': context.read<ProductProvider>().getStorageCapacityFilter},
    }
    }
    ),
    builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {

    if (result.hasException) {
    return Text(result.exception!.graphqlErrors.toString());
    }

    if (result.isLoading) {
    return globalLoader();
    }
    var subCateProductData = pro.ProductModel.fromJson(result.data!);
    return
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: getItemWidth(context) / getItemHeight(context) ,
                              crossAxisSpacing: 1,
                              crossAxisCount: 2,
                            ),
                            itemCount: subCateProductData.products!.items!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridItem(
                                itemWidth: 2,
                                itemHeight: 4.5,
                                skuID: subCateProductData.products!.items![index].sku!,
                                productData: subCateProductData.products!.items![index],);
                            }
                            ),
                      );})
                    ],
                  ),
                ),
                // GestureDetector(
                //     onTap: (){showModalBottomSheet(
                //         context: context, builder: (context){
                //       return Wrap(
                //         children: [
                //           FilterView()
                //         ],
                //       );
                //     });},
                //     child: Container(
                //       alignment: Alignment.center,
                //       decoration:  BoxDecoration(
                //           border: Border.all(),color: Utility.getColorFromHex(globalWhiteColor)
                //          ),
                //       height: 50,width: getCurrentScreenWidth(context),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset("assets/images/filter_icon.png"),
                //         horizontalSpacing(widthInDouble: 0.02, context: context),
                //          Text("Filter",style: Theme.of(context).textTheme.bodyMedium,),
                //       ],
                //     ),))
              ],
            );
          }),
    );
  }
}
