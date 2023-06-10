
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/attendance/attendan_report_screen.dart';
import 'package:technician_tracker/core/features/attendance/attendance_report_controller.dart';
import 'package:technician_tracker/core/features/checkin/checkIn_screen.dart';
import 'package:technician_tracker/core/features/checkout/check_out_controller.dart';
import 'package:technician_tracker/core/features/checkout/checkout_screen.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/features/task/task_report_screen.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:intl/intl.dart';

 class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

   @override
   State<HomeScreen> createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {

    final attendanceReportController = Get.put(AttendanceReportController());

    final storage = GetStorage();


   @override
   Widget build(BuildContext context) {
     final colorScheme = Theme.of(context).colorScheme;
     final textTheme = Theme.of(context).textTheme;

     return SafeArea(child: Scaffold(
       backgroundColor:colorScheme.surfaceVariant,
         appBar: AppBar(
           backgroundColor:colorScheme.surface,
             elevation: 2,
             centerTitle: true,
             title: Text(
               "home_page".tr,
               style: textTheme.titleMedium?.copyWith(
                   color: HexColor('#855EA9'),
                   fontSize: 18,
                   fontWeight: FontWeight.bold),
             ),actions: [

           IconButton(
             onPressed: () {
             },
             icon: CircleAvatar(
               child: Icon(FluentIcons.alert_24_regular,size: 24,),
               radius: 24.0,
               backgroundColor: HexColor("#F5F6FC"),
             ),
           )
         ],),

   body: SingleChildScrollView(
     child: Container(
       padding: const EdgeInsets.symmetric(horizontal: 16),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [

           SizedBox(height: 8,),

           Card(
             elevation: 2,
             child: ImageSlideshow(
               width: double.infinity,
               height: 150,
               initialPage: 0,
               indicatorColor: Colors.blue,
               indicatorBackgroundColor: Colors.grey,
               onPageChanged: (value) {
                 debugPrint('Page changed: $value');
               },
               autoPlayInterval: 3000,
               isLoop: true,
               children: [

                 Image.asset('assets/images/slider1.png', fit: BoxFit.fill),
                 Image.asset('assets/images/slider2.png', fit: BoxFit.fill),
                 Image.asset('assets/images/slider3.png', fit: BoxFit.fill),

               ],
             ),
           ),

           SizedBox(height: 16,),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [

               Expanded(
                 child: SizedBox(
                   height: 200,
                   child: Obx(() {

                     var status = attendanceReportController.TodayAttendanCheckStatus.value;

                     var checkInTime = attendanceReportController.TodayAttendanCheckInTime.value;

                     if(checkInTime!=""){

                       var temp = int.parse(checkInTime!.split(':')[0]);
                       String? t;
                       if(temp >= 12 && temp <24){
                         t = " PM";
                       }
                       else{
                         t = " AM";
                       }
                       if (temp > 12) {
                         temp = temp - 12;
                         if (temp < 10) {
                           checkInTime = checkInTime.replaceRange(0, 2, "$temp");
                           checkInTime += t;
                         } else {
                           checkInTime = checkInTime.replaceRange(0, 2, "$temp");
                           checkInTime += t;
                         }
                       } else if (temp == 00) {

                         checkInTime = checkInTime.replaceRange(0, 2, '12');
                         checkInTime += t;

                       }else{

                         checkInTime += t;
                       }
                     }

                     print("checkInTime:${checkInTime}");

                     return Card(
                       color: HexColor("#FAFDFC"),
                       elevation:1,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       child: InkWell(
                         onTap: () {

                          if(status==false){

                             Get.to(CheckInScreen());
                            }else{

                             Toast.errorToast("Your are already  Check In!!");
                           }

                         },
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [

                             Image.asset(
                               "assets/images/attend1.png",
                               fit: BoxFit.fill,
                               height: 50,
                               width: 50,
                             ),

                             Center(
                               child: Text(
                                 "check_in".tr,
                                 style: textTheme.bodyMedium?.copyWith(
                                     color: Colors.black, fontSize: 14,fontWeight: FontWeight.w500),
                               ),
                             ),

                             checkInTime!="" ? Center(
                               child: Text(
                                 "${checkInTime}",
                                 style: textTheme.bodyMedium?.copyWith(
                                     color: HexColor('#855EA9'), fontSize: 14,fontWeight: FontWeight.bold),
                               ),
                             ):Text(""),
                           ],
                         ),
                       ),
                     );
                   }),
                 ),
               ),

              SizedBox(width: 8,),

               Expanded(
                 child: SizedBox(
                   height: 200,
                   child:Obx(()
                     {
                       var status = attendanceReportController.TodayAttendanCheckStatus.value;

                       var checkOutTime = attendanceReportController.TodayAttendanCheckOutTime.value;

                       if(checkOutTime!=""){

                         var temp = int.parse(checkOutTime!.split(':')[0]);
                         String? t;
                         if(temp >= 12 && temp <24){
                           t = " PM";
                         }
                         else{
                           t = " AM";
                         }
                         if (temp > 12) {
                           temp = temp - 12;
                           if (temp < 10) {
                             checkOutTime = checkOutTime.replaceRange(0, 2, "$temp");
                             checkOutTime += t;
                           } else {
                             checkOutTime = checkOutTime.replaceRange(0, 2, "$temp");
                             checkOutTime += t;
                           }
                         } else if (temp == 00) {

                           checkOutTime = checkOutTime.replaceRange(0, 2, '12');
                           checkOutTime += t;

                         }else{

                           checkOutTime += t;
                         }
                       }



                       return Card(
                         color: HexColor("#FAFDFC"),
                         elevation: 1,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         child: InkWell(
                           onTap: () {

                            if(status!=false){

                              Get.to(CheckOutScreen());

                            }if(status==false){

                             Toast.errorToast("Your are first check in then check Out!!");
                            }

                           },
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [

                               Image.asset(
                                 "assets/images/log_out.png",
                                 fit: BoxFit.fill,
                                 height: 50,
                                 width: 50,
                               ),

                               Text(
                                 "check_out".tr,
                                 style: textTheme.bodyMedium?.copyWith(
                                     color: Colors.black, fontSize: 14,fontWeight: FontWeight.w500),
                               ),

                               checkOutTime!="" ? Center(
                                 child: Text(
                                   "${checkOutTime}",
                                   style: textTheme.bodyMedium?.copyWith(
                                       color: HexColor('#855EA9'), fontSize: 14,fontWeight: FontWeight.bold),
                                 ),
                               ):Text(""),
                             ],
                           ),
                         ),
                       );
                     }
                   )),
                 ),
             ],
           ),

         SizedBox(height: 16,),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [

               Expanded(
                 child: SizedBox(
                   height: 200,
                   child: Card(
                     color: HexColor("#FAFDFC"),
                     elevation:1,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                     child: InkWell(
                       onTap: () {

                         Get.to(AttendanceReportScreen());
                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Image.asset(
                             "assets/images/attendance.png",
                             fit: BoxFit.fill,
                             width: 45,
                           ),


                           Center(
                             child: Text(
                               "Attendance_Report".tr,
                               style: textTheme.bodyMedium?.copyWith(
                                   color: Colors.black, fontSize: 14,fontWeight: FontWeight.w500),
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),
                 ),
               ),

              SizedBox(width: 8,),

               Expanded(
                 child: SizedBox(
                   height: 200,
                   child: Card(
                     color: HexColor("#FAFDFC"),
                     elevation: 1,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                     child: InkWell(
                       onTap: () {

                         Get.to(TaskReportScreen());
                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Image.asset(
                             "assets/images/price_list.png",
                             fit: BoxFit.fill,
                             width: 50,
                           ),


                           Text(
                             "Task_Report".tr,
                             style: textTheme.bodyMedium?.copyWith(
                                 color: Colors.black, fontSize: 14,fontWeight: FontWeight.w500),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ],
       ),
     ),
   ),
     ));
   }
 }
