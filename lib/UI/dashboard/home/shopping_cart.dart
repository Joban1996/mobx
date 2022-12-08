import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/model/product/CartListModel.dart';
import 'package:mobx/provider/auth/login_provider.dart';
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

   List<String> quantitySelect = ['1', '2', '3', '4','5','6','7','8','9','10'];

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
                Row(
                  children: [
                     Text("Qty ",style: Theme.of(context).textTheme.bodySmall),
                    Consumer2<ProductProvider,LoginProvider>(
                      builder: (_,productProviderValue,loginProviderValue,child){
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isDense: true,
                            onTap: (){
                              productProviderValue.setItemIndex(index);
                            },
                            value: productItems.quantity.toString(),
                            items: quantitySelect.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: Theme.of(context).textTheme.bodyMedium,),
                              );
                            }).toList(), onChanged: (String? value) {
                              productProviderValue.getItemIndex == index ? productProviderValue.setDropDownValue(value!): null;
                              loginProviderValue.setLoadingBool(true);
                              productProviderValue.hitUpdateCartMutation(cartId: cartId,
                                cartUID: productItems.id.toString(),
                                quantity: int.parse(value!)).then((value) {
                              loginProviderValue.setLoadingBool(false);
                              reFresh.call();
                            });
                          },
                          ),
                        );
                      },
                    ),
                  ],
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
            Text("Total Amount",style: Theme.of(context).textTheme.bodyMedium),
            Text("₹${data.cart!.prices!.grandTotal!.value}", style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        SizedBox(height: getCurrentScreenHeight(context)*0.03,),
        AppButton(onTap: (){
            //Navigator.pushNamed(context, Routes.payment);
          Navigator.pushNamed(context, Routes.address);
        }, text: "SELECT ADDRESS")
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Consumer<ProductProvider>(
        builder: (_,val,child){
          return  const AppBarTitle("SHOPPING CART",
              "2 items added ");
        },
      ),
        appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
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
            debugPrint("cart exception get shopping cart >>> $result");
            if (result.hasException) {
              if(result.exception!.graphqlErrors[0].extensions!['category'].toString() == "graphql-authorization"){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                App.localStorage.clear();
                Navigator.pushReplacementNamed(context, Routes.loginScreen);});
              }
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return globalLoader();
            }
            var parsed = CartListModel.fromJson(result.data!);
            var productItems = parsed.cart!.items!;
            debugPrint("cart list data >>> ${parsed.cart!.shippingAddresses}");
            App.localStorage.setString(PREF_USER_EMAIL, parsed.cart!.email.toString());
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
                            return cartItemView(context,productItems[index],index,App.localStorage.getString(PREF_CART_ID).toString());
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
                      // ItemInfoArrowForward(onTap: (){
                      //   Navigator.pushNamed(context, Routes.address).then((value) {
                      //     reFresh.call();
                      //   });
                      // }, title: "DELIVERY ADDRESS", description: parsed.cart!.shippingAddresses!.isNotEmpty
                      //     ? parsed.cart!.shippingAddresses![0].street![0].toString() + parsed.cart!.shippingAddresses![0].city.toString()+parsed.cart!.shippingAddresses![0].region!.label.toString()
                      //     : "Click here to add address"),
                      dividerCommon(context),
                      _column(context,parsed)
                    ],
                  ),
                ),
              );}))
    );
  }
}
