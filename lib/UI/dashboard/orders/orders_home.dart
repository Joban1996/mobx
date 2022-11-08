import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/orders/insuranceOrderScreen.dart';
import 'package:mobx/UI/dashboard/orders/purchased_screen.dart';
import 'package:mobx/UI/dashboard/orders/repair_screen.dart';
import 'package:mobx/UI/dashboard/orders/sell_screen.dart';
import 'package:mobx/UI/dashboard/repair/repair_home.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';

import '../../../utils/utilities.dart';

class OrdersHome extends StatelessWidget {
  const OrdersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(Strings.myOrderAppTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.w600)),
            elevation: 0,
            backgroundColor: Utility.getColorFromHex(globalWhiteColor).withOpacity(0.8),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: Theme.of(context).tabBarTheme.labelStyle,
              unselectedLabelStyle:
              Theme.of(context).tabBarTheme.unselectedLabelStyle,
              labelColor: Utility.getColorFromHex(globalOrangeColor),
              unselectedLabelColor: Utility.getColorFromHex(globalSubTextGreyColor),
              indicatorColor: Utility.getColorFromHex(globalOrangeColor),

              tabs: [
                Tab(text: 'Purchased'.toUpperCase(),
                ),
                Tab(text: 'Sell'.toUpperCase(),),
                Tab(text: 'Repair'.toUpperCase(),),
                Tab(text: 'Insurance'.toUpperCase(),)
              ],
            ),
          ),
          body: const TabBarView(
              children: [
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


