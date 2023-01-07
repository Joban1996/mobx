import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../api/graphql_operation/customer_queries.dart';
import '../../utils/app.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/routes.dart';
import '../../utils/utilities.dart';



class QueryWidget extends StatelessWidget {

  final dataQuery;
  final screenUI;
  final dataModel;
  final variables;

  const QueryWidget({Key? key, required this.dataQuery,required this.screenUI, required this.dataModel,this.variables}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options:
          QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(dataQuery)),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            debugPrint("query exception >>> ${result.exception}");
            if (result.hasException) {
              if(result.exception!.graphqlErrors[0].extensions!['category'].toString() == "graphql-authorization"){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  App.localStorage.clear();
                  Navigator.pushReplacementNamed(context, Routes.loginScreen);});
              }
              return Center(child: Text(result.exception!.graphqlErrors[0].message));
            }
            if (result.isLoading) {
              return globalLoader();
            }
            var parsed = dataModel.fromJson(result.data!);
            var productItems = parsed.customer!.orders!.items!;
            debugPrint("get orders data >>> ${result.data!}");
            debugPrint("get orders data >>> ${App.localStorage.getString(PREF_TOKEN)}");
            return
              productItems.isNotEmpty ? screenUI: const Center(child: Text("No Data Found.."));}),
    );
  }
}
