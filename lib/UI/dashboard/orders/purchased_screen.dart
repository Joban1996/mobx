import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/model/product/getOrdersModel.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../utils/app.dart';
class PurchasedScreen extends StatelessWidget {
  const PurchasedScreen({Key? key}) : super(key: key);

  Widget cartItemView(BuildContext context,String id, String status, String image, String title,
      String subTitle,String salePrice, String date)
  {
    List<String> splitAndTime = date.split(' ');
    List<String> splitDate = splitAndTime[0].split("-");
    List<String> splitTime = splitAndTime[1].split(":");
    return Column(
      children: [
        ListTile(
          title:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 6 , 0, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(text: TextSpan(children: [
                  TextSpan(
                      text: "ID: ",
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.2)
                  ),
                  TextSpan(
                    text: id,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,height: 1.2),
                  ),
                ])),
                RichText(text: TextSpan(children: [
                  TextSpan(
                      text: "STATUS: ",
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.2)
                  ),
                  TextSpan(
                    text: status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Utility.getColorFromHex(globalGreenColor)
                    ),
                  ),
                ])),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)),
              const SizedBox(height: 5,),
              Text(salePrice,style: Theme.of(context).textTheme.bodySmall,),
              Text("${splitDate[2]}th ${getMonthName(splitDate[1])} ${splitDate[0]} / ${splitTime[0]} : ${splitTime[1]} ",style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
        dividerCommon(context),
      ],
    );
  }

  String getMonthName(String value){
    switch(int.parse(value)){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Des";
      default:
        return "NA";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Query(
        options:
        QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(getOrders),),
    builder: (QueryResult result,
    {VoidCallback? refetch, FetchMore? fetchMore}) {
    debugPrint("cart exception >>> ${result.exception}");
    if (result.hasException) {
    return Text(result.exception.toString());
    }
    if (result.isLoading) {
    return globalLoader();
    }
    var parsed = GetOrdersModel.fromJson(result.data!);
    var productItems = parsed.customer!.orders!.items!;
     debugPrint("get orders data >>> ${result.data!}");
    debugPrint("get orders data >>> ${App.localStorage.getString(PREF_TOKEN)}");
    return
      productItems.isNotEmpty ? ListView.builder(
        itemCount: productItems.length,
          itemBuilder: (context,index)
          {
            return
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context,Routes.orderDetails,arguments: productItems[index].number);
              },
              child: cartItemView(context,productItems[index].number??"#123121213",productItems[index].status??"DELIVERED",
                  'assets/images/iphone_pic.png', 'APPLE',
                  productItems[index].items![0].productName??'Refurbished Apple iPhone 12 Mini White 128 GB ',
                  productItems[index].total!.grandTotal!.value.toString(), productItems[index].orderDate??'11th Aug 2022 / 09.40AM'),
            );
          }
      ): const Center(child: Text("No Data Found.."));})
    );
  }
}
