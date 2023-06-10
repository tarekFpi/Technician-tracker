import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:technician_tracker/core/features/task/model/starting_point_task.dart';
import 'package:technician_tracker/core/features/task/model/task_details_response.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:dio/dio.dart';

class TaskDetailsController extends GetxController with StateMixin<TaskDetails> {

  final dioClient = DioClient.instance;

    //final taskdetails = <TaskDetails>[].obs;

    var taskdetails = TaskDetails().obs;

    RxString TaskStatus = ''.obs;

  Future<void>  ShowTaskDetails(String uid)async{

    try {

      change(null, status: RxStatus.loading());

      final response = await dioClient.get("/api/v1/tasks/${uid}");


      final result = TaskDetailsResponse.fromJson(response);

      if(result.status==true){

    //    final list = result.data ?? [];

        taskdetails(result.data);
        change(result.data, status: RxStatus.success());

      }else {

        Toast.errorToast("${result.message}");

      }

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }


  Future<void> StartTaskTacking(int uid,int value)async{

    try {

      final result = await dioClient.put("/api/v1/tasks/${uid}",
         data:{
           "status": value,
      });

      final  response = StartingPointTask.fromJson(result.data);

      if(response.status==true){

      //  debugPrint("${response.data!.statusI}");

        Toast.successToast("${response.message}");

      }else{

        Toast.errorToast("Error1:${response.message}");
      }
    } catch(e) {

      Toast.errorToast("Error2:${e.toString()}");

      debugPrint(e.toString());

    }
  }
}