import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/orders/insuranceOrderScreen.dart';
import 'package:mobx/UI/dashboard/orders/purchased_screen.dart';
import 'package:mobx/UI/dashboard/orders/repair_screen.dart';
import 'package:mobx/UI/dashboard/orders/sell_screen.dart';
import 'package:mobx/UI/dashboard/repair/repair_home.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:provider/provider.dart';

import '../../../utils/utilities.dart';

class OrdersHome extends StatefulWidget {
  const OrdersHome({Key? key}) : super(key: key);

  @override
  State<OrdersHome> createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome>  with TickerProviderStateMixin{

  List<bool> _isDisabled = [false,true,true,true];

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Purchased'.toUpperCase(),
    ),
    Tab(text: 'Sell'.toUpperCase(),),
    Tab(text: 'Repair'.toUpperCase(),),
    Tab(text: 'Insurance'.toUpperCase(),)
  ];

  late TabController _tabController;

  onTap() {
    if (_isDisabled[_tabController.index]) {
      int index = _tabController.previousIndex;
      setState(() {
        _tabController.index = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(onTap);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0.0,
            elevation: 0,
            backgroundColor: Utility.getColorFromHex(globalWhiteColor).withOpacity(0.8),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelStyle: Theme.of(context).tabBarTheme.labelStyle,
              unselectedLabelStyle:
              Theme.of(context).tabBarTheme.unselectedLabelStyle,
              labelColor: Utility.getColorFromHex(globalOrangeColor),
              unselectedLabelColor: Utility.getColorFromHex(globalSubTextGreyColor),
              indicatorColor: Utility.getColorFromHex(globalOrangeColor),
              tabs:myTabs,
            ),
          ),
          body:  TabBarView(
            controller: _tabController,
              children: const [
                PurchasedScreen(),
                SellScreen(),
                RepairScreen(),
                InsuranceOrderScreen()
          ]
          )
          // Center(
          //   child: OutLineButtonWidget(text: "Oder Details".toUpperCase(), onTap: (){
          //     Navigator.pushNamed(
          //         context, Routes.orderDetails);
          //   }),
          // )
      ),
    );
  }
}


