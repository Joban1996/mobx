import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/wishlist_profile/wishlist_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../common_widgets/common_textfield_style.dart';
import '../../../common_widgets/dashboard/app_bar_title.dart';
import '../../../common_widgets/globally_common/app_bar_common.dart';
import '../../../utils/routes.dart';

enum GenderTypeEnum { Male, Female }

class AccountInformation extends StatefulWidget {
  final String firstName;
  final String lastName;
  final int gender;
  const AccountInformation({Key? key,required this.firstName,required this.lastName,required this.gender}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  // String dateOfBith = App.localStorage.getString(PREF_DOB).toString();

  TextEditingController? first_name;
  TextEditingController? last_name;


  GenderTypeEnum? _genderTypeEnum;

  int _value = -1;
  var valuefirst = false;
  int counter = 0;

  DateTime? selectedDate;
  var now1 = DateTime.now().year;
  var now2 = DateTime.now().month;
  var now3 = DateTime.now().day;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      Provider.of<WishlistProvider>(context,listen: false).hitGetUserDetails();
    });
    first_name =
        TextEditingController();
last_name =
    TextEditingController();
  first_name!.text = widget.firstName;
    last_name!.text = widget.lastName;
  _value = widget.gender;

  }

  StreamController<int> counterController = StreamController<int>();
  void dispose() {
    super.dispose();
  }
  bool hasSubmitted = false;




  Future<void> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    var now1 = new DateTime.now().year;
    var now2 = new DateTime.now().month;
    var now3 = new DateTime.now().day;
    try {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate!,
          firstDate: DateTime(1971),
          lastDate: DateTime(now1, now2, now3));

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });

        // counter++;
        setState(() {
          hasSubmitted = true;
        });
      }
    } catch (error) {
      print("Error 66");
      print(error);
    }
  }

  late VoidCallback reFresh;

  @override
  Widget build(BuildContext context) {
    print("year $now1 month $now2 day $now3");
    // print("dateOfBith___gsdsdsdddsdenderPref ${dateOfBith is int}");
    // print("dateOfBith___${dateOfBith}");
    var now = new DateTime.now();
    print("now1now1now1${now1 is int}");
    String g = ('${now.year}/ ${now.month}/ ${now.day}');
    print("garden$g");
    print(
        "FIRST NAME PRINT PAGE   >>>> ${App.localStorage.getString(PREF_NAME)}");
    print(
        "LAST NAMEPRINT PAGE  >>>> ${App.localStorage.getString(PREF_LASTNAME)}");

    String? gender;

    String firstNameOne;
    print("hasSubmittedhasSubmitted $hasSubmitted");
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
            onPressed: () => {
                Navigator.pop(context)
            },
          ),
        ),
        body: Query(
            options: QueryOptions(
              document: gql(getUserDetailsNow),
              fetchPolicy: FetchPolicy.noCache,
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              reFresh = refetch!;
              debugPrint("cart exception >>> ${result.exception}");

              if (result.hasException) {
                print("172_______173_____");
                return Text(result.exception.toString());
              }
              if (result.isLoading) {
                return globalLoader();
              }
              debugPrint("183_____get ALL data >>> ${result.data}");
              debugPrint("184_____get ALLAOK auth token >>> }");
              debugPrint(
                  "ALOK ___ 100 wishlist data >>>>> ${result.data!['customer']}");
              var userDetails = "${result.data!['customer']}";
              print("USER DETAILS 353===>> $userDetails");
              TextEditingController mobile = TextEditingController(
                  text: result.data!['customer']['mobilenumber']);
              TextEditingController email = TextEditingController(
                  text: result.data!['customer']['email']);
              String? dateOfBirth = result.data!['customer']['date_of_birth'];
              return CommonLoader(
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
                              onChanged: (value) => {
                                print("The value entered is : $value"),
                              }
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
                                hintText: "john@example.com") .copyWith(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                      color: Utility.getColorFromHex(
                                          globalTextFieldBorderGrey))),
                            ),
                          ),
                          verticalSpacing(heightInDouble: 0.04, context: context),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "Gender",

                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                    value: 1,
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Text(GenderTypeEnum.Male.name,
                                        style:
                                        Theme.of(context).textTheme.bodySmall),
                                    // tileColor: Colors.black,
                                    activeColor:
                                    Utility.getColorFromHex(globalOrangeColor),
                                    groupValue: _value,
                                    //  toggleable: true,
                                    onChanged: (val) {
                                      setState(() {
                                        _value = val!;
                                        print("Vavavava MAle val $val");
                                        print("Vavavava MAle _value val $_value");
                                      });
                                    }),
                              ),
                              Expanded(
                                child: RadioListTile(
                                    value: 2,
                                    contentPadding: EdgeInsets.all(0.0),
                                    title: Text(GenderTypeEnum.Female.name,
                                        style:
                                        Theme.of(context).textTheme.bodySmall),
                                    // tileColor: Colors.black,
                                    //  toggleable: true,
                                    activeColor:
                                    Utility.getColorFromHex(globalOrangeColor),
                                    groupValue: _value,
                                    onChanged: (val) {
                                      setState(() {
                                        _value = val!;
                                      });
                                      print("Vavavava val $val");
                                      print("Vavavava FeMAle _value val $_value");
                                    }),
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Utility.getColorFromHex(globalGreyColor),
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      // color:Colors.green
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        hasSubmitted
                                            ? DateFormat('yyyy-MM-dd')
                                            .format(selectedDate!)
                                            : dateOfBirth == null
                                            ? "Enter your date of birth"
                                            : dateOfBirth,
                                        style:
                                        Theme.of(context).textTheme.bodySmall,
                                      ),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    icon: Icon(Icons.calendar_month))
                              ],
                            ),
                          ),
                          verticalSpacing(heightInDouble: 0.02, context: context),
                          Consumer2<WishlistProvider, LoginProvider>(
                            builder: (_, val, val2, child) {
                              return AppButton(
                                onTap: () {
                                  print("CHeck value dateOfBirth Variable ${dateOfBirth}");
                                  print("CHeck value selectedDate Variable ${selectedDate}");
                                  print("CHeck value selectedDate String Variable ${selectedDate}");
                                  if(selectedDate== null){
                                    print("396_IF");
                                    print("dateOfBirth 393---- $dateOfBirth");
                                    print("counter $counter");
                                    var newCount = DateFormat('dd MMMM yyyy')
                                        .format(DateTime.parse(dateOfBirth??""));
                                    print("VAVAVVAVAVAV${dateOfBirth}");
                                    print("VAVAVVAVAVAV___SECOND $newCount");
                                    val2.setLoadingBool(true);
                                    val
                                        .hitUpdateCustomer(
                                        name: first_name!.text,
                                        lastname: last_name!.text,
                                        gender: _value,
                                        dob: newCount,
                                        email: email.text)
                                        .then((value) {
                                      val2.setLoadingBool(false);
                                      Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen,ModalRoute.withName(Routes.dashboardScreen));
                                    });

                                  }else{
                                    print("398__");
                                    var newCount = DateFormat('dd MMMM yyyy')
                                        .format(selectedDate!);
                                    print("VAVAVVAVAVAV${selectedDate}");
                                    print("VAVAVVAVAVAV___SECOND $newCount");
                                    val2.setLoadingBool(true);
                                    val
                                        .hitUpdateCustomer(
                                        name: first_name!.text,
                                        lastname: last_name!.text,
                                        gender: _value,
                                        dob: newCount,
                                        email: email.text)
                                        .then((value) {
                                      val2.setLoadingBool(false);
                                      Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen,ModalRoute.withName(Routes.dashboardScreen));
                                    });
                                  }
                                },
                                text: "UPDATE",
                                isTrailing: false,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
