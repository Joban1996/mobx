import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/grid_Item.dart';
import 'dart:math' as math;
import '../../../model/categories_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(
    initialPage: 0,
  );

  final List<String> _exploreListText  = ["Refurbished Mobiles","Smart Watches","Tablets/iPads","Laptops","Headphones","Earphones"];

  Widget _exploreItem(BuildContext context,String txt,List<Children> parsedData,String path,String cateId){
    return GestureDetector(
      onTap: () {
        List<String> split = path.split("/");
        context.read<DashboardProvider>().setSubCate(parsedData);
        context.read<DashboardProvider>().setCateName(txt);
        context.read<DashboardProvider>().setCategoryID(cateId);
        context.read<DashboardProvider>().setPath(split);
        Navigator.pushNamed(context, Routes.productListWithDeals);},
      child: Container(
        width: getCurrentScreenWidth(context)/2.3,
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
    );
  }

  List<Map> todaysDealList = [
    {
      'image': 'https://media.mobex.in/media/wysiwyg/slide-1-sample.jpeg',
    },
    {
      'image': 'https://media.mobex.in/media/wysiwyg/slide-2-sample.jpeg',
    }
  ];

  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );
  List<String> split = [];
  int _activePage = 0; // will hold current active page index value

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
      return globalLoader();
    }
      var parsedData = CategoriesModel.fromJson(result.data!);
      //debugPrint("categories result >>>> ${parsedData.categories!.items![5].name}");
   return  SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: getCurrentScreenHeight(context)/3.5,
            child: PageView(
              controller: _controller,
              children: [
                Card(
                  elevation: 3,
                    child: Image.network('https://media.mobex.in/media/wysiwyg/slide-1-sample.jpeg')),
                Card(
                    elevation: 3,
                    child: Image.network('https://media.mobex.in/media/wysiwyg/slide-2-sample.jpeg')),
                /*Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png")*/
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: DotsIndicator(
              decorator: DotsDecorator(activeColor: Utility.getColorFromHex(globalOrangeColor)),
              dotsCount: 2,
              position: 0,
            ),
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          Text("EXPLORE",style: Theme.of(context).textTheme.bodyText2,),
          verticalSpacing(heightInDouble: 0.01, context: context),
            Align(
              alignment: Alignment.center,
              child: Wrap(
              children: parsedData.categories!.items!.map((element) =>
                  _exploreItem(context, element.name.toString(),element.children!,element.path!,element.uid!)).toList(),
          ),
            ),

                        verticalSpacing(heightInDouble: 0.01, context: context),
                        Text("TODAY DEALS",style: Theme.of(context).textTheme.bodyText2,),
                        verticalSpacing(heightInDouble: 0.01, context: context),
                        SizedBox(
                          height: getCurrentScreenHeight(context)/2.5,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (context,index)
                              {
                                return  GridItem();
                              }),
                        )
                      ],
                    )));
          } );
  }
}



