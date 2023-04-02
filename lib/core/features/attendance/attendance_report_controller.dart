import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/attendance/model/attendance_response.dart';
import 'package:technician_tracker/core/features/attendance/model/today_attendan_check.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

 class AttendanceReportController extends GetxController with StateMixin<List<Attendance>>{

  final dioClient = DioClient.instance;

   final attendancelist = <Attendance>[].obs;

   final TodayAttendancelist = <TodayAttendan>[].obs;

   RxBool TodayAttendanCheckStatus = true.obs;

   var TodayAttendanCheckInTime = "".obs;

  final storage = GetStorage();

  @override
  void onInit() {

   ShowAttendanceReport();

   TodayAttendanceCheck();
  }

  Future<void> ShowAttendanceReport() async{

   try {

    change(null, status: RxStatus.loading());

    final res = await dioClient.get("/api/v1/attendances");

    final attendance_response = AttendanceResponse.fromJson(res);

    if(attendance_response.status==true){

     final list = attendance_response.data ?? [];

     attendancelist.assignAll(list);

     change(attendancelist, status: RxStatus.success());

    }else {

     Toast.errorToast("${attendance_response.message}");

    }

   } catch(e) {

    Toast.errorToast("${e.toString()}");

    debugPrint(e.toString());

    change(null, status: RxStatus.error(e.toString()));
   }
  }



  Future<void> TodayAttendanceCheck() async{

   EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

   try {

    final response = await dioClient.get("/api/v1/attendances?today=1");

    final check_attendance = TodayAttendanCheck.fromJson(response);

    if(check_attendance.data == null){

     TodayAttendanCheckStatus.value=false;

     storage.remove("checkInTime");

     storage.remove("OutTime");

     storage.remove("OutTime");

     storage.remove("attendance_id");


     EasyLoading.dismiss();

    }else{

     var InTime = check_attendance.data!.inTime;

    // storage.write("checkInTime", "${InTime}");

     TodayAttendanCheckInTime(InTime);

     EasyLoading.dismiss();
    }

   } catch(e) {

    Toast.errorToast("${e.toString()}");

    debugPrint(e.toString());
    EasyLoading.dismiss();
   }
  }
 }