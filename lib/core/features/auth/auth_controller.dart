
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:technician_tracker/core/features/auth/login_screen.dart';
import 'package:technician_tracker/core/features/auth/model/forget_password_response.dart';
import 'package:technician_tracker/core/features/auth/model/login_response.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/network/dio_client.dart';
import 'package:technician_tracker/core/utils/toast.dart';


 class AuthController extends GetxController{

    final dioClient = DioClient.instance;

   final storage = GetStorage();

   Future login(phone, pin) async{

      EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        try {

       final res = await dioClient.post("/api/v1/login",data:{
         "username": phone,
         "password": pin
       });

       final loginResponse = LoginResponse.fromJson(res.data);

         if(loginResponse.status==true){

         final userToken = loginResponse.data!.token.toString();

         saveToken(userToken,phone,pin);

         Toast.successToast("${loginResponse.message}");

         Get.off(NavScreen());

         EasyLoading.dismiss();

       }else {
         Toast.errorToast("${loginResponse.message}");
         EasyLoading.dismiss();
       }

     } catch(e) {
          Toast.errorToast("${e.toString()}");
           EasyLoading.dismiss();
        }
   }

   Future ForgetPasswrod(previousPin, NewPin,conPin) async{

      EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

      try {

        final res = await dioClient.post("/api/v1/user-password-change",data:{
          "previous_password": previousPin,
          "password": NewPin,
          "password_confirmation": conPin,
        });

        final loginResponse = ForgetPasswordResponse.fromJson(res.data);

        if(loginResponse.message=="Password has been updated successfully!"){

          Toast.successToast("${loginResponse.message}");

          Get.off(LoginScreen());

          EasyLoading.dismiss();

        }else {

          Toast.errorToast("${loginResponse.message}");
          EasyLoading.dismiss();
        }

      } catch(e) {
        Toast.errorToast("${e.toString()}");
        EasyLoading.dismiss();
      }
    }

    void saveToken(token,phone,pin){

      storage.write("user_token", token);
      storage.write("phone",phone);
      storage.write("pin",pin);
    }

    void logout() async {
      try{

        EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

        await dioClient.post("/api/v1/logout");

        Get.offAll(() => const LoginScreen());

        storage.remove("user_token");

        Toast.successToast("LogOut Successfully",);
        EasyLoading.dismiss();

      }catch(e){
        EasyLoading.dismiss();
        Toast.errorToast(e.toString());
      }
    }

    bool isLoggedIn(){
      if(storage.read("user_token") != null) return true;
      return false;
    }
 }