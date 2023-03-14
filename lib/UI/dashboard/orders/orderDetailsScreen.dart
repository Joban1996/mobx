import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/common_widgets/orders/item_info_common.dart';
import 'package:mobx/model/product/order_detail_model.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/graphql_operation/customer_queries.dart';
class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({Key? key, required this.number}) : super(key: key);

  final String number;

  Widget detailView(BuildContext context,String title, String subTitle, String subTitle2, String subTitle3)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding: const EdgeInsets.fromLTRB(16,8,16,8),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(title,
                 style: Theme.of(context).textTheme.bodyText2
             ),
             SizedBox(height: 7,),
             Visibility(
               visible: subTitle.isNotEmpty,
               child: Text(subTitle,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
             Visibility(
               visible: subTitle2.isNotEmpty,
               child: Text(subTitle2,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
             Visibility(
               visible: subTitle3.isNotEmpty,
               child: Text(subTitle3,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
           ],
         ),
       ),
        dividerCommon(context),
      ],
    );
  }

  Widget _priceDesRow(
      String title, String value, BuildContext context, var localColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.caption),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Utility.getColorFromHex(localColor)),
        )
      ],
    );
  }

  Widget PriceView(BuildContext context,Items data )
  {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,8,16,8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRICE DETAILS ( ${data.items!.length} Items)",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          _priceDesRow("Sub Total (Excluding Tax)", data.total!.subtotal!.value.toString(), context, globalBlackColor),
          _priceDesRow(data.total!.taxes!.isNotEmpty ? "Taxes (${data.total!.taxes![0].title!})":"Taxes ",
              data.total!.taxes!.isNotEmpty?'${data.total!.taxes![0].amount!.value}':'0', context, globalBlackColor),
          _priceDesRow("Discount", data!.total!.discounts!.isNotEmpty ?
          "₹${data.total!.discounts![0].amount!.value}": "₹0", context, globalGreenColor),
          _priceDesRow("Delivery Fee", data.total!.shippingHandling!.amountIncludingTax!.value.toString(), context, globalBlackColor),
          dividerCommon(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",
                  style: Theme.of(context).textTheme.bodyText2),
              Text(
                "${data.total!.grandTotal!.value}",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          dividerCommon(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        Text(Strings.viewDetailsButton,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600)),
        appbar: AppBar(),
        onTapCallback: () {},
        trailingAction: [
          IconButton(onPressed: ()async{
            String phoneNumber = "tel:+91 7676576765";
            if(await canLaunch(phoneNumber) ){
              launch(phoneNumber);
            }else{
              debugPrint("Not open call app.");
            }
          },
              icon: Icon(Icons.phone_outlined,color: Utility.getColorFromHex(globalGreyColor))
          ),
        ],
        leadingImage: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
      Query(
      options:
      QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getOrderDetail),
      variables: {
        'filter': {
          'number': {'eq': number}
        }
      }
      ),
    builder: (QueryResult result,
    {VoidCallback? refetch, FetchMore? fetchMore}) {
    debugPrint("cart exception >>> ${result.exception}");
    if (result.hasException) {
    return Text(result.exception.toString());
    }
    if (result.isLoading) {
    return globalLoader();
    }
    var parsed = OrderDetailModel.fromJson(result.data!);
    var productItems = parsed.customer!.orders!.items!;
    debugPrint("get orders data >>> ${result.data!}");
    debugPrint("data items >>>> ${productItems[0].items!}");
    List<String> names = [];
    List<String> price = [];
    for(int j = 0;j<productItems[0].items!.length;j++){
      names.add(productItems[0].items![j].productName!);
      price.add(productItems[0].items![j].productSalePrice!.value.toString());
    }
    return
      ListView(
        children: [
          ItemInfoCommon(productName: names,
            status: productItems[0].status.toString(),orderDate: productItems[0].orderDate.toString(),
            grandTotal: price,
            number: productItems[0].number.toString(),),
          detailView(context, "BASIC DETAIL", "${productItems[0].shippingAddress!.firstname!} ${productItems[0].shippingAddress!.lastname!}",
              productItems[0].shippingAddress!.telephone??"- / john@example.com",""),
          detailView(context, "SHIPPING ADDRESS", "${productItems[0].shippingAddress!.street![0]}, ${productItems[0].shippingAddress!.city!}, ${productItems[0].shippingAddress!.postcode!}", "",""),
          detailView(context, "PAYMENT DETAILS", "Payment Mode: ${productItems[0].paymentMethods![0].name} ",
            "",""), //Transaction ID: 923222090909090
          PriceView(context,productItems[0]),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: OutLineButtonWidget(text: "Download Invoice", onTap: (){}),
          // )
        ],
      );})
    );
  }
}
