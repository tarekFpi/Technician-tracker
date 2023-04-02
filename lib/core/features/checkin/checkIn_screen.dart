
 import 'dart:async';
 import 'package:flutter/material.dart';
 import 'package:geolocator/geolocator.dart';
 import 'package:get/get.dart';
 import 'package:get/get_navigation/src/extension_navigation.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technician_tracker/core/features/checkin/check_in_controller.dart';
import 'package:technician_tracker/core/features/service/location_service.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
 import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:technician_tracker/core/widgets/checkIn_animated_button.dart';
 import 'package:intl/intl.dart';
 import 'package:flutter_easyloading/flutter_easyloading.dart';


class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {

  List<Marker> markers = [];
  List<Polyline> polylines = [];
  List<LatLng> latlngList = [];

  Completer<GoogleMapController> controller = Completer();
  CameraPosition  cameraPosition = CameraPosition(target: LatLng(0, 0),zoom: 10.0);

  final checkInController = Get.put(CheckInController());

  late Position position;

  late LatLng latLng;

  String? selectedValue;

  @override
  void initState() {
    super.initState();


    getUserCurrentLocation();
  }

  Future<Position> getUserCurrentLocation() async {

    try {

      EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

      final status = await LocationService.getLocationState();
      if (status == LocationStatus.PERMISSION_OK) {
        //permission is ok

         position = await Geolocator.getCurrentPosition();
          latLng = LatLng(position.latitude, position.longitude);

        cameraPosition =CameraPosition(target: latLng,zoom: 14,);

        markers.add(
          Marker( markerId: MarkerId('current_Postion'),
              infoWindow: InfoWindow(title: 'Current Position'),
              position: latLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              )),

        );

        GoogleMapController googleMapController =await controller.future;

        googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        setState(() {

        });

         EasyLoading.dismiss();
      }

      if (status == LocationStatus.SERVICE_DISABLE) {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Location services are disabled."),
            content: const Text(
                "Please enable the location service from app settings"),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Go to settings'),
                onPressed: () {
                  Geolocator.openLocationSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
      if (status == LocationStatus.PERMISSION_DENIED) {
        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Location permissions are denied"),
            content: const Text(
                "Location permissions are require to use this app. Please accept location permissions"),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  getUserCurrentLocation();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
      if (status == LocationStatus.PERMISSION_DENIED) {
        if (status == LocationStatus.PERMISSION_DENIED) {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                  "Location permissions are permanently denied, we cannot request permissions"),
              content: const Text(
                  "Please accept location permission from app setting"),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Open Settings'),
                  onPressed: () {
                    Geolocator.openLocationSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return position;
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
                 markers: Set.from(markers),
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
             ],
            ),
          ),

          Container(
          //  margin: EdgeInsets.all(16),
            child: AnimatedButton(
              onComplete: _onConfirmed,
            ),
          )
        ],
      ),

    ));
  }

  void _onConfirmed() {

    DateTime today = DateTime.now();
    String currentTime = DateFormat("hh:mm:ss").format(today);

   checkInController.TodayAttendance(currentTime,position.latitude,position.longitude);
  }
}
