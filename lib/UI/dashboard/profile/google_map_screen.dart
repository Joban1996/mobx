import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/UI/dashboard/profile/add_address_screen.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/provider/dashboard/address_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  List<Placemark> _userLocation = [];
  LatLng currentLocation = LatLng(30.7333, 76.7794);
  var addressText='';
  String? currentLatLng = "";
  String Address = 'search';
  String city='';
  String state='';
  String flatAddress='';
  String pinCode='';
  String country='';
  String street ='';
  var addressController=TextEditingController();
  late String latitudeValue, longitudeValue;

  late GoogleMapController _controller;
  Set<Marker> markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.7333, 76.7794),
    zoom: 14.4746,
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("ADD NEW ADDRESS", "Add your detail"),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child:
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  markers: markers,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller){
                    _controller = controller;
                  },
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        Position position = await _determinePosition();

                        _controller
                            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
                        markers.clear();
                        markers.add(
                            Marker(
                                draggable: true,
                                markerId: const MarkerId('currentLocation'),
                                position: LatLng(position.latitude, position.longitude),
                              onDragEnd: ((newPosition) {
                               //position=newPosition.latitude
                                print('the newLat is ${newPosition.latitude}');
                                print('the newLng is ${newPosition.longitude}');
                                setState(() {
                                  GetAddressFromLatLong(newPosition.latitude,newPosition.longitude);
                                });
                              }),
                                infoWindow: InfoWindow(
                          title: 'Your location',
                        )));
                        debugPrint("current location >>>>$position");
                        setState(() {
                          GetAddressFromLatLong(position.latitude,position.longitude);
                        });
                      },
                      icon: Icon(
                        Icons.my_location_sharp,
                        color: Utility.getColorFromHex(globalOrangeColor),
                      ),
                      label: Text(
                        'Current Location',
                        style: TextStyle(
                            color:
                            Utility.getColorFromHex(globalOrangeColor)),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Utility.getColorFromHex(
                                  globalOrangeColor)),
                          backgroundColor:
                          Utility.getColorFromHex(globalWhiteColor)),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.location_pin, color: Utility.getColorFromHex(globalOrangeColor),)
                  ),
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  enabled: false,
                  controller: addressController,
                ),
                Consumer<AddressProvider>(
                  builder: (_,val,child){
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: AppButton(
                        onTap: () {
                          if(state.isNotEmpty){
                            print("your state >>> $flatAddress");
                            val.setStateName(state);
                            val.hitGetRegionData().then((value) {
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                AddAddressScreen(street: street,flatAddress: flatAddress, city: city, state: state, pinCode: pinCode,
                                    country: country)));
                          }else{
                            Utility.showNormalMessage("Please select current location");
                          }

                        },
                        text: Strings.addcompleteAddressButton,
                        isTrailing: false,
                      ),
                    );
                  },
                )
              ],
            ),
          ),

        ],
      ),
      // SafeArea(
      //   child: Column(
      //     children: [
      //       Stack(
      //         children: [
      //           GoogleMap(
      //               initialCameraPosition: CameraPosition(
      //                   target: currentLocation,
      //                 zoom: 14.0,
      //               ),
      //             mapType: MapType.hybrid,
      //           ),
      //           OutlinedButton.icon(onPressed: () {  },
      //             icon: Icon(
      //               Icons.my_location_sharp,
      //               color: Utility.getColorFromHex(globalOrangeColor),
      //             ),
      //             label: Text('Current Location',style: TextStyle(
      //               color: Utility.getColorFromHex(globalOrangeColor)
      //             ),),
      //             style: OutlinedButton.styleFrom(
      //               side: BorderSide( color:  Utility.getColorFromHex(globalOrangeColor)),
      //               backgroundColor: Utility.getColorFromHex(globalWhiteColor)
      //             ),
      //           )
      //
      //         ],
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }

  Future<void> GetAddressFromLatLong(double latitude, double longitude
      ) async {
    if (kDebugMode) {
      print("inside the GetAddressFromLatLong");
    }
    _userLocation =
    await placemarkFromCoordinates(latitude, longitude);
    if (kDebugMode) {
      print("the address get is $_userLocation");
    }

    Placemark place = _userLocation[0];
    //Placemark place1 = _userLocation[1];
    Address =
    '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    addressController.text="${place.name},${place.subLocality},${place.locality},${place.postalCode},${place.administrativeArea},${place.country}";
    flatAddress='${place.name},${place.subLocality}';
    state='${place.administrativeArea}';
    city='${place.locality}';
    country='${place.country}';
    pinCode='${place.postalCode}';
    street = '${place.street}';
    print("the address is $addressText");

    // if (!mounted) return;
    // setState(() {
    //
    //
    // });
  }

}

