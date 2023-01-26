import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/common_textfield_style.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../utils/routes.dart';

enum GenderTypeEnum { Male, Female }

class AccountInformation extends StatefulWidget {
  AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final first_name =
      TextEditingController(text: App.localStorage.getString(PREF_NAME));

  final last_name =
      TextEditingController(text: App.localStorage.getString(PREF_LASTNAME));

  final email =
      TextEditingController(text: App.localStorage.getString(PREF_EMAIL));

  final mobile =
      TextEditingController(text: App.localStorage.getString(PREF_MOBILE));

  final genderPref = App.localStorage.getString(PREF_GEN);

   String dateOfBith = App.localStorage.getString(PREF_DOB).toString();


  GenderTypeEnum? _genderTypeEnum;
 int _value = 1;
 var valuefirst = false;
 int counter = 0;
    // DateTime _date = DateTime.now();

// Future<Null> selectDate(BuildContext context) async{
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: _date,
//     firstDate: DateTime(1970),
//     lastDate: DateTime(2100)
//     );
//     if(picked != null && picked != _date){
//       print(_date.toString());
//       setState(() {
//         _date: picked;
//         print(_date.toString());
//       });
//     }
// }
  DateTime selectedDate = DateTime.now();
   var now1 = new DateTime.now().year;
   var now2 = new DateTime.now().month;
   var now3 = new DateTime.now().day;


  Future<void> _selectDate(BuildContext context) async {
    try{
 final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1971),
        lastDate: DateTime(now1,now2,now3)

        );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

    }
    }catch(error){
      print("Error 66");
      print(error);
    }


  }
 getFormatedDate(dynamic _date) {
    //   dynamic inputFormat = DateFormat('yyyy-MM-dd');
    //   dynamic inputDate = DateTime.parse(_date);
    //   print("8999999___${inputDate}");
    //   dynamic outputFormat = DateFormat('dd/MMMM/yyyy');
    //    print("91111111___${outputFormat}");
    // return outputFormat.format(inputDate);
    }

  @override
  Widget build(BuildContext context) {
    print("year $now1 month $now2 day $now3");
    print("dateOfBith___gsdsdsdddsdenderPref ${dateOfBith is int}");
  print("dateOfBith___${dateOfBith}");
    // print(genderPref is String);
    var now = new DateTime.now();
    print("now1now1now1${now1 is int}");
    String g = ('${now.year}/ ${now.month}/ ${now.day}');
    print("garden$g");
     print(genderPref is int);
    print(
        "FIRST NAME PRINT PAGE   >>>> ${App.localStorage.getString(PREF_NAME)}");
    print(
        "LAST NAMEPRINT PAGE  >>>> ${App.localStorage.getString(PREF_LASTNAME)}");
        print("genderPrefgenderPrefgenderPref$genderPref");
        print(genderPref);

    String? gender;
      bool hasSubmitted = false;

    return Scaffold(
        appBar: AppBarCommon(
          const AppBarTitle("ACCOUNT INFORMATION", "Edit your detail"),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: CommonLoader(
            screenUI: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white.withOpacity(0.8),
            child: Column(
              children: [
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: first_name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.text,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,
                      hintText: "John doe"),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  controller: last_name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.text,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,
                      hintText: "John doe"),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  enabled: false,
                  controller: mobile,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.phone,
                  decoration: CommonStyle.textFieldStyle(context,
                          borderSideColor: globalTextFieldBorderGrey,
                          hintText: "+91-12331 12312")
                      .copyWith(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Utility.getColorFromHex(
                                globalTextFieldBorderGrey))),
                  ),
                ),
                verticalSpacing(heightInDouble: 0.02, context: context),
                TextFormField(
                  enabled: false,
                  controller: email,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  style: Theme.of(context).textTheme.bodySmall,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CommonStyle.textFieldStyle(context,
                      borderSideColor: globalTextFieldBorderGrey,
                      hintText: "john@example.com"),
                ),
                verticalSpacing(heightInDouble: 0.04, context: context),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Gender",
                        // textAlign: TextAlign.left,

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          value:1,
                          contentPadding: EdgeInsets.all(0.0),
                          title: Text(GenderTypeEnum.Male.name),
                          // tileColor: Colors.black,
                          activeColor:
                              Utility.getColorFromHex(globalOrangeColor),
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = val!;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          value:2,
                          contentPadding: EdgeInsets.all(0.0),
                          title: Text(GenderTypeEnum.Female.name),
                          // tileColor: Colors.black,
                          activeColor:
                              Utility.getColorFromHex(globalOrangeColor),
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = val!;
                            });
                          }),
                    )
                  ],
                ),
                Row(
                 children: [
                    Expanded(
                      child:
                    Text(
                 counter > 0 ? DateFormat('dd/MM/yyyy').format(selectedDate) :dateOfBith.isEmpty || dateOfBith == "null" ? "dd/mm/yyyy" : dateOfBith,
                    style: TextStyle(
                      fontSize: 16
                    ),),

                    ),
                    IconButton(onPressed:
                    (){
                       hasSubmitted = true;
                        counter++;
  setState(() {});
                      _selectDate(context);
                      // selectDate(context);
                    }
                    , icon: Icon(Icons.calendar_month)

                    )
                  ],
                ),
                Consumer2<WishlistProvider, LoginProvider>(
                  builder: (_, val, val2, child) {
                    return AppButton(
                      onTap: () {
                        print(" hasSubmitted $hasSubmitted");
                        print("counter $counter");
                     var newCount = DateFormat('dd MMMM yyyy').format(selectedDate);
                        print("VAVAVVAVAVAV${selectedDate}");
                        print("VAVAVVAVAVAV___SECOND $newCount");
                        val2.setLoadingBool(true);
                        val.hitUpdateCustomer(name: first_name.text,lastname: last_name.text ,gender:_value,dob:newCount,email: email.text).then((value){
                          val2.setLoadingBool(false);
                           Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen,ModalRoute.withName(Routes.dashboardScreen));
                        });
                      },
                      text: "UPDATE",
                      isTrailing: false,
                    );
                  },
                )
              ],
            ),
          ),
        )));
  }
}
