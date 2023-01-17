import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/dashboard/grid_Item.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../model/product_model.dart' as pro;
import '../../../utils/utilities.dart';


class TodayDeals extends StatelessWidget {
  const TodayDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("Today Deals", ""),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () {
             // context.read<DashboardProvider>().setSubCategoryName(Strings.refurbished_mobiles);
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body: Query(
          options: QueryOptions(
              document: gql(products),
              variables: const {
                'filter': {
                  'category_id': {'eq': "87"},
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
            var parsedProductData =
            pro.ProductModel.fromJson(result.data!);
            return parsedProductData.products!.items!.isEmpty
                ? SizedBox(
              height:
              getCurrentScreenHeight(context) / 2.5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GridItem(
                      skuID: "",
                    );
                  }),
            )
                : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 4,
                        crossAxisSpacing: 1,
                        crossAxisCount: 2,
                      ),
                      itemCount: parsedProductData!.products!.items!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GridItem(
                          skuID: parsedProductData!.products!.items![index].sku!,
                          productData: parsedProductData!.products!.items![index],);
                      }
                  ),
                );
          }),
    );
  }
}
