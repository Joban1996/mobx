import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/common_textfield_style.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../utils/routes.dart';




class AccountInformation extends StatelessWidget {
   AccountInformation({Key? key}) : super(key: key);

  final name = TextEditingController(text: App.localStorage.getString(PREF_NAME));
  final email = TextEditingController(text: App.localStorage.getString(PREF_EMAIL));
  final mobile = TextEditingController(text: App.localStorage.getString(PREF_MOBILE));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(const AppBarTitle("ACCOUNT INFORMATION",
            "Edit your detail"),
          appbar: AppBar(), onTapCallback: (){},leadingImage: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back),color: Colors.black,onPressed: ()=>Navigator.pop(context),),),
        body: CommonLoader(screenUI: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: name,
                  inputFormatters: [LengthLimitingTextInputFormatter(30),],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.text,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,hintText: "John doe"),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  enabled: false,
                  controller: mobile,
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,hintText: "+91-12331 12312").copyWith(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Utility.getColorFromHex(globalTextFieldBorderGrey))
                  ),),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: email,
                  inputFormatters: [LengthLimitingTextInputFormatter(30),],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CommonStyle.textFieldStyle(
                      context,borderSideColor: globalTextFieldBorderGrey,hintText: "john@example.com"),
                ),
                verticalSpacing(heightInDouble: 0.04, context: context),
                Consumer2<WishlistProvider,LoginProvider>(
                  builder: (_,val,val2,child){
                    return AppButton(onTap: (){
                      val2.setLoadingBool(true);
                      val.hitUpdateCustomer(name: name.text, email: email.text).then((value){
                        val2.setLoadingBool(false);
                        App.localStorage.setString(PREF_NAME, name.text);
                        App.localStorage.setString(PREF_EMAIL, email.text);
                        Navigator.pushNamedAndRemoveUntil(context,
                            Routes.dashboardScreen,ModalRoute.withName(Routes.dashboardScreen));
                      });
                    }, text: "UPDATE",isTrailing: false,);
                  },
                )
              ],
            ),
          ),
        )));
  }
}
