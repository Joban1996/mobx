import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/item_info_arrow_forward.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/routes.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  Widget accountInfo(BuildContext context){
    String name = App.localStorage.getString(PREF_NAME).toString();
    String email = App.localStorage.getString(PREF_EMAIL).toString();
    String mobile = App.localStorage.getString(PREF_MOBILE).toString();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.accountInfo,style: Theme.of(context).textTheme.bodyText2,),
                verticalSpacing(heightInDouble: 0.01, context: context),
                Text(name,style: Theme.of(context).textTheme.caption,),
                Text("+$mobile / $email",style: Theme.of(context).textTheme.caption,)
              ],
            ),
          ),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.accountInformation),
              child: Text("Edit",style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalRedColor)),))
        ],
      ),
    );
  }
  Widget _row(String title,BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title,
                style: Theme.of(context).textTheme.caption),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Utility.getColorFromHex(globalSubTextGreyColor),
            size: 20,
          )
        ],
      ),
    );
  }

  Widget aboutAndLegal(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.aboutLegal,style: Theme.of(context).textTheme.bodyText2,),
          verticalSpacing(heightInDouble: 0.01, context: context),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.aboutUs);
              },
              child: _row("About Us",context)
          ),
          GestureDetector(
              onTap: (){
                //Navigator.pushNamed(context, Routes.wishListScreeen);
              },
              child: _row("Term & Conditions", context)),
          _row("Privacy Policy", context),
          _row("Refund Policy", context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBarCommon(Text("PROFILE",style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600)),
        //   appbar: AppBar(), onTapCallback: (){},leadingImage: IconButton(
        //     padding: EdgeInsets.zero,
        //     constraints: BoxConstraints(),
        //     icon: Icon(Icons.arrow_back),color: Colors.black,onPressed: ()=>Navigator.pop(context),),),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountInfo(context),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.wishListScreeen);
                }, title: "WISH LISTS", description: "Buy Later, Quick Buy, Delete Wish lists"),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.profileAddressesScreen);
                }, title: "ADDRESSES", description: "Add, Edit & Delete Addresses"),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  //Navigator.pushNamed(context, Routes.wishListScreeen);
                }, title: "INSURANCES", description: "Purchase Insurance for products"),
                dividerCommon(context),
                aboutAndLegal(context),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.faqScreen);
                }, title: "FAQs", description: "View all Frequency Asked Questions"),
                dividerCommon(context),
                Consumer<DashboardProvider>(
                  builder: (_,val,child){
                    return  ItemInfoArrowForward(onTap: (){
                      val.setTabIndex(0);
                      App.localStorage.clear();
                      Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
                    }, title: "LOGOUT", description: "Logout From this Device");
                  },
                ),
                dividerCommon(context),
                Align(
                    alignment: Alignment.center,
                    child: Text("Version 1.12",style: Theme.of(context).textTheme.caption,))
              ],
            ),),
        ));
  }
}
