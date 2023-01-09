import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/UI/dashboard/home/product_details2.dart';
import 'package:mobx/UI/dashboard/home/product_details3.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/model/categories_model.dart';
import 'package:mobx/model/product_description_model.dart' as pData;
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../provider/dashboard/dashboard_provider.dart';

class ProductDetails1 extends StatelessWidget {
  ProductDetails1({Key? key}) : super(key: key);

  final _controller = PageController(
    initialPage: 0,
  );

  late pData.Items dataItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          AppBarTitle(context.read<DashboardProvider>().getCategoryName,
              "${context.read<DashboardProvider>().getSubCategoryName}  > Detail"),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () {
                context.read<DashboardProvider>().setCurrentPageDetail(0);
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/back_arrow.png")),
          trailingAction: [
             Consumer2<WishlistProvider,LoginProvider>(
               builder: (BuildContext context, value, value2, Widget? child) {
                 return IconButton(
                   padding: EdgeInsets.zero,
                   constraints: const BoxConstraints(),
                   onPressed: (){
                      value2.setLoadingBool(true);
                        value.addToWishList(id: int.parse(App.localStorage.getString(PREF_WISHLIST_ID)!),
                            sku: dataItem.sku.toString(), quantity: 1).then((dataValue) {
                          value2.setLoadingBool(false);
                        });
                   },
                   icon: const Icon(Icons.star_border_outlined),
                   color: Colors.black,
                 );
               },
             ),
            GestureDetector(
                onTap: (){Navigator.pushNamed(
                    context, Routes.shoppingCart);},
                child: Image.asset("assets/images/lock.png"))
          ],
        ),
        body: Consumer<DashboardProvider>(
          builder: (_,val,child){
           return CommonLoader(
                screenUI: Query(
                    options:
                    QueryOptions(document: gql(productDescription), variables: {
                      'filter': {
                        'sku': {'eq': val.getSkuID}
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
                      var parsed = pData.ProductDescriptionModel.fromJson(result.data!);
                      debugPrint("login token >>>>> ${App.localStorage.getString(PREF_TOKEN)}");
                      if(parsed.products!.items!.isNotEmpty){
                       dataItem = parsed.products!.items![0];
                      }
                      return parsed.products!.items!.isNotEmpty ? Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.white.withOpacity(0.8),
                        child: Stack(
                          children: [
                            ListView(
                              children: [
                                dataItem.mediaGallery!.isNotEmpty
                                    ? SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height * 0.30,
                                    child: Consumer<DashboardProvider>(
                                        builder: (_, value, child) {
                                          return PageView(
                                            onPageChanged: (val) {
                                              value.setCurrentPageDetail(val);
                                            },
                                            controller: _controller,
                                            children: dataItem.mediaGallery!
                                                .map((e) =>
                                                Image.network(e.url.toString()))
                                                .toList(),
                                          );
                                        }))
                                    : Container(),
                                dataItem.mediaGallery!.isNotEmpty
                                    ? Padding(
                                  padding: EdgeInsets.only(
                                      top: getCurrentScreenHeight(context) * 0.04,
                                      bottom:
                                      getCurrentScreenHeight(context) * 0.02),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Consumer<DashboardProvider>(
                                        builder: (_, val, child) {
                                          return DotsIndicator(
                                            decorator: DotsDecorator(
                                                activeColor: Utility.getColorFromHex(
                                                    globalOrangeColor)),
                                            dotsCount: dataItem.mediaGallery!.length,
                                            position:
                                            val.getCurrentPageDetail.toDouble(),
                                          );
                                        }),
                                  ),
                                )
                                    : Container(),
                                Text(
                                  dataItem.name ??
                                      "Refurbished Apple iPhone 12 Mini White 128 GB ",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: getCurrentScreenHeight(context) * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${Strings.rupee_sign}${dataItem.priceRange!.minimumPrice!.finalPrice!.value.toString()}",
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "${Strings.rupee_sign}${dataItem.priceRange!.minimumPrice!.regularPrice!.value.toString()}",
                                      style:
                                      Theme.of(context).textTheme.caption!.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "You Save ₹${dataItem.priceRange!.minimumPrice!.discount!.amountOff} (${dataItem.priceRange!.minimumPrice!.discount!.percentOff}% OFF)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                          fontSize: 14,
                                          color: Utility.getColorFromHex(
                                              globalGreenColor)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: getCurrentScreenHeight(context) * 0.01,
                                ),
                                Text(
                                  "Inclusive of all taxes",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(
                                  height: getCurrentScreenHeight(context) * 0.01,
                                ),
                                HtmlWidget(
                                  '''${dataItem.shortDescription!.html}''',
                                  textStyle: Theme.of(context).textTheme.bodySmall,
                                ),
                                Divider(
                                  height: getCurrentScreenHeight(context) * 0.03,
                                ),
                                Text("EMI OPTION",
                                    style: Theme.of(context).textTheme.bodyText2),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("3 interest-free payments of ₹ 15500 with",
                                        style: Theme.of(context).textTheme.bodySmall),
                                    SizedBox(
                                      height: getCurrentScreenHeight(context) * 0.01,
                                    ),
                                    Image.asset("assets/images/zest_brand.png"),
                                    Expanded(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Utility.getColorFromHex(
                                              globalSubTextGreyColor),
                                        ))
                                  ],
                                ),
                                Divider(
                                  height: getCurrentScreenHeight(context) * 0.03,
                                ),
                                ProductDetails2(dataItem),
                                dividerCommon(context),
                                ProductDetails3(
                                  sku: context.read<DashboardProvider>().getSkuID,
                                ),
                                SizedBox(
                                  height: getCurrentScreenHeight(context) * 0.05,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Consumer3<ProductProvider,LoginProvider,DashboardProvider>(
                                builder: (_,val1,val2,val3,child){
                                  return AppButtonLeading(
                                    leadingImage: "assets/images/lock.png",
                                    onTap: () async{
                                      val2.setLoadingBool(true);
                                      print("cart id >>>> ${App.localStorage.getString(PREF_CART_ID)}");
                                      if(App.localStorage.getString(PREF_CART_ID) == null){
                                        await val1.hitCreateCartID().then((value) {
                                          val2.setLoadingBool(false);
                                          if(value == false){
                                            if(val1.getTokenExpireMsg == "graphql-authorization"){
                                                App.localStorage.clear();
                                                Navigator.pushReplacementNamed(context, Routes.loginScreen);
                                            }
                                          }
                                        });
                                      }
                                      val1.hitAddToCartMutation(cartId: App.localStorage.getString(PREF_CART_ID)!,
                                          skuId: val3.getSkuID).then((value) {
                                        val2.setLoadingBool(false);
                                        if(value){
                                          Navigator.pushNamed(context, Routes.shoppingCart);
                                        }
                                        if(value == false){
                                          if(val1.getTokenExpireMsg == "graphql-authorization"){
                                            App.localStorage.clear();
                                            Navigator.pushReplacementNamed(context, Routes.loginScreen);
                                          }
                                        }
                                      });
                                    },
                                    text: "ADD TO CART",
                                    btnTxtColor: Utility.getColorFromHex(globalWhiteColor),
                                    // btnColor: dataItem.stockStatus == "IN_STOCK"
                                    //     ? Utility.getColorFromHex("#E0E0E0")
                                    //     : Utility.getColorFromHex("#E0E0E0")
                                    //     .withOpacity(0.5),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ): const Center(child: Text("No Data Found.."));
                    }));
          },

        )
        );
  }
}
