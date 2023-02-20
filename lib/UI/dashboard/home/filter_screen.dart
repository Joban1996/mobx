import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/filter_view.dart';
import 'package:provider/provider.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../model/product/filter_data_model.dart';
import '../../../provider/dashboard/dashboard_provider.dart';
import '../../../utils/utilities.dart';
import '../../auth/SignUpScreen.dart';



class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: appBarTitle(context, "FILTER"),
      ), appbar: AppBar(), onTapCallback: (){},leadingImage: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset("assets/images/back_arrow.png"))),
      body:
      Query(
        options: QueryOptions(
        document: gql(getFilterData),
    variables:   {
    'filter': {
    'category_uid': {
    'eq': context.read<DashboardProvider>().getSubCategoryID
    }
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
    debugPrint("filter data >>>> ${result.data}");
    var aggregationList = FilterDataModel.fromJson(result.data!).products!.aggregations;

    return

      FilterView(aggregationList);})
    );
  }
}
