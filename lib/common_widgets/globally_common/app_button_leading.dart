import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';


class AppButtonLeading extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? btnColor;
  final Color? btnTxtColor;
  final bool  isSize;
  final String leadingImage;

  const AppButtonLeading({required this.leadingImage,required this.onTap, required this.text,this.btnColor,this.btnTxtColor, this.isSize = true,Key? key}) : super(key: key);

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
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(leadingImage,color: Colors.white,),
          SizedBox(width: getCurrentScreenWidth(context)*0.02,),
          Padding(
            padding: const EdgeInsets.only(top:4.0),
            child: Text(text,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600,color: btnTxtColor??Utility.getColorFromHex(globalBlackColor)),),
          ),
        ],
      )),
    );
  }
}
