import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/UI/dashboard/home/today_deals.dart';
import 'package:mobx/model/home_banner_model.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/dashboard/grid_Item.dart';
import 'dart:math' as math;
import '../../../model/categories_model.dart';
import '../../../model/product_model.dart' as pro;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(
    initialPage: 0,
  );

  late Timer _timer;
  int currentPage = 0;

  List urls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (currentPage! < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _controller.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    hitQueries();
  }

  hitQueries()async{
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await  Provider.of<WishlistProvider>(context, listen: false)
          .hitGetUserDetails().then((value) {
        if (App.localStorage.getString(PREF_CART_ID) == null) {
          Provider.of<ProductProvider>(context, listen: false).hitCreateCartID();
        }
      });
    });
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }



  Widget _exploreItem(BuildContext context, String txt,
      List<Children> parsedData, String path, String cateId, String? img) {
    return GestureDetector(
        onTap: () {
          List<String> split = path.split("/");
          context.read<DashboardProvider>().setSubCate(parsedData);
          context.read<DashboardProvider>().setCateName(txt);
          context.read<DashboardProvider>().setCategoryID(cateId);
          context.read<DashboardProvider>().setPath(split);
          Navigator.pushNamed(context, Routes.productListWithDeals);
        },
        child: img != "null"
            ? Container(
                margin: EdgeInsets.all(2),
                height: getCurrentScreenHeight(context) * 0.1,
                width: getCurrentScreenWidth(context) * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(img.toString()),
                        fit: BoxFit.cover)),
              )
            : Container(
                margin: EdgeInsets.all(2),
                height: getCurrentScreenHeight(context) * 0.1,
                width: getCurrentScreenWidth(context) * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Utility.getColorFromHex(globalGreyColor)),
              )
        /*Container(
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
                child: img != "null" ? Image.network(img.toString()) : Image.asset("assets/images/iphone_mini.png"))
          ],
        ),
      ),*/
        );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(categories), variables: const {
          'filters': {
            'parent_id': {
              'in': ['1']
            }
          }
        }),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return globalLoader();
          }
          var parsedData = CategoriesModel.fromJson(result.data!);
          return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Query(
                          options: QueryOptions(
                              document: gql(homePageBanner),
                              variables: const {
                                "identifiers": "homepage-app-banner"
                              }),
                          builder: (QueryResult result1,
                              {VoidCallback? refetch, FetchMore? fetchMore}) {
                            if (result1.hasException) {
                              return Text(result.exception.toString());
                            }

                            if (result1.isLoading) {
                              return globalLoader();
                            }
                            var homeBannerData =
                                HomeBannerModel.fromJson(result1.data!);
                            debugPrint(
                                "home page banner result >>>> ${result1.data}");
                            getIndex(
                                homeBannerData.cmsBlocks!.items![0].content);
                            debugPrint("home page banner result >>>> $urls");
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              height: getCurrentScreenHeight(context) / 3.5,
                              child: PageView(
                                onPageChanged: (val) {
                                  context
                                      .read<DashboardProvider>()
                                      .setCurrentPage(val);
                                },
                                controller: _controller,
                                children: urls
                                    .map((e) => Card(
                                        elevation: 5, child: Image.network(e)))
                                    .toList()
                                /*Card(
                  elevation: 5,
                    child:urls.isNotEmpty? Image.network(urls[0]) : Image.network('https://media.mobex.in/media/wysiwyg/slide-1-sample.jpeg')),
                Card(
                    elevation: 5,
                    child: urls.isNotEmpty? Image.network(urls[1]) :
                    Image.network('https://media.mobex.in/media/wysiwyg/slide-2-sample.jpeg')),*/
                                /*Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png"),
                Image.asset("assets/images/slider.png")*/
                                ,
                              ),
                            );
                          }),
                      Align(
                        alignment: Alignment.center,
                        child: Consumer<DashboardProvider>(
                            builder: (_, val, child) {
                          return DotsIndicator(
                            decorator: DotsDecorator(
                                activeColor:
                                    Utility.getColorFromHex(globalOrangeColor)),
                            dotsCount: urls.isNotEmpty
                                ? urls.length
                                : 2, //dot count not show first time login
                            position: val.getCurrentPage.toDouble(),
                          );
                        }),
                      ),
                      verticalSpacing(heightInDouble: 0.01, context: context),
                      Text(
                        "EXPLORE",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      verticalSpacing(heightInDouble: 0.01, context: context),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                          children: parsedData.categories!.items!
                              .map((element) => _exploreItem(
                                  context,
                                  element.name.toString(),
                                  element.children!,
                                  element.path!,
                                  element.uid!,
                                  element.image.toString()))
                              .toList(),
                        ),
                      ),
                      verticalSpacing(heightInDouble: 0.02, context: context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TODAY DEALS",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.todayDeals);
                            },
                            child: Text(
                              "VIEW MORE",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color:Colors.lightBlue),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(heightInDouble: 0.01, context: context),
                      Query(
                          options: QueryOptions(
                              document: gql(products),
                              variables: const {
                                'filter': {
                                  'category_id': {'eq': "87"},
                                }
                              }),
                          builder: (QueryResult result,
                              {VoidCallback? refetch, FetchMore? fetchMore}) {
                            if (result.hasException) {
                              return Text(result.exception.toString());
                            }

                            if (result.isLoading) {
                              return globalLoader();
                            }
                            var parsedProductData =
                                pro.ProductModel.fromJson(result.data!);
                            return parsedData
                                    .categories!.items![0].children!.isEmpty
                                ? SizedBox(
                                    height:
                                        getCurrentScreenHeight(context) / 2.5,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return GridItem(
                                            itemWidth: 3,
                                            itemHeight: 4,
                                            skuID: "",
                                          );
                                        }),
                                  )
                                : SizedBox(
                                    height:
                                        getCurrentScreenHeight(context) / 2.5,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: parsedProductData
                                            .products!.items!.length,
                                        itemBuilder: (context, index) {
                                          return GridItem(
                                            itemWidth: 3,
                                            itemHeight: 4,
                                            skuID: parsedProductData!
                                                .products!.items![index].sku!,
                                            productData: parsedProductData!
                                                .products!.items![index],
                                          );
                                        }),
                                  );
                          })
                    ],
                  )));
        });
  }

  void getIndex(htmlData) {
    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%.\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(htmlData);
    urls = urlMatches
        .map((urlMatch) => htmlData.substring(urlMatch.start, urlMatch.end))
        .toList();
    urls.forEach((x) => print("the value extract is $x"));
  }
}
