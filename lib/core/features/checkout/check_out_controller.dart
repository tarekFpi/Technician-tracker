import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:technician_tracker/core/features/attendance/model/today_attendan_check.dart';
import 'package:technician_tracker/core/features/checkin/model/attendan_checkIn_response.dart';
import 'package:technician_tracker/core/features/checkout/model/today_checkout_response.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class CheckOutController extends GetxController {

  final dioClient = DioClient.instance;

  final storage = GetStorage();

  Future<void> TodayCheckOutAttendance(var time,var latitude,var longitude) async{

    var  attendance_id= storage.read("attendance_id");

    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

    try {
      final response = await dioClient.put("/api/v1/attendances/${attendance_id}",
          options: Options(
            headers: {
              "content-Type": "application/json",
              "Accept": "application/json",
            },
          ),data:{
            "out_time": time,
            "latitude": latitude,
            "longitude": longitude,
          });

      final  attendance_response = TodayCheckoutResponse.fromJson(response.data);

      if(attendance_response.status == true){

        Get.offAll(() => NavScreen());

        Toast.successToast("${attendance_response.message}");

        EasyLoading.dismiss();
      }else{
        EasyLoading.dismiss();
        Toast.errorToast("${attendance_response.message}");
      }

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());
      EasyLoading.dismiss();
    }
  }
}