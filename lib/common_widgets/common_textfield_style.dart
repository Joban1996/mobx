import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';





class CommonStyle{
  static InputDecoration textFieldStyle(BuildContext context,{Widget? dropDownIcon,String? hintText,
    String borderSideColor = globalOrangeColor,bool isLeading = true,Widget? suffix}) {return  InputDecoration(
      prefixIcon: hintText == null ?  Text(isLeading == true ?" +91" : "",style: Theme.of(context).textTheme. bodySmall,)
          : null,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 15,
      ),
      suffixIcon: suffix,
      hintText:  hintText ?? "",
      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalSubTextGreyColor)),
      contentPadding: const EdgeInsets.all(8),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Utility.getColorFromHex(borderSideColor))
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Utility.getColorFromHex(borderSideColor))
      ),
      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Utility.getColorFromHex(borderSideColor))
      ),
      enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))
          ,borderSide: BorderSide(color: Utility.getColorFromHex(borderSideColor))
      )
  );}
}