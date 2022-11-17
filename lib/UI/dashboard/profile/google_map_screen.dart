import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  LatLng currentLocation = LatLng(30.7333, 76.7794);
  var addressText='';

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

    Position position = await Geolocator.getCurrentPosition();

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

                        markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude),infoWindow: InfoWindow(
                          title: 'Your Order will be delivered here.',
                        )));
                        setState(() {

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
                RichText(text: TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.location_pin, color: Utility.getColorFromHex(globalOrangeColor),)),
                      TextSpan(
                        text: addressText,
                      )
                    ]
                ),

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addAdressScreen);
                    },
                    text: Strings.addcompleteAddressButton,
                    isTrailing: false,
                  ),
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

}

