import 'package:flutter/material.dart';
import 'package:mobx/UI/auth/enter_otp.dart';
import 'package:mobx/UI/auth/login_screen.dart';
import 'package:mobx/UI/auth/splash_screen.dart';
import 'package:mobx/UI/dashboard/dashboard_screen.dart';
import 'package:mobx/UI/dashboard/home/home_sc.dart';
import 'package:mobx/UI/dashboard/home/product_details1.dart';
import 'package:mobx/UI/dashboard/home/product_listing.dart';
import 'package:mobx/UI/dashboard/orders/orders_home.dart';
import 'package:mobx/UI/dashboard/profile/profile_screen.dart';
import 'package:mobx/UI/dashboard/sell/sell_home.dart';

import '../UI/dashboard/home/product_details2.dart';
import '../UI/dashboard/home/product_details3.dart';
import '../UI/dashboard/home/shopping_cart.dart';
import '../UI/dashboard/repair/repair_home.dart';








class Routes {

  static const loginScreen = "loginScreen";
  static const dashboardScreen = "dashboardScreen";
  static const homeScreen = "homeScreen";
  static const sellHome = "sellHome";
  static const repairHome = "repairHome";
  static const ordersHome = "ordersHome";
  static const profileScreen = "profileScreen";
  static const productDetail1 = "productDetail1";
  static const productDetail2 = "productDetail2";
  static const productDetail3 = "productDetail3";
  static const shoppingCart = "shoppingCart";
  static const productListing = "productListing";
  static const enterOtp = "enterOtp";
  static const splashScreen = "splashScreen";

static Route<dynamic> generatedRoute(RouteSettings settings){
        switch(settings.name){
          case loginScreen:
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case dashboardScreen:
            return MaterialPageRoute(builder: (_) => DashboardScreen());
          case homeScreen:
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case sellHome:
            return MaterialPageRoute(builder: (_) => SellHome());
          case repairHome:
            return MaterialPageRoute(builder: (_) => RepairHome());
          case profileScreen:
            return MaterialPageRoute(builder: (_) => ProfileScreen());
          case ordersHome:
            return MaterialPageRoute(builder: (_) => OrdersHome());
          case productDetail1:
            return MaterialPageRoute(builder: (_) => ProductDetails1());
          case productDetail2:
            return MaterialPageRoute(builder: (_) => ProductDetails2());
          case productDetail3:
            return MaterialPageRoute(builder: (_) => ProductDetails3());
          case shoppingCart:
            return MaterialPageRoute(builder: (_) => ShoppingCart());
          case productListing:
            return MaterialPageRoute(builder: (_) => ProductListing());
          case enterOtp:
            return MaterialPageRoute(builder: (_) => EnterOtp());
          case splashScreen:
            return MaterialPageRoute(builder: (_) => SplashScreen());
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}'))));
        }
}

}