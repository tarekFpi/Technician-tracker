
import 'dart:async';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/features/task/model/tasklist_response.dart';
import 'package:technician_tracker/core/features/task/task_controller.dart';
import 'package:technician_tracker/core/features/task/task_details_controller.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskDetails extends StatefulWidget {

  final TaskResponse tasklist;

  const TaskDetails({Key? key, required this.tasklist}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  final storage = GetStorage();

  List<Marker> _markers = [];

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Location currentLocation =  Location();
  Location MyLocation =  Location();

  var latitude;

  var longitude;

  @override
  void initState() {
    super.initState();

    taskDetailsController.ShowTaskDetails("${widget.tasklist.id}");

    setUpMarker();
  }

  Completer<GoogleMapController> controller = Completer();
  CameraPosition  cameraPosition = CameraPosition(target: LatLng(0, 0),zoom: 10.0);



  final taskDetailsController = Get.put(TaskDetailsController());

  void setUpMarker() async{

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
                onPressed: ()  async {

                  _serviceEnabled =  await currentLocation.requestService();

                  if (_serviceEnabled==true) {

                    Navigator.of(context).pop();

                  }
                },
              ),
            ],
          ),
        );
      }


      final lat = double.parse(latitude);
      final long = double.parse(longitude);

     // debugPrint("debugPrint :lat ,${lat} ,long:${long}");

      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat ?? 0.0,long?? 0.0),
        zoom: 14.0,

      )));
      _markers.add(Marker(markerId: MarkerId('laskid'),
        position: LatLng(lat ?? 0.0, long ?? 0.0,),

      ));

        setState(() {
        });

      _permissionGranted = await currentLocation.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {

        EasyLoading.dismiss();
        _permissionGranted = await currentLocation.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void TaskTrackingLocation(){

    MyLocation.onLocationChanged.listen((LocationData location) async {

      MyLocation.enableBackgroundMode();
      MyLocation.changeNotificationOptions(
        title: 'Tracking My Location',
       subtitle:'Location:${location.longitude},${location.longitude}',
      );
    });


  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor:lightColorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("টাস্ক ডিটেলস"
        ,style: textTheme.bodySmall?.copyWith(
            color: HexColor('#855EA9'), fontSize: 18,fontWeight: FontWeight.w500),),
      ),

     body:taskDetailsController.obx((state){


       latitude=state!.latitude;

       longitude=state!.longitude;

       return Container(
         margin: EdgeInsets.all(16),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [

                 Card(
                   color: Colors.white30,
                   child: Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Text(
                       "${state!.status!.name}",
                       style: textTheme.bodySmall?.copyWith(
                           color: Colors.yellow,
                           fontSize: 14,
                           fontWeight: FontWeight.bold),
                     ),
                   ),
                 ),
                 SizedBox(
                   width: 12,
                 ),

                 Card(
                   color: Colors.white30,
                   child: Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Text(
                       "${state!.category!.name}",
                       style: textTheme.bodySmall?.copyWith(
                           color: lightColorScheme.onTertiaryContainer,
                           fontSize: 14,
                           fontWeight: FontWeight.bold),
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(
               height: 12,
             ),
             Text(
               "Title",
               style: textTheme.bodySmall?.copyWith(
                   color: lightColorScheme.onTertiaryContainer,
                   fontSize: 12,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(
               height: 8,
             ),
             Text(
               "${state!.title}",
               style: textTheme.bodySmall?.copyWith(
                   color: lightColorScheme.onTertiaryContainer,
                   fontSize: 16,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(
               height: 12,
             ),
             Text(
               "Description",
               style: textTheme.bodyLarge?.copyWith(
                   color: lightColorScheme.onTertiaryContainer,
                   fontSize: 12,
                   fontWeight: FontWeight.w600),
             ),
             SizedBox(
               height: 4,
             ),
             Text(
               "${state!.description}",
               style: textTheme.bodySmall?.copyWith(
                   color: lightColorScheme.onTertiaryContainer,
                   fontSize: 15,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(
               height: 12,
             ),

             Row(
               children: [

                 Icon(FluentIcons.clock_20_filled,size: 24,),

                 SizedBox(
                   width: 8,
                 ),
                 Text(
                   "Time: ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${state!.time}"))}",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.surfaceTint,
                       fontSize: 14,
                       fontWeight: FontWeight.bold,),
                 ),
               ],
             ),

             SizedBox(
               height: 8,
             ),

             Row(
               children: [

                 Icon(Icons.date_range_outlined,size: 24,),

                 SizedBox(
                   width: 12,
                 ),
                 Text(
                   "Date: ${state!.date}",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.surfaceTint,
                       fontSize: 14,
                       fontWeight: FontWeight.bold),
                 ),
               ],
             ),

             SizedBox(
               height: 16,
             ),

             Text(
               "Location",
               style: textTheme.bodySmall?.copyWith(
                   color: darkColorScheme.onSecondary,
                   fontSize: 12,
                   fontWeight: FontWeight.bold),
             ),
             SizedBox(
               height: 8,
             ),
             Expanded(
               child: GoogleMap(
                 markers: Set.from(_markers),
                 zoomControlsEnabled: true,
                 myLocationEnabled: false,
                 compassEnabled: true,
                 mapType: MapType.normal,
                 initialCameraPosition:  cameraPosition,
                 onMapCreated: (GoogleMapController c) {
                   controller.complete(c);
                 },
                 onCameraMove: (position){
                 },
               ),
             ),
           ],
         ),
       );
     }),

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        child: taskDetailsController.obx((state) {

          int? uid =state!.id;

          if(state!.status!.id==2 ){

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          //foregroundColor: colorScheme.onPrimary,
                          backgroundColor:HexColor('#855EA9'),

                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: (){
                          taskDetailsController.StartTaskTacking(uid!, 4);
                        },
                        child: Text('Cancelled',style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lightColorScheme!.onPrimary)),
                      ),
                    ),

                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          //foregroundColor: colorScheme.onPrimary,
                          backgroundColor:HexColor('#855EA9'),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: (){

                          taskDetailsController.StartTaskTacking(uid!, 3);
                        },
                        child: Text('Complete',style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lightColorScheme!.onPrimary)),
                      ),
                    ),
                  ],
                )
              ],
            );

          } if(state!.status!.id==1 || state!.status!.id==4){

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      //foregroundColor: colorScheme.onPrimary,
                      backgroundColor:HexColor('#855EA9'),

                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: (){

                      setState(() {

                        taskDetailsController.StartTaskTacking(uid!, 2);

                      });
                      TaskTrackingLocation();

                    },
                    child: Text('Start Task',style: textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lightColorScheme!.onPrimary)),
                  ),
                ),

              ],
            );
          }else{
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                SizedBox(
                  width: double.infinity,
                  child: Text('Start Task',style: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: lightColorScheme!.onPrimary)),
                ),

              ],
            );
          }

        }),
      ),
    );
  }
}
