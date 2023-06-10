import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/features/profile/account_screen.dart';
import 'package:technician_tracker/core/features/profile/model/profile_response.dart';
import 'package:technician_tracker/core/features/profile/model/profile_update_response.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


class ProfileController extends GetxController  {

  final dioClient = DioClient.instance;

  final storage = GetStorage();

  final Rx<TextEditingController> nameTextEditing = TextEditingController().obs;

  final Rx<TextEditingController> emailTextEditing = TextEditingController().obs;

  final Rx<TextEditingController> phoneTextEditing = TextEditingController().obs;

  final Rx<TextEditingController> joinTextEditing = TextEditingController().obs;

  final Rx<TextEditingController> addressTextEditing = TextEditingController().obs;

  RxString UserName="".obs;


  @override
  void onInit() {

    ShowProfile();

  }

  Future<void> ShowProfile() async{

    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

    try {

      final res = await dioClient.get("/api/v1/profile");

      final result = ProfileResponse.fromJson(res);

      if(result.status==true){

        nameTextEditing.value.text = result.data!.name.toString();

        emailTextEditing.value.text = result.data!.email.toString();

        addressTextEditing.value.text = result.data!.address.toString();

        phoneTextEditing.value.text = result.data!.mobile.toString();

        storage.write("code", result.data!.code.toString());

        storage.write("userName", result.data!.name.toString());

        UserName.value = result.data!.name.toString();

        print("userName:${UserName.value}");

        EasyLoading.dismiss();

      }else {

        EasyLoading.dismiss();

        Toast.errorToast("${result.message}");
      }

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());
      EasyLoading.dismiss();

    }
  }


  Future<void> UpdateProfile(String fullName, String email, String phone, String address) async{

    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

    var userId =storage.read("code");


     try {

      final res = await dioClient.post("/api/v1/profile",data:{
        "name": fullName,
        "email": email,
        "mobile": phone,
        "code": userId,
        "address": address,
      });

      final result = ProfileUpdateResponse.fromJson(res.data);

      if(result.message=="Profile has been updated successfully!"){

        Toast.successToast("${result.message}");

        storage.write("userName", fullName);

        Get.offAll(NavScreen(),arguments: 2);

        EasyLoading.dismiss();

      }else {

        EasyLoading.dismiss();

        Toast.errorToast("${result.message}");

      }
    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());
      EasyLoading.dismiss();

    }
  }


}