
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:technician_tracker/core/features/task/model/starting_point_task.dart';
import 'package:technician_tracker/core/features/task/model/tasklist_response.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:technician_tracker/core/utils/toast.dart';

class TasklistController extends GetxController with StateMixin<List<TaskResponse>> {

  final dioClient = DioClient.instance;

  final tasklist = <TaskResponse>[].obs;

  final RxInt listLength = 0.obs;



  Future<void> ShowTasklist() async{

    try {

      change(null, status: RxStatus.loading());

      final res = await dioClient.get("/api/v1/tasks");


      final task_response = TasklistResponse.fromJson(res);

      if(task_response.status==true){

        final list = task_response.data ?? [];

         tasklist.assignAll(list);

        change(tasklist, status: RxStatus.success());

        listLength(list.length);

        if(tasklist.isEmpty){

          change(null, status: RxStatus.empty());
        }

      }else {

        Toast.errorToast("${task_response.message}");

      }

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void filterTask(String? query) {

    change(null, status: RxStatus.loading());

    if (query == null || query.isEmpty) {

      change(tasklist.value, status: RxStatus.success());

    }else{

      try{

        debugPrint("result:${query}");

        final list = tasklist.value
            .where((element) =>
        element.priority!.name!
            .toLowerCase()
            .contains(query!.toLowerCase().trim())
             ).toList();

        listLength(list.length);

        if(list.isEmpty){

          change([], status: RxStatus.empty());

        }else {
          change(list, status: RxStatus.success());
        }

      }catch(e){

        debugPrint(e.toString());
      }
    }

  }





}