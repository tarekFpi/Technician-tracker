import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/auth/auth_controller.dart';
import 'package:technician_tracker/core/features/auth/login_screen.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


final storage = GetStorage();

final authController = Get.put(AuthController());


  @override
  void initState() {

    checkAuthState();

    super.initState();
  }

void checkAuthState() async {

  Timer(Duration(seconds: 3), () {

    if(authController.isLoggedIn()){

      Get.offAll(() => NavScreen());

    }else{
      Get.offAll(() => LoginScreen());

    }
  });

}



@override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body:Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height:300,
                  child: Lottie.asset("assets/animation/tracking.json")
              ),
              Text("Welcome to Technician Tracker Apps",style: TextStyle(fontSize: 21,color: HexColor('#855EA9'),fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}

