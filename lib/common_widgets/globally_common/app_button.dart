import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';


class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? btnColor;
  final bool  isSize;
  final bool isTrailing;

  const AppButton({this.isTrailing = true,required this.onTap, required this.text,this.btnColor, this.isSize = true,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSize ? getCurrentScreenHeight(context)*0.06 : null,
      width: isSize ? getCurrentScreenWidth(context): null,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(btnColor??Utility.getColorFromHex(globalOrangeColor)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  )
              )
          ),
          //style: ElevatedButton.styleFrom(primary: btnColor),
          onPressed: onTap, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,style: const TextStyle(fontSize: 14),),
          isTrailing ?  SizedBox(width: getCurrentScreenWidth(context)*0.02,) : Container(),
          isTrailing ?  Image.asset("assets/images/arrow_forward.png") : Container()
        ],
      )),
    );
  }
}