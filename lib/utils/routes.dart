import 'package:flutter/material.dart';
import 'package:mobx/UI/auth/login_screen.dart';
import 'package:mobx/UI/auth/login_with_email.dart';
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
import 'package:mobx/UI/dashboard/home/today_deals.dart';
import 'package:mobx/UI/dashboard/orders/orderDetailsScreen.dart';
import 'package:mobx/UI/dashboard/orders/orders_home.dart';
import 'package:mobx/UI/dashboard/profile/basic_info/aboutUs_screen.dart';
import 'package:mobx/UI/dashboard/profile/account_information.dart';
import 'package:mobx/UI/dashboard/profile/basic_info/privacy_policy.dart';
import 'package:mobx/UI/dashboard/profile/basic_info/terms_conditions.dart';
import 'package:mobx/UI/dashboard/profile/faq_screen.dart';
import 'package:mobx/UI/dashboard/profile/google_map_screen.dart';
import 'package:mobx/UI/dashboard/profile/profile_addresses_screen.dart';
import 'package:mobx/UI/dashboard/profile/profile_screen.dart';
import 'package:mobx/UI/dashboard/profile/wishlist_screen.dart';
import 'package:mobx/UI/dashboard/search_screen.dart';
import 'package:mobx/UI/dashboard/sell/brand_model_screen.dart';
import 'package:mobx/UI/dashboard/sell/device_info_screen.dart';
import 'package:mobx/UI/dashboard/sell/sell_home.dart';
import 'package:mobx/model/name_model.dart';
import '../UI/dashboard/home/filter_screen.dart';
import '../UI/dashboard/home/product_details3.dart';
import '../UI/dashboard/home/shopping_cart.dart';
import '../UI/dashboard/repair/repair_home.dart';
import 'package:mobx/UI/auth/SignUpScreen.dart';
import 'package:mobx/UI/auth/enter_otp.dart';
import 'package:mobx/UI/auth/EnterSignUpOtp.dart';


class Routes {

  static const loginScreen = "loginScreen";
  static const dashboardScreen = "dashboardScreen";
  static const homeScreen = "homeScreen";
  static const sellHome = "sellHome";
  static const repairHome = "repairHome";
  static const ordersHome = "ordersHome";
  static const profileScreen = "profileScreen";
  static const  productDetail1 = "productDetail1";
  static const productDetail2 = "productDetail2";
  static const productDetail3 = "productDetail3";
  static const shoppingCart = "shoppingCart";
  static const productListing = "productListing";
  static const enterOtp = "enterOtp";
  static const splashScreen = "/";
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
  static const googleMapScreen="googleMapScreen";
  static const brandModelScreen="brandModelScreen";
  static const deviceInfoScreen="deviceInfoScreen";
  static const searchScreen="searchScreen";
  static const loginWithEmail="loginWithEmail";
  static const signUpScreen = "SignUpScreen";
  static const enterSignUpOtp = "EnterSignUpOtp";
  static const todayDeals="todayDeals";
  static const termsAndConditions="termsAndConditions";
  static const privacyPolicy="privacyPolicy";
  static const filterScreen="filterScreen";

static Route<dynamic> generatedRoute(RouteSettings settings){
        switch(settings.name){
          case welcomeScreen:
            return MaterialPageRoute(builder: (_) => WelcomeScreen());
          case loginScreen:
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case loginWithEmail:
            return MaterialPageRoute(builder: (_) => LoginWithEmail());
             case signUpScreen:
            return MaterialPageRoute(builder: (_) => SignUpScreen());
          case enterSignUpOtp:
            return MaterialPageRoute(builder: (_) => EnterSignUpOtp());
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
            final args = settings.arguments as ProfileNames;
            return MaterialPageRoute(builder: (_) =>AccountInformation(firstName: args.firstName,lastName: args.lastName,gender: args.gender,));
          case wishListScreeen:
            return MaterialPageRoute(builder: (_) =>WishListScreeen());
          case profileAddressesScreen:
            return MaterialPageRoute(builder: (_) =>ProfileAddressesScreen());
          // case addAdressScreen:
          //   return MaterialPageRoute(builder: (_) =>AddAddressScreen());
          case faqScreen:
            return MaterialPageRoute(builder: (_) =>FAQScreen());
          case aboutUs:
            return MaterialPageRoute(builder: (_) =>AboutUsScreen());
          case orderDetails:
            final argument = settings.arguments as String;
            return MaterialPageRoute(builder: (_) =>OrderDetailsScreen(number: argument));
          case googleMapScreen:
            final argument = settings.arguments as bool;
            return MaterialPageRoute(builder: (_) => GoogleMapScreen(isEdit: argument,));
          case brandModelScreen:
            return MaterialPageRoute(builder: (_) => BrandModelScreen());
          case deviceInfoScreen:
            return MaterialPageRoute(builder: (_) => DeviceInfoScreen());
          case searchScreen:
            return MaterialPageRoute(builder: (_) => SearchScreen());
          case todayDeals:
            return MaterialPageRoute(builder: (_) => const TodayDeals());
          case termsAndConditions:
            return MaterialPageRoute(builder: (_) =>  TermsAndConditions());
          case privacyPolicy:
            return MaterialPageRoute(builder: (_) => const PrivacyPolicy());
          case filterScreen:
            return MaterialPageRoute(builder: (_) => FilterScreen());
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}'))));
        }
}

}