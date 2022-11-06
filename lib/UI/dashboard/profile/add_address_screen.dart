import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/dashboard/common_textfield.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../common_widgets/globally_common/app_button.dart';
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  // Group Value for Radio Button.
  int id = 1;
  String radioButtonItem = Strings.address_home;
  bool checkedValue=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("ADD NEW ADDRESS", "Add your detail"),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
        // trailingAction: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10),
        //     child: Icon(
        //       Icons.star_border_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CommonTextField(hintText: Strings.firstNameHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.lastNameHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.addFlatHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: Strings.addFlatHint,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
              //     ),
              //   ),
              // ),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.landmarkHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.cityNameHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.stateNameHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: Strings.landmarkHint,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //       borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
              //     ),
              //   ),
              // ),
              verticalSpacing(heightInDouble: 0.02, context: context),
              CommonTextField(hintText: Strings.pincodeHint),
              verticalSpacing(heightInDouble: 0.02, context: context),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    activeColor: Utility.getColorFromHex(globalOrangeColor),
                  ),
                  Text("Same as Billing Address",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Utility.getColorFromHex(globalSubTextGreyColor)),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(onTap: (){}, text: Strings.save,isTrailing: false,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

