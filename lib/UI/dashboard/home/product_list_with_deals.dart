





import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_brand_list.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../model/product_model.dart' as pro;
import '../../../utils/routes.dart';
import '../../../utils/utilities.dart';
import 'package:provider/provider.dart';

class ProductListWithDeals extends StatefulWidget {
  const ProductListWithDeals({Key? key}) : super(key: key);

  @override
  State<ProductListWithDeals> createState() => _ProductListWithDealsState();
}

class _ProductListWithDealsState extends State<ProductListWithDeals> {

  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.7,
  );
  List<String> split = [];
  int _activePage = 0; // will hold current active page index value


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBarCommon(
          Consumer<DashboardProvider>(
            builder: (_,val,child){
              return AppBarTitle(val.getCategoryName,
                  val.getSubCategoryName);
            },
          ),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/back_arrow.png")),
          trailingAction: [
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            Image.asset("assets/images/lock.png")
          ],
        ),
        body:
    Consumer<DashboardProvider>(
      builder: (_,val,child){
        return Query(
            options: QueryOptions(
                document: gql(categories),
                variables:  {
                  'filters':{
                    'ids': {'in': [val.getPath[0],
                      val.getPath[1],val.getPath.length>2?val.getPath[2]:""]},
                    'parent_id': const {'in': ['1']}
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
              debugPrint("sub cate >>>>>>> ${result.data}");
              var parsed = CategoriesModel.fromJson(result.data!);
              return
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      parsed.categories!.items![0].children!.isEmpty ? Container()
                          : Container(
                          height: MediaQuery.of(context).size.height * 0.16,
                          padding:EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                          ),
                          //padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child:
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: parsed.categories!.items![0].children!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        List<String> split = parsed.categories!.items![0].children![index].path!.split("/");
                                        val.setInnerPath(split);
                                        val.setSubCategoryName(parsed.categories!.items![0].children![index].name!);
                                        val.setSubCategoryID(parsed.categories!.items![0].children![index].uid!);
                                        print("id for sub cate products >>>> ${parsed.categories!.items![0].children![index].uid}");
                                        Navigator.pushNamed(context, Routes.productListing);
                                      },
                                      child: HorizontalCircleBrandList(
                                          brandImage: parsed.categories!.items![0].children![index].image.toString(),
                                          brandName: parsed.categories!.items![0].children![index].name!,
                                          colorName: Colors.grey),
                                    ),
                                    verticalSpacing(heightInDouble: 0.02, context: context),
                                  ],
                                );
                              })
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width.toDouble(),
                        color: Utility.getColorFromHex(globalGreyBackgroundColor),
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(Strings.today_deal),
                      ),
                      Query(
                          options: QueryOptions(
                              document: gql(products),
                              variables:  const {
                                'filter':{
                                  'category_id': {'eq': "87"},
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
                            debugPrint("products >>>>>>> ${result.data}");
                            var parsedProductData = pro.ProductModel.fromJson(result.data!);
                            return parsedProductData.products!.items!.isEmpty ? SizedBox(
                              height: getCurrentScreenHeight(context)/2.5,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (context,index)
                                  {
                                    return  GridItem(
                                      skuID: "",
                                    );
                                  }),
                            ): SizedBox(
                              height: getCurrentScreenHeight(context)/2.5,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: parsedProductData.products!.items!.length,
                                  itemBuilder: (context,index)
                                  {
                                    return  GridItem(
                                      skuID: parsedProductData!.products!.items![index].sku!,
                                      productData: parsedProductData!.products!.items![index],
                                    );
                                  }),
                            );
                          }),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*0.02,
                          right: MediaQuery.of(context).size.width*0.02,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(Strings.all_phones),
                      ),
                      Query(
                          options: QueryOptions(
                              document: gql(products),
                              variables:  {
                                'filter':{
                                  'category_uid': {'eq': val.getCategoryID},
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
                            debugPrint("products >>>>>>> ${result.data}");
                            var parsedProductData = pro.ProductModel.fromJson(result.data!);
                            return
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 4/5,
                                    crossAxisSpacing: 1,
                                    crossAxisCount: 2,

                                  ),
                                  itemCount: parsedProductData.products!.items!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, Routes.productDetail1),
                                        child: GridItem(
                                          skuID: parsedProductData!.products!.items![index].sku!,
                                          productData: parsedProductData.products!.items![index],));
                                  }
                              );}),
                    ],
                  ),
                );});
      },
    ),
      );
  }
}
