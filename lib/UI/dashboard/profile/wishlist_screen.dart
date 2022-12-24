import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/graphql_operation/customer_queries.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/model/wishlist_profile/wishlist_model.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../provider/auth/login_provider.dart';

class WishListScreeen extends StatelessWidget {
  WishListScreeen({Key? key}) : super(key: key);

  late VoidCallback reFresh;

  Widget cartItemView(BuildContext context,Items productItems,int index){
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
            width: getCurrentScreenWidth(context)/3.0,
            child: productItems.product!.smallImage!.url!= null ? Image.network(productItems.product!.smallImage!.url.toString()) :Image.asset("assets/images/iphone_pic.png"),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(/*productItems.product!.brand??*/"APPLE",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12,height: 1.3),),
                  // SizedBox(height: 3,),
                  Text(productItems.product!.name??"Refurbished Apple iPhone 12 Mini White 128 GB",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
                  // Row(
                  //   children: [
                  //     Text("Qty ",style: Theme.of(context).textTheme.bodySmall),
                  //     Consumer2<ProductProvider,LoginProvider>(
                  //       builder: (_,productProviderValue,loginProviderValue,child){
                  //         return DropdownButtonHideUnderline(
                  //           child: DropdownButton<String>(
                  //             icon: const Icon(Icons.keyboard_arrow_down),
                  //             isDense: true,
                  //             onTap: (){
                  //               productProviderValue.setItemIndex(index);
                  //             },
                  //             value: productItems.quantity.toString(),
                  //             items: quantitySelect.map((String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Text(value,style: Theme.of(context).textTheme.bodyMedium,),
                  //               );
                  //             }).toList(), onChanged: (String? value) {
                  //            /* productProviderValue.getItemIndex == index ? productProviderValue.setDropDownValue(value!): null;
                  //             loginProviderValue.setLoadingBool(true);
                  //             productProviderValue.hitUpdateCartMutation(cartId: cartId,
                  //                 cartUID: productItems.id.toString(),
                  //                 quantity: int.parse(value!)).then((value) {
                  //               loginProviderValue.setLoadingBool(false);
                  //               reFresh.call();
                  //             });*/
                  //           },
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 5,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text("${Strings.rupee_sign}${productItems!.product!.priceRange!.minimumPrice!.finalPrice!.value.toString()}",style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(width: 3,),
                        Text("${Strings.rupee_sign}${productItems!.product!.priceRange!.minimumPrice!.regularPrice!.value.toString()}",style: Theme.of(context).textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough,),)
                      ],),
                      Text("You Save ₹${productItems.product!.priceRange!.minimumPrice!.discount!.amountOff} "
                          "(${productItems.product!.priceRange!.minimumPrice!.discount!.percentOff}% OFF)",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalGreenColor)),)

                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         children: [
                  //           Row(children: [
                  //             Text(productItems!.product!.priceRange!.minimumPrice!.finalPrice!.value.toString(),style: Theme.of(context).textTheme.bodyMedium,),
                  //             SizedBox(width: 3,),
                  //             Text(productItems!.product!.priceRange!.minimumPrice!.regularPrice!.value.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough,),)
                  //           ],),
                  //           Text("You Save ₹${productItems.product!.priceRange!.minimumPrice!.discount!.amountOff} "
                  //               "(${productItems.product!.priceRange!.minimumPrice!.discount!.percentOff}% OFF)",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalGreenColor)),)
                  //
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Consumer2<WishlistProvider,LoginProvider>(
                  //         builder: (_,value,value2,child){
                  //           return OutLineButtonWidget(
                  //               onTap: (){
                  //                 value2.setLoadingBool(true);
                  //                 value.hitAddWishlistToCart(wishlistItemId: productItems.id!,wishListId: int.parse(App.localStorage.getString(PREF_WISHLIST_ID)!)).then((value) {
                  //                   value2.setLoadingBool(false);
                  //                   reFresh.call();
                  //                 });
                  //               },
                  //               text: Strings.addToCart);
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Consumer2<WishlistProvider,LoginProvider>(
                    builder: (_,value,value2,child){
                      return OutLineButtonWidget(
                          onTap: (){
                            value2.setLoadingBool(true);
                            value.hitAddWishlistToCart(wishlistItemId: productItems.id!,wishListId: int.parse(App.localStorage.getString(PREF_WISHLIST_ID)!)).then((value) {
                              value2.setLoadingBool(false);
                              reFresh.call();
                            });
                          },
                          text: Strings.addToCart);
                    },
                  ),
                 ],
              ),
            ),
          ),
          Consumer2<WishlistProvider,LoginProvider>(
            builder: (_,val,val2,child){
              return IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(Icons.close),onPressed: (){
                val2.setLoadingBool(true);
                val.hitDeleteWishlist(wishlistItemId: productItems.id!,wishListId: int.parse(App.localStorage.getString(PREF_WISHLIST_ID)!)).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle(
            "WISHLISTS", "Add to carts items from your Wish Lists"),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body:
      CommonLoader(screenUI: Query(
          options:
          QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(getWishList),),
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
            var parsed = WishListModel.fromJson(result.data!);
            var wishlistItems = parsed.wishlist!.items!;
            debugPrint("get wishlist data >>> ${result.data}");
            return
              wishlistItems.isEmpty ? const Center(child: Text("No Data Found.."),) :  ListView.builder(
                  itemCount: wishlistItems.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    var model=wishlistItems[index];
                    return cartItemView(context,model,index);
                  }
              );}))
    );
  }
}
