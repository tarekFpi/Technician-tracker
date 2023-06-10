
 import 'dart:async';
 import 'package:flutter/material.dart';
 import 'package:dropdown_button2/dropdown_button2.dart';
 import 'package:geolocator/geolocator.dart';
 import 'package:get/get.dart';
 import 'package:get/get_navigation/src/extension_navigation.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
 import 'package:technician_tracker/core/features/checkout/check_out_controller.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
 import 'package:technician_tracker/core/features/service/location_service.dart';
 import 'package:technician_tracker/core/theme/color_scheme.dart';
 import 'package:technician_tracker/core/utils/hexcolor.dart';
 import 'package:technician_tracker/core/utils/toast.dart';
 import 'package:technician_tracker/core/widgets/checkout_animated_button.dart';
 import 'package:intl/intl.dart';
 import 'package:geocoding/geocoding.dart' as geo;
 import 'package:location/location.dart';
 import 'package:flutter_easyloading/flutter_easyloading.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {


  @override
  void initState() {
    super.initState();

    getUserCurrentLocation();
  }

  List<Marker> _markers = [];
  List<Polyline> polylines = [];
  List<LatLng> latlngList = [];

  String Address = '';

  bool isMyLocation = false;

  String currentTime='';

  final checkOutController = Get.put(CheckOutController());

  Completer<GoogleMapController> controller = Completer();

  CameraPosition  cameraPosition = CameraPosition(target: LatLng(0, 0),zoom: 10.0);

  Location currentLocation = Location();
  late LocationData _locationData;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;


  void getUserCurrentLocation() async {

    try {

      GoogleMapController _controller = await controller.future;

      _serviceEnabled = await currentLocation.serviceEnabled();

      if (!_serviceEnabled) {

        showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Location services are disabled."),
            content: const Text(
                "Please enable the location service from app settings"),
            actions: <Widget>[
              TextButton(
                child:  Text('Close'),
                onPressed: () {

                  Get.offAll(NavScreen());

                },
              ),
              TextButton(
                child:  Text('Ok'),
                onPressed: ()   async {

                  _serviceEnabled = await currentLocation.requestService();

                  if (_serviceEnabled==true) {

                    Navigator.of(context).pop();
                    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

                  }
                },
              ),
            ],
          ),
        );

      }else{
        EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);
      }

      _permissionGranted = await currentLocation.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {

        EasyLoading.dismiss();
        _permissionGranted = await currentLocation.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);
          return;

        }
      }


        currentLocation.onLocationChanged.listen((LocationData location) async {

          _locationData =location;

          _controller?.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(
                    location.latitude ?? 0.0, location.longitude ?? 0.0),
                zoom: 14.0,

              )));


            _markers.add(Marker(markerId: MarkerId('current_location'),
              position: LatLng(
                location.latitude ?? 0.0, location.longitude ?? 0.0,),
              infoWindow: InfoWindow(title: '${Address}'),
            ));

          setState(() {
          });


          List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
              location.latitude ?? 0.0, location.longitude ?? 0.0);
          geo.Placemark place = placemarks[0];

          Address =
          '${place.street},  ${place.subLocality}, ${place.locality},${place
              .postalCode}, ${place.country}';
          debugPrint("Address:${Address}");


          debugPrint("_locationData:${location.longitude} ,,${location.longitude}");

          EasyLoading.dismiss();
        });


      } catch (e) {
      debugPrint(e.toString());
      EasyLoading.dismiss();
    }

  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [

                GoogleMap(
                  markers: Set.from(_markers),
                  zoomControlsEnabled: true,
                  myLocationEnabled: false,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: cameraPosition,
                  onMapCreated: (GoogleMapController c) {
                    controller.complete(c);
                  },
                  onCameraMove: (position){
                  },
                ),

                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: FloatingActionButton.small(
                          heroTag: UniqueKey(),
                          onPressed: () {
                            Get.back();
                          },
                          backgroundColor: HexColor('#855EA9'),
                          child:
                          const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      )),
                ),
                Positioned.fill(child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: FloatingActionButton.small(
                      backgroundColor: HexColor('#855EA9'),
                      onPressed: () {

                        getUserCurrentLocation();
                      },
                      heroTag: UniqueKey(),
                      child:  const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),
                )),


                Positioned.fill(
                  top: 60,
                  left: 8,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child:Address!=''? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 80,
                        margin: EdgeInsets.only(right: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${Address} "),

                            ],
                          ),
                        ),
                      ):Text("")),
                ),
              ],
            ),
          ),

          Container(
            //  margin: EdgeInsets.all(16),
            child: AnimatedCheckOutButton(
              onComplete: _onConfirmed,
            ),
          ),
        ],
      ),
    ));
  }

  void _onConfirmed() {

      DateTime today = DateTime.now();
      String currentTime = DateFormat("hh:mm:ss").format(today);

    checkOutController.TodayCheckOutAttendance(currentTime,_locationData.latitude,_locationData.longitude);

  }
}
