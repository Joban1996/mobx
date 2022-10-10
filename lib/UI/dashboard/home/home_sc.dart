import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/grid_Item.dart';

import 'dart:math' as math;

import '../../../model/categories_model.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final _controller = PageController(
    initialPage: 0,
  );

  final List<String> _exploreListText  = ["Refurbished Mobiles","Smart Watches","Tablets/iPads","Laptops","Headphones","Earphones"];

  Widget _exploreItem(BuildContext context,String txt){
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.productListing),
        child: Container(
          margin: const EdgeInsets.only(right: 8,bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1)),
          child: Row(
            children: [
              Expanded(child: Text(txt,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 10),)),
              horizontalSpacing(widthInDouble: 0.01, context: context),
              SizedBox(
                  height: 55,width: 30,
                  child: Image.asset("assets/images/iphone_mini.png"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Query(
        options: QueryOptions(
        document: gql(categories),
        variables: const {
        'filters':{
        'parent_id': {'in': ['1']}
        }
      }
    ),
    builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
    if (result.hasException) {
    return Text(result.exception.toString());
    }

    if (result.isLoading) {
    return const Text('Loading');
    }
    var parsedData = CategoriesModel.fromJson(result.data!);
      debugPrint("categories result >>>> ${parsedData.categories!.items![5].name}");
   return  SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
          color: Colors.white.withOpacity(0.8),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: getCurrentScreenHeight(context)/3.5,
            child: PageView(
              controller: _controller,
              children: [
                Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png")
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: DotsIndicator(
              decorator: DotsDecorator(activeColor: Utility.getColorFromHex(globalOrangeColor)),
              dotsCount: 3,
              position: 0,
            ),
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Text("EXPLORE",style: Theme.of(context).textTheme.bodyText2,),
          verticalSpacing(heightInDouble: 0.01, context: context),
          ListView.builder(
            shrinkWrap: true,
              itemCount:  parsedData.categories!.items!.length,
              itemBuilder: (context,index){
            return _exploreItem(context, parsedData.categories!.items![index].name.toString());
          }),
          // Row(
          //   children: [
          //   _exploreItem(context, _exploreListText[0]),
          //   _exploreItem(context, _exploreListText[1]),
          //   _exploreItem(context, _exploreListText[2]),
          // ],),
          // Row(
          //   children: [
          //     _exploreItem(context, _exploreListText[3]),
          //     _exploreItem(context, _exploreListText[4]),
          //     _exploreItem(context, _exploreListText[5]),
          //   ],),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Text("TODAY DEALS",style: Theme.of(context).textTheme.bodyText2,),
          verticalSpacing(heightInDouble: 0.01, context: context),
          SizedBox(
            height: getCurrentScreenHeight(context)/2.5,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context,index){
                  return GridItem();
                }),
          )
        ],
      )));
    } );
  }
}
