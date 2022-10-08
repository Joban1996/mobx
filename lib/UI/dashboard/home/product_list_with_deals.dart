import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/grid_Item.dart';
import 'package:mobx/common_widgets/dashboard/horizontal_circle_brand_list.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';

import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../utils/routes.dart';
import '../../../utils/utilities.dart';

class ProductListWithDeals extends StatefulWidget {
  const ProductListWithDeals({Key? key}) : super(key: key);

  @override
  State<ProductListWithDeals> createState() => _ProductListWithDealsState();
}

class _ProductListWithDealsState extends State<ProductListWithDeals> {
  List<Map> todaysDealList = [
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'Refurbished Apple iPhone 12 128 GB',
      'price': '₹55,099',
      'actual_price': '₹70,099'
    },
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'Refurbished Apple iPhone 12 128 GB',
      'price': '₹55,099',
      'actual_price': '₹70,099'
    },
    {
      'image': 'assets/images/iphone_pic.png',
      'title': 'Refurbished Apple iPhone 12 128 GB',
      'price': '₹55,099',
      'actual_price': '₹70,099'
    }
  ];

  final PageController _pageController = PageController(
    initialPage: 0,
    //keepPage: true,
    viewportFraction: 0.7,
  );

  int _activePage = 0; // will hold current active page index value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        AppBarTitle(Strings.refurbished_mobiles,
            Strings.refurbished_mobiles_subTagLine),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        trailingAction: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          Image.asset("assets/images/lock.png")
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            //padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.productListing);
                    },
                    child: HorizontalCircleBrandList(
                        brandImage: 'assets/images/iphone_mini.png',
                        brandName: 'apple',
                        colorName: Colors.grey),
                  );
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width.toDouble(),
            color: Utility.getColorFromHex(globalGreyBackgroundColor),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(Strings.today_deal),
          ),
          Container(
            color: Utility.getColorFromHex(globalGreyBackgroundColor),
            height: MediaQuery.of(context).size.height * 0.35,
            child: PageView.builder(
                controller: _pageController,
                padEnds: false,
                onPageChanged: (int index) {
                  setState(() {
                    _activePage = index;
                  });
                },
                //reverse: true,
                //physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: todaysDealList.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: getCurrentScreenWidth(context) / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Utility.getColorFromHex(
                                          globalGreyColor))),
                              height: getCurrentScreenHeight(context) / 4,
                              child:
                                  Image.asset(todaysDealList[index]['image']),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                decoration: BoxDecoration(
                                    color: Utility.getColorFromHex(
                                        globalGreenColor),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Text(
                                  "40% OFF",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 8, color: Colors.white),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            width: getCurrentScreenWidth(context) / 2,
                            child: Text(
                              todaysDealList[index]['title'],
                              style: Theme.of(context).textTheme.caption,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              todaysDealList[index]['price'],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              todaysDealList[index]['actual_price'],
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(    //Dot Indicator
            width: MediaQuery.of(context).size.width.toDouble(),
            color: Utility.getColorFromHex(globalGreyBackgroundColor),
            padding: EdgeInsets.only(
              // left: MediaQuery.of(context).size.width*0.02,
              // right: MediaQuery.of(context).size.width*0.02,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      todaysDealList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 5,
                                // check if a dot is connected to the current page
                                // if true, give it a different color
                                backgroundColor: _activePage == index
                                    ? Utility.getColorFromHex(globalOrangeColor)
                                    : Utility.getColorFromHex(globalGreyColor),
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width*0.02,
               right: MediaQuery.of(context).size.width*0.02,
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(Strings.all_phones),
          ),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4/6,
                  crossAxisSpacing: 1,
                  crossAxisCount: 2,
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.productDetail1),
                      child: GridItem());
                }
            ),
          ),
        ],
      ),
    );
  }
}
