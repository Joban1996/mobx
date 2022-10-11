import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

class ProfileAddressesScreen extends StatelessWidget {
  ProfileAddressesScreen({Key? key}) : super(key: key);
  List<Map> addressList = [
    {
      'title': 'Home',
      'subtitle': '297, DLF Tower, B2,  Sector 23, Gurgaon, India 110010'
    },
    {
      'title': 'Work',
      'subtitle':
          '2nd 3rd 4th  Floor, Shashwat Business Park,Opp. Soma Textiles,Rakhial, Ahmedabad – 380023, Gujarat, India.'
    },
  ];

  Widget AddressWidget(
      BuildContext context, String addressTitle, String addressSubtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addressTitle,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.close)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      addressSubtitle,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              // Radio(
              //   value: '',
              //   onChanged: (value) {
              //
              //   }, groupValue: '',
              // ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          AppBarTitle("ADDRESSES", "Add, edit or delete your addresses "),
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
        body: Container(
          color: Colors.white.withOpacity(0.8),
          child: Stack(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    var model = addressList[index];
                    return AddressWidget(
                        context, model['title'], model['subtitle']);
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Expanded(
                      child: AppButton(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addAdressScreen);
                    },
                    text: Strings.addNewAddressButton,
                    isTrailing: false,
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
