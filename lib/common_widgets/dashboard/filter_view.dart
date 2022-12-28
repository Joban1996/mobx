import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';



class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Widget topView(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("FILTERS",style: Theme.of(context).textTheme.bodyMedium,),
            Text("CLEAR ALL",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalOrangeColor)))
          ],
        ),
      );
    }

    Widget bottomView(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text("CLOSE",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),)),
            Expanded(
              child: Text("APPLY",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalOrangeColor),
                  fontWeight: FontWeight.w500)),
            )
          ],
        ),
      );
    }
    Widget valueRow(){
      return Row(
        children: [
            Checkbox(value: true, onChanged: (_){

            }),
          const Text("32 GB")
        ],
      );
    }

    Widget middleView(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("RAM"),
                  Text("Color")
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: valueRow())
          ],
        ),
      );
    }

    return
   Column(
        children: [
          topView(),
          middleView(),
          bottomView()
        ],
    );
  }
}
