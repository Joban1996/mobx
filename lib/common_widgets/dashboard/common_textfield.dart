import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
class CommonTextField extends StatelessWidget {
  String hintText;
  CommonTextField({Key? key,required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
        ),
      ),
    );
  }
}
