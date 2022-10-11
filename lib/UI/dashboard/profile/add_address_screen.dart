import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: Strings.addFlatHint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
                ),
              ),
            ),
            verticalSpacing(heightInDouble: 0.02, context: context),
            TextField(
              decoration: InputDecoration(
                hintText: Strings.landmarkHint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
                ),
              ),
            ),
            verticalSpacing(heightInDouble: 0.02, context: context),
            TextField(
              decoration: InputDecoration(
                hintText: Strings.pincodeHint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
                ),
              ),
            ),
            verticalSpacing(heightInDouble: 0.02, context: context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    Strings.addressType,
                    style: Theme.of(context).textTheme.bodyText2
                ),
                //verticalSpacing(heightInDouble: 0.02, context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem =  Strings.address_home;
                          id = 1;
                        });
                      },
                    ),
                    Text(
                      Strings.address_home,
                        style: Theme.of(context).textTheme.caption
                    ),

                    Radio(
                      value: 2,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem =  Strings.address_work;
                          id = 2;
                        });
                      },
                    ),
                    Text(
                      Strings.address_work,
                        style: Theme.of(context).textTheme.caption
                    ),

                    Radio(
                      value: 3,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = Strings.address_other;
                          id = 3;
                        });
                      },
                    ),
                    Text(
                      Strings.address_other,
                        style: Theme.of(context).textTheme.caption
                    ),
                  ],),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Expanded(
                    child: AppButton(onTap: (){}, text: Strings.save,isTrailing: false,)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

