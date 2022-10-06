import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../common_widgets/common_textfield_style.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';







class AccountInformation extends StatelessWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(AppBarTitle("ACCOUNT INFORMATION",
            "Edit your detail"),
    appbar: AppBar(), onTapCallback: (){},leadingImage: IconButton(
    padding: EdgeInsets.zero,
    constraints: BoxConstraints(),
    icon: Icon(Icons.arrow_back),color: Colors.black,onPressed: ()=>Navigator.pop(context),),),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,hintText: "John Smith"),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,hintText: "+91-12331 12312"),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(10),],
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(
                      context,borderSideColor: globalTextFieldBorderGrey,hintText: "john@example.com"),
                ),
                verticalSpacing(heightInDouble: 0.04, context: context),
                AppButton(onTap: (){}, text: "UPDATE",isTrailing: false,)
              ],
            ),
          ),
        ));
  }
}
