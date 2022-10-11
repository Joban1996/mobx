import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';




class AppBarCommon extends StatelessWidget implements PreferredSizeWidget{

  final Widget titleText;
  final AppBar appbar;
  final Widget? leadingImage;
  final VoidCallback onTapCallback;
  final List<Widget>? trailingAction;

  const AppBarCommon(this.titleText,{Key? key,required this.appbar ,this.trailingAction,
    this.leadingImage, required this.onTapCallback }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: leadingImage,
      actions: trailingAction,
      bottom: PreferredSize(
          child: Container(
            color: Utility.getColorFromHex(globalGreyColor),
            height: 0.5,
          ),
          preferredSize: Size.fromHeight(4.0)),
      elevation: 0,
      backgroundColor: Utility.getColorFromHex(globalWhiteColor).withOpacity(0.8),
      title: titleText,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);

}
