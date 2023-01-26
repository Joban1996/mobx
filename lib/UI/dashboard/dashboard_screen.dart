import 'package:flutter/material.dart';
import 'package:mobx/UI/dashboard/home/home_sc.dart';
import 'package:mobx/UI/dashboard/orders/orders_home.dart';
import 'package:mobx/UI/dashboard/orders/repair_screen.dart';
import 'package:mobx/UI/dashboard/profile/profile_screen.dart';
import 'package:mobx/UI/dashboard/repair/repair_home.dart';
import 'package:mobx/UI/dashboard/sell/sell_home.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import '../../common_widgets/dashboard/app_bar_title.dart';
import '../../common_widgets/globally_common/app_bar_common.dart';
import 'package:provider/provider.dart';

import '../../provider/dashboard/product_provider.dart';
import '../../provider/wishlist_profile/wishlist_provider.dart';
import '../../utils/app.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   hitQueries();
  }

  hitQueries(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await  Provider.of<WishlistProvider>(context, listen: false)
          .hitGetUserDetails().then((value) {
        if (App.localStorage.getString(PREF_CART_ID) == null) {
          Provider.of<ProductProvider>(context, listen: false).hitCreateCartID();
        }
      });
    });
  }

  Widget _gotoScreen(int index,BuildContext context){
    switch(index){
      case 0:
        return HomeScreen();
      case 1:
       return SellHome();
      case 2:
        return const RepairHome();
      case 3:
        return const OrdersHome();
      case 4:
       return const ProfileScreen();
      default:
        return Container();

    }
  }

  _appBar(int index,BuildContext context){
    switch(index){
      case 0:
        return AppBarCommon(Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/images/mobex_logo.png"),
        ),
          appbar: AppBar(), onTapCallback: (){},trailingAction:
          [IconButton(onPressed: (){
            Navigator.pushNamed(context, Routes.searchScreen);
          }, icon: Icon(Icons.search,color
              :Utility.getColorFromHex(globalSubTextGreyColor),size: 25,)),
            GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context, Routes.shoppingCart);
                },
                child: Image.asset("assets/images/lock.png"))],);
      case 1:
        return AppBarCommon(const AppBarTitle("BRAND", "Sell Your Phone- Select brand of your phone"),
          appbar: AppBar(), onTapCallback: (){},);
      case 2:
        return AppBarCommon(const AppBarTitle("BRAND", "Repair Your Phone- Select brand of your phone"),
          appbar: AppBar(), onTapCallback: (){});
      case 3:
        return AppBarCommon(Text("MY ORDERS",style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600)),
          appbar: AppBar(), onTapCallback: (){},);
      case 4:
        return AppBarCommon(Text("PROFILE",style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600)),
          appbar: AppBar(), onTapCallback: (){},);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context.watch<DashboardProvider>().getSelectedTabIndex,context),
      bottomNavigationBar: Consumer<DashboardProvider>(
        builder: (_,val,child){
          return BottomNavigationBar(
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/home_icon.png",height: 24.0,width: 24.0,color: val.getSelectedTabIndex == 0 ?Colors.amber[800] : Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/sell_icon.png",height: 24.0,width: 24.0,color:val.getSelectedTabIndex == 1 ?Colors.amber[800] : Colors.black),
                label: 'Sell',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/repair_icon.png",height: 24.0,width: 24.0,color:val.getSelectedTabIndex == 2 ?Colors.amber[800] : Colors.black),
                label: 'Repair',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/order_icon.png",height: 24.0,width: 24.0,color:val.getSelectedTabIndex == 3 ?Colors.amber[800] : Colors.black),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/images/profile_icon.png",height: 24.0,width: 24.0,color:val.getSelectedTabIndex == 4 ?Colors.amber[800] : Colors.black),
                label: 'Profile',
              ),
            ],
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            selectedLabelStyle:  const TextStyle(fontWeight: FontWeight.bold),
            currentIndex: val.selectedTabIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (int index) {
              val.setTabIndex(index);
            },

            unselectedItemColor: Utility.getColorFromHex(globalBlackColor),
            showUnselectedLabels: true,
          );
        },
      ),
      body: Consumer<DashboardProvider>(
          builder: (_,val,child){
            return _gotoScreen(val.getSelectedTabIndex, context);
          },
      ),
    );
  }
}
