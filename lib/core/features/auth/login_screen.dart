import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:technician_tracker/core/features/auth/forget_password_screen.dart';
import 'package:technician_tracker/core/features/auth/auth_controller.dart';
import 'package:technician_tracker/core/features/nav/home/home_screen.dart';
import 'package:technician_tracker/core/features/nav/nav_screen.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool obscureText = true;
  String? pin;
  String? phone;
  bool rememberPassword = false;

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  final authController = Get.put(AuthController());

  void LoginValidator(){

    if (formKey.currentState!.validate()) {

      authController.login(phone, pin);

     // Get.off(NavScreen());
    }
  }

  @override
  void initState() {

    checkRememberPassword();
    super.initState();
  }

  final storage = GetStorage();

  void checkRememberPassword() {
    final savePhone = storage.read("phone");
    final savePin = storage.read("pin");

    setState(() {
      if (savePhone != null && savePin != null) {
        phone = savePhone;
        pin = savePin;
        rememberPassword = true;
      } else {
        rememberPassword = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
         backgroundColor:colorScheme.surfaceVariant,
         body: SingleChildScrollView(
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
              height: 30,
              ),
              Align(
                alignment: Alignment.center,
                  child: Lottie.asset("assets/animation/login.json",width: 300, height: 200)),

              Text(
                "login_title".tr,
                style: textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "sub_title".tr,
                style: textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: TextFormField(
                        initialValue: phone,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Your Phone';
                          }
                          return null;
                        }, onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                             filled: true,
                             hintText: "Enter  Phone",
                            prefixIcon: Icon(FluentIcons.person_24_regular,color: Colors.black38)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    Card(
                      child: TextFormField(
                        initialValue: pin,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter Your Pin';
                          }
                          return null;
                        }, onChanged: (value) {
                        setState(() {
                          pin = value;
                        });
                       },
                         decoration: InputDecoration(
                           fillColor: Colors.white38,
                           filled: true,
                          contentPadding: EdgeInsets.all(16),
                           hintText: "Enter Pin",
                          prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                          suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility : Icons.visibility_off,
                                color: HexColor('#855EA9'),
                              ),
                              onPressed: togglePasswordVisibility),
                        ),

                        keyboardType: TextInputType.number,
                        obscureText: obscureText,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            onTap: () {
                              setState(() {
                                rememberPassword = !rememberPassword;
                              });
                            },
                            leading: Checkbox(
                              value: rememberPassword,
                              onChanged: (value) {
                                setState(() {
                                  rememberPassword = !rememberPassword;
                                });
                              },
                            ),
                            title:  Text("pin_remember".tr,style: textTheme.titleMedium?.copyWith(
                                color: Colors.black87,
                                 fontSize: 14,
                                fontWeight: FontWeight.bold)),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            setState(() {
                              rememberPassword = !rememberPassword;
                            });
                          },
                          child: InkWell(
                            onTap: (){

                        Get.to(ForgetPasswrodScreen());
                            },
                              child:  Text("forgot_password".tr)),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 16,
                    ),

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

                          LoginValidator();
                        },
                        child: Text('Login',style: textTheme.bodyLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lightColorScheme!.onPrimary)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
        ),
    ));
  }
}
