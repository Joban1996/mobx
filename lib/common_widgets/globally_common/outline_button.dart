import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
class OutLineButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  OutLineButtonWidget({Key? key,required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side:  BorderSide(width: 1.0, color: Utility.getColorFromHex(globalOrangeColor)),
      ),
      child: Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black
        ),),
    );
  }
}
