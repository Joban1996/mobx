import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/model/product/CartListModel.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/item_info_arrow_forward.dart';
import '../../../common_widgets/globally_common/app_button.dart';
import '../../../utils/app.dart';



class ShoppingCart extends StatelessWidget {
   ShoppingCart({Key? key}) : super(key: key);

 late VoidCallback reFresh;
Widget cartItemView(BuildContext context,Items productItems,int index,String cartId){
  //Items productItems = data.cart!.items![index];
  return Padding(
    padding: const EdgeInsets.fromLTRB(10,10,10,5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
         // width: getCurrentScreenWidth(context)/4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
          height: getCurrentScreenHeight(context)/5.5,
          child: productItems.product!.smallImage!.url!= null ? Image.network(productItems.product!.smallImage!.url.toString()) :Image.asset("assets/images/iphone_pic.png"),),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(/*productItems.product!.brand??*/"APPLE",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12,height: 1.3),),
                SizedBox(height: 3,),
                Text(productItems.product!.name??"Refurbished Apple iPhone 12 Mini White 128 GB",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,3,3,3),
                  child: Row(children: [
                    Text("Qty",style: Theme.of(context).textTheme.bodySmall),
                    SizedBox(width: 3,),
                    Text("1",style: Theme.of(context).textTheme.bodyMedium),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],),
                ),
                Row(children: [
                  Text(productItems!.product!.priceRange!.minimumPrice!.finalPrice!.value.toString(),style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(width: 3,),
                  Text(productItems!.product!.priceRange!.minimumPrice!.regularPrice!.value.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough,),)
                ],),
                Text("You Save ₹${productItems.product!.priceRange!.minimumPrice!.discount!.amountOff} "
                    "(${productItems.product!.priceRange!.minimumPrice!.discount!.percentOff}% OFF)",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalGreenColor)),)
              ],
            ),
          ),
        ),
         Consumer2<ProductProvider,LoginProvider>(
           builder: (_,val,val2,child){
             return IconButton(
               constraints: BoxConstraints(),
               padding: EdgeInsets.zero,
               icon: Icon(Icons.close),onPressed: (){
                    val2.setLoadingBool(true);
                    val.hitUpdateCartMutation(cartId: cartId,
                        cartUID: productItems.id.toString(),
                        quantity: 0).then((value) {
                         val2.setLoadingBool(false);
                         reFresh.call();
                    });
             },);
           },
         )
      ],
    ),
  );
}

Widget _priceDesRow(String title,String value,BuildContext context,var localColor){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style: Theme.of(context).textTheme.caption),
      Text(value, style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(localColor) ),)
    ],
  );
}
Widget _column(BuildContext context,CartListModel data){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text("PRICE DETAILS ( ${data.cart!.items!.length} Items)",style: Theme.of(context).textTheme.bodyMedium,),
        verticalSpacing(heightInDouble: 0.01, context: context),
        _priceDesRow("Sub Total", "₹${data.cart!.prices!.subtotalExcludingTax!.value}", context, globalBlackColor),
        _priceDesRow("Discount", data.cart!.prices!.discounts!=null ?
        "₹${data.cart!.prices!.discounts![0].amount!.value}": "₹0", context, globalGreenColor),
        _priceDesRow("Delivery Fee", "₹0", context, globalBlackColor),
        dividerCommon(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount",style: Theme.of(context).textTheme.bodyText2),
            Text("₹${data.cart!.prices!.grandTotal!.value}", style: Theme.of(context).textTheme.bodyText2,)
          ],
        ),
        SizedBox(height: getCurrentScreenHeight(context)*0.03,),
        AppButton(onTap: (){
          Navigator.pushNamed(context, Routes.payment);
        }, text: "PROCEED")
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Consumer<ProductProvider>(
        builder: (_,val,child){
          return  AppBarTitle("SHOPPING CART",
              "2 items added ");
        },
      ),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png"))
        ,trailingAction: const [Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.star_border_outlined,color: Colors.black,),
        ),],
      ),
      body:
      CommonLoader(screenUI: Query(
          options:
          QueryOptions(
              fetchPolicy: FetchPolicy.networkOnly,
              document: gql(cartList), variables: {
            'cart_id': App.localStorage.getString(PREF_CART_ID)!
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            reFresh = refetch!;
            debugPrint("cart exception >>> ${result.exception}");
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return globalLoader();
            }
            var parsed = CartListModel.fromJson(result.data!);
            var productItems = parsed.cart!.items!;
            debugPrint("cart list data >>> ${productItems.length}");
            return
              SingleChildScrollView(
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context,index){return const Divider();},
                          itemCount: productItems.length,
                          itemBuilder: (context,index){
                            return cartItemView(context,productItems[index],index,parsed.cart!.id.toString());
                          }),
                      dividerCommon(context),
                      ItemInfoArrowForward(onTap: (){}, title: "EMI OPTION", description: "3 interest-free payments of ₹ 15500 with"),
                      dividerCommon(context),
                      ItemInfoArrowForward(
                          trailingIcon: parsed.cart!.appliedCoupons!=null ?
                          Consumer2<LoginProvider,ProductProvider>(
                            builder: (_,val,val1,child){
                              return GestureDetector(
                                onTap: () {
                                  val.setLoadingBool(true);
                                  val1.hitRemoveCouponMutation(cartId: App.localStorage.getString(PREF_CART_ID).toString()).then((value) =>{
                                  val.setLoadingBool(false),
                                    reFresh.call()
                                  });
                                },
                                child: Icon(Icons.close ,
                                  color: Utility.getColorFromHex(globalSubTextGreyColor),
                                ),
                              );
                            },
                          ): null,
                          onTap: (){
                              Navigator.pushNamed(context, Routes.coupon).then((value) => {
                                if(value != null){
                                  reFresh.call()
                                }
                              });
                      }, title: "COUPONS", description: parsed.cart!.appliedCoupons!=null ?
                      "Applied coupon: ${parsed.cart!.appliedCoupons![0].code!}" : "Apply coupons"),
                      dividerCommon(context),
                      ItemInfoArrowForward(onTap: (){
                        Navigator.pushNamed(context, Routes.address);
                      }, title: "DELIVERY ADDRESS", description: "John Smith, 2nd 3rd 4th  Floor, Shashwat Business Park,Opp....."),
                      dividerCommon(context),
                      _column(context,parsed)
                    ],
                  ),
                ),
              );}))
    );
  }
}
