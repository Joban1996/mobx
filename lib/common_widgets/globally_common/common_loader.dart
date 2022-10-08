import 'package:flutter/material.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';







class CommonLoader extends StatelessWidget {
  const CommonLoader({required this.screenUI,Key? key}) : super(key: key);

  final Widget screenUI;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        screenUI,
        context.watch<LoginProvider>().getIsLoading ? Container(
           color: Colors.white.withOpacity(0.7),
          child: Center(
            child: CircularProgressIndicator(valueColor:
            AlwaysStoppedAnimation<Color>(Utility.getColorFromHex(globalOrangeColor))),
          ),
        ) : Container()
      ],
    );
  }
}
