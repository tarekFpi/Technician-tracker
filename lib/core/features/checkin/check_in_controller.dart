import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:technician_tracker/core/features/attendance/model/today_attendan_check.dart';
import 'package:technician_tracker/core/features/checkin/model/attendan_checkIn_response.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

 class CheckInController extends GetxController {

   final dioClient = DioClient.instance;

   final storage = GetStorage();

   Future<void> TodayAttendance(var time,var latitude,var longitude) async{

     EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

     try {
       final response = await dioClient.post("/api/v1/attendances",
           options: Options(
           headers: {
             "content-Type": "application/json",
             "Accept": "application/json",
           },
       ),data:{
         "in_time": time,
         "latitude": latitude,
         "longitude": longitude,
       });

       final  attendance_response = AttendanCheckInResponse.fromJson(response.data);

       if(attendance_response.status == true){

      // var InTime = attendance_response.data!.inTime;
     //  storage.write("checkInTime", "${InTime}");


       var id = attendance_response.data!.id;

       storage.write("attendance_id", "${id}");

        Get.offAll(() => NavScreen());

         Toast.successToast("${attendance_response.message}");

       EasyLoading.dismiss();
       }else{

         EasyLoading.dismiss();
         Toast.errorToast("${attendance_response.message}");
       }

     } catch(e) {

       Toast.errorToast("${e.toString()}");
       EasyLoading.dismiss();
       debugPrint(e.toString());

     }
   }
 }