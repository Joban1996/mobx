import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/common_widgets/orders/item_info_common.dart';
import 'package:mobx/model/product/getOrdersModel.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../utils/app.dart';
class PurchasedScreen extends StatelessWidget {
  const PurchasedScreen({Key? key}) : super(key: key);


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
      Navigator.pushReplacementNamed(context, Routes.loginScreen);
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
                debugPrint("token >>>>>>>>> ${App.localStorage.getString(PREF_TOKEN)}");
                Navigator.pushNamed(context,Routes.orderDetails,arguments: productItems[index].number.toString());
              },
              child:
              ItemInfoCommon(productName: productItems[index].items![0].productName!,
                status: productItems[index].status.toString(),orderDate: productItems[index].orderDate.toString(),
                grandTotal: productItems[index].total!.grandTotal!.value.toString(),
                number: productItems[index].number.toString(),)
            );
          }
      ): const Center(child: Text("No Data Found.."));})
    );
  }
}
