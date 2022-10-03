import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/home/home_sc.dart';
import 'package:mobx/UI/dashboard/home/product_listing.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import '../../common_widgets/globally_common/app_bar_common.dart';
import 'package:provider/provider.dart';






class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);


  void _gotoScreen(int index,BuildContext context){
    switch(index){
      case 1:
        Navigator.pushNamed(context, Routes.sellHome);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.repairHome);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.ordersHome);
        break;
      case 4:
        Navigator.pushNamed(context, Routes.profileScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset("assets/images/mobex_logo.png"),
      ),
        appbar: AppBar(), onTapCallback: (){},trailingAction: [Icon(Icons.search,color
            :Utility.getColorFromHex(globalSubTextGreyColor),size: 25,),
          Image.asset("assets/images/lock.png")],),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home_icon.png"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/sell_icon.png"),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/repair_icon.png"),
            label: 'Repair',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/order_icon.png"),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/profile_icon.png",),
            label: 'Profile',
          ),
        ],
        currentIndex: context.watch<DashboardProvider>().selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) => _gotoScreen(index,context),
        unselectedItemColor: Utility.getColorFromHex(globalBlackColor),
        showUnselectedLabels: true,
      ),
      body: HomeScreen(),
    );
  }
}
