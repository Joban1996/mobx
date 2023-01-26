import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/model/cms_page_model.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:html/parser.dart';
import '../../../../api/graphql_operation/customer_queries.dart';
import '../../../../utils/utilities.dart';
import 'package:flutter_html/html_parser.dart';
class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);



  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          const AppBarTitle(
              Strings.termsConditionsTitle, ''),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/back_arrow.png")),
        ),
        body:
        Query(
            options: QueryOptions(
                document: gql(cmsPages),
                variables: const {
                  "identifier": "ecommerce-tnc"
                }),
            builder: (QueryResult result1,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              if (result1.hasException) {
                return Text(result1.exception.toString());
              }

              if (result1.isLoading) {
                return globalLoader();
              }
              var cmsPageData =
              CmsPageModel.fromJson(result1.data!);
              debugPrint(
                  "home page banner result >>>> ${result1.data}");
              return
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*0.02,
                    right: MediaQuery.of(context).size.width*0.02,
                    top: MediaQuery.of(context).size.height*0.02,
                    bottom: MediaQuery.of(context).size.height*0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Text(_parseHtmlString(cmsPageData.cmsPage!.content.toString()),
                        style: Theme.of(context).textTheme.caption
                    ),
                  ),
                );})
    );
  }
}
