import 'package:flutter/material.dart';
import 'package:mobx/UI/auth/login_screen.dart';
import 'package:mobx/UI/auth/splash_screen.dart';
import 'package:mobx/UI/auth/welcome_screen.dart';
import 'package:mobx/UI/dashboard/dashboard_screen.dart';
import 'package:mobx/UI/dashboard/home/addresses_screen.dart';
import 'package:mobx/UI/dashboard/home/compare_screen.dart';
import 'package:mobx/UI/dashboard/home/coupon_screen.dart';
import 'package:mobx/UI/dashboard/home/home_sc.dart';
import 'package:mobx/UI/dashboard/home/order_confirmed.dart';
import 'package:mobx/UI/dashboard/home/payment_screen.dart';
import 'package:mobx/UI/dashboard/home/product_details1.dart';
import 'package:mobx/UI/dashboard/home/product_list_with_deals.dart';
import 'package:mobx/UI/dashboard/home/product_listing.dart';
import 'package:mobx/UI/dashboard/orders/orderDetailsScreen.dart';
import 'package:mobx/UI/dashboard/orders/orders_home.dart';
import 'package:mobx/UI/dashboard/profile/aboutUs_screen.dart';
import 'package:mobx/UI/dashboard/profile/account_information.dart';
import 'package:mobx/UI/dashboard/profile/add_address_screen.dart';
import 'package:mobx/UI/dashboard/profile/faq_screen.dart';
import 'package:mobx/UI/dashboard/profile/profile_addresses_screen.dart';
import 'package:mobx/UI/dashboard/profile/profile_screen.dart';
import 'package:mobx/UI/dashboard/profile/wishlist_screen.dart';
import 'package:mobx/UI/dashboard/sell/sell_home.dart';
import '../UI/dashboard/home/product_details2.dart';
import '../UI/dashboard/home/product_details3.dart';
import '../UI/dashboard/home/shopping_cart.dart';
import '../UI/dashboard/repair/repair_home.dart';
import 'package:mobx/UI/auth/enter_otp.dart';







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
  static const productListWithDeals="productListWithDeals";
  static const orderConfirmed="orderConfirmed";
  static const payment="payment";
  static const compare="compare";
  static const address="address";
  static const coupon="coupon";
  static const accountInformation = "accountInformation";
  static const wishListScreeen="wishListScreeen";
  static const profileAddressesScreen="ProfileAddressesScreen";
  static const addAdressScreen="AddAdressScreen";
  static const faqScreen="FAQScreen";
  static const aboutUs="aboutUs";
  static const orderDetails="oderDetails";
  static const welcomeScreen = "welcomeScreen";

static Route<dynamic> generatedRoute(RouteSettings settings){
        switch(settings.name){
          case welcomeScreen:
            return MaterialPageRoute(builder: (_) => WelcomeScreen());
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
          // case productDetail2:
          //   return MaterialPageRoute(builder: (_) => ProductDetails2());
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
          case productListWithDeals:
            return MaterialPageRoute(builder: (_) =>ProductListWithDeals());
          case orderConfirmed:
            return MaterialPageRoute(builder: (_) =>OrderConfirmed());
          case payment:
            return MaterialPageRoute(builder: (_) =>PaymentScreen());
          case compare:
            return MaterialPageRoute(builder: (_) =>CompareScreen());
          case address:
            return MaterialPageRoute(builder: (_) =>AddressesScreen());
          case coupon:
            return MaterialPageRoute(builder: (_) =>CouponScreen());
          case accountInformation:
            return MaterialPageRoute(builder: (_) =>AccountInformation());
          case wishListScreeen:
            return MaterialPageRoute(builder: (_) =>WishListScreeen());
          case profileAddressesScreen:
            return MaterialPageRoute(builder: (_) =>ProfileAddressesScreen());
          case addAdressScreen:
            return MaterialPageRoute(builder: (_) =>AddAddressScreen());
          case faqScreen:
            return MaterialPageRoute(builder: (_) =>FAQScreen());
          case aboutUs:
            return MaterialPageRoute(builder: (_) =>AboutUsScreen());
          case orderDetails:
            return MaterialPageRoute(builder: (_) =>OrderDetailsScreen());
          case accountInformation:
            return MaterialPageRoute(builder: (_) => AccountInformation());
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}'))));
        }
}

}