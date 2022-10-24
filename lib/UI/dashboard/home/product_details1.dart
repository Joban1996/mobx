import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/UI/dashboard/home/product_details2.dart';
import 'package:mobx/UI/dashboard/home/product_details3.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/model/product_description_model.dart' as pData;
import 'package:mobx/utils/constants/constants_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(AppBarTitle(context.read<DashboardProvider>().getCategoryName,
          "Apple  > iPhone 12 Mini > Detail"),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: (){
              context.read<DashboardProvider>().setCurrentPage(0);
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/back_arrow.png"))
          ,trailingAction: [Icon(Icons.star_border_outlined,color: Colors.black,),
          Image.asset("assets/images/lock.png")],
      ),
      body:
      Query(
        options: QueryOptions(
        document: gql(productDescription),
    variables:   {
    'filter':{
      'sku': {'eq': context.read<DashboardProvider>().getSkuID}
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
    var parsed = pData.ProductDescriptionModel.fromJson(result.data!);
    var dataItem = parsed.products!.items![0];
    return
      Container(
        padding: EdgeInsets.all(10),
        color: Colors.white.withOpacity(0.8),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.30,
                  child:
                  dataItem.mediaGallery!.isNotEmpty ? PageView(
                    onPageChanged: (val){
                      context.read<DashboardProvider>().setCurrentPage(val);
                    },
                      controller: _controller,
                      children: [
                       Image.network(dataItem.mediaGallery![0].url.toString()),
                        Image.network(dataItem.mediaGallery![0].url.toString()),
                        Image.network(dataItem.mediaGallery![0].url.toString()),
                      ],
                  ): Image.asset("assets/images/iphone_pic.png"),
                ),
                  Padding(
                     padding: EdgeInsets.only(top: getCurrentScreenHeight(context)*0.04,
                         bottom: getCurrentScreenHeight(context)*0.02),
                     child: dataItem.mediaGallery!.isNotEmpty ? Align(
                       alignment: Alignment.center,
                       child: Consumer<DashboardProvider>(builder: (_,val,child){
                         return DotsIndicator(
                           decorator: DotsDecorator(activeColor: Utility.getColorFromHex(globalOrangeColor)),
                           dotsCount: 3,
                           position: val.getCurrentPage.toDouble(),
                         );
                       }),
                     ): Container(),
                   ),
                Text(dataItem.name??"Refurbished Apple iPhone 12 Mini White 128 GB ",style: Theme.of(context).textTheme.bodyText2,),
                SizedBox(height: getCurrentScreenHeight(context)*0.01,),
                Row(
                  children: [
                    Text(dataItem.priceRange!.minimumPrice!.finalPrice!.value.toString(),style: Theme.of(context).textTheme.bodyText2,),
                    SizedBox(width: 3,),
                    Text(dataItem.priceRange!.minimumPrice!.regularPrice!.value.toString(),style: Theme.of(context).textTheme.caption!.copyWith(decoration: TextDecoration.lineThrough,),)
                    ,SizedBox(width: 3,),
                    Text("You Save ₹15,801 (20% OFF)",style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,color: Utility.getColorFromHex(globalGreenColor)
                    ),)
                  ],
                ),
                SizedBox(height: getCurrentScreenHeight(context)*0.01,),
                Text("Inclusive of all taxes",style: Theme.of(context).textTheme.bodySmall,),
                SizedBox(height: getCurrentScreenHeight(context)*0.01,),
                Text("65+ Quality Checks",style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 3,),
                Text("1 Year Warranty",style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 3,),
                Text("Easy EMI Options Available",style: Theme.of(context).textTheme.bodySmall),
                Divider(height: getCurrentScreenHeight(context)*0.03,),
                Text("EMI OPTION",style: Theme.of(context).textTheme.bodyText2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Text("3 interest-free payments of ₹ 15500 with",style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: getCurrentScreenHeight(context)*0.01,),
                  Image.asset("assets/images/zest_brand.png"),
                  Expanded(child: Icon(Icons.arrow_forward_ios_rounded,color:
                    Utility.getColorFromHex(globalSubTextGreyColor),))
                ],),
                Divider(height: getCurrentScreenHeight(context)*0.03,),
                // Text("SPECIFICATIONS",style: Theme.of(context).textTheme.bodyText2),
                // SizedBox(height: getCurrentScreenHeight(context)*0.02,),
                ProductDetails2(),
                ProductDetails3(),
                SizedBox(height: getCurrentScreenHeight(context)*0.05,),
                // Row(
                //   children: [
                //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
                //       btnColor: Utility.getColorFromHex("#E0E0E0"),)),
                //     SizedBox(width: getCurrentScreenWidth(context)*0.03,),
                //     Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
                //         onTap: (){
                //           Navigator.pushNamed(context, Routes.productDetail2);
                //         }, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
                //   ],
                // ),
                //SizedBox(height: getCurrentScreenHeight(context)*0.02,),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child:
                  AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
                    btnColor: Utility.getColorFromHex("#E0E0E0"),)),
                  SizedBox(width: getCurrentScreenWidth(context)*0.03,),
                  Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
                    onTap: (){
                      Navigator.pushNamed(context, Routes.shoppingCart);
                    }, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
                ],
              ),
            ),
          ],
        ),
      );})
      // floatingActionButton:  Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Expanded(child:
      //       AppButtonLeading(leadingImage: "assets/images/lock.png", onTap: (){}, text: "ADD TO CART",
      //         btnColor: Utility.getColorFromHex("#E0E0E0"),)),
      //       SizedBox(width: getCurrentScreenWidth(context)*0.03,),
      //       Expanded(child: AppButtonLeading(leadingImage: "assets/images/buy_now.png",
      //         onTap: (){
      //           Navigator.pushNamed(context, Routes.shoppingCart);
      //         }, text: "BUY NOW",btnTxtColor: Utility.getColorFromHex(globalWhiteColor),)),
      //     ],
      //   ),
      // ),
    );
  }
}
