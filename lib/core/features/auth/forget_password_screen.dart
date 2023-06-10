import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:technician_tracker/core/features/auth/auth_controller.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';

class ForgetPasswrodScreen extends StatefulWidget {
  const ForgetPasswrodScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswrodScreen> createState() => _ForgetPasswrodScreenState();
}

class _ForgetPasswrodScreenState extends State<ForgetPasswrodScreen> {

  bool obscureText_Previus = true;
  bool obscureText_NewPin = true;
  bool obscureText_Confirm = true;

  String? previus_pin;

  String? new_pin;

  String? con_pin;


  final formKey = GlobalKey<FormState>();

  void togglePreviusPasswordVisibility() {
    setState(() {
      obscureText_Previus = !obscureText_Previus;
    });
  }

  void toggleNewPasswordVisibility() {
    setState(() {
      obscureText_NewPin = !obscureText_NewPin;
    });
  }


  void toggleConfirmPasswordVisibility() {
    setState(() {
      obscureText_Confirm = !obscureText_Confirm;
    });
  }

  AuthController authController = Get.put(AuthController());

  void ForgetPasswordValidator(){

    if (formKey.currentState!.validate()) {

      authController.ForgetPasswrod(previus_pin, new_pin,con_pin);
    }
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(

        child: Scaffold(
          backgroundColor:colorScheme.surfaceVariant,
          appBar: AppBar(
            backgroundColor:colorScheme.surface,
            elevation: 2,
            centerTitle: true,
            title: Text(
              "Forget",
              style: textTheme.titleMedium?.copyWith(
                  color: lightColorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

          ),

          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 32,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/animation/otp.json",width: 300, height: 200)),

                  SizedBox(
                    height: 16,
                  ),

                  Text(
                    "Forget Password",
                    style: textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ListTile(
                          title: Text("Previous Pin"),
                        ),
                        Card(
                          child: TextFormField(
                            initialValue: previus_pin,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Previous Pin';
                              }
                              return null;
                            }, onChanged: (value) {
                            setState(() {
                              previus_pin = value;
                            });
                          },
                            decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              hintText: "Your Previous Pin",
                              prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText_Previus ? Icons.visibility : Icons.visibility_off,
                                    color: HexColor('#855EA9'),
                                  ),
                                  onPressed: togglePreviusPasswordVisibility),
                            ),

                            keyboardType: TextInputType.text,
                            obscureText: obscureText_Previus,
                          ),
                        ),


                        ListTile(
                          title: Text("New Pin"),
                        ),
                        Card(
                          child: TextFormField(
                            initialValue: new_pin,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter New Pin';
                              }
                              return null;
                            }, onChanged: (value) {
                            setState(() {
                              new_pin = value;
                            });
                          },
                            decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              hintText: "Your New Pin",
                              prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText_NewPin? Icons.visibility : Icons.visibility_off,
                                    color: HexColor('#855EA9'),
                                  ),
                                  onPressed: toggleNewPasswordVisibility),
                            ),

                            keyboardType: TextInputType.text,
                            obscureText: obscureText_NewPin,
                          ),
                        ),

                        ListTile(
                          title: Text("Confirm  Pin"),
                        ),
                        Card(
                          child: TextFormField(
                            initialValue: con_pin,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Confirm Pin';
                              }
                              return null;
                            }, onChanged: (value) {
                            setState(() {
                              con_pin = value;
                            });
                          },
                            decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              hintText: "Your Confirm Pin",
                              prefixIcon: Icon(Icons.lock_outline_rounded,color: HexColor('#855EA9'),),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText_Confirm ? Icons.visibility : Icons.visibility_off,
                                    color: HexColor('#855EA9'),
                                  ),
                                  onPressed: toggleConfirmPasswordVisibility),
                            ),

                            keyboardType: TextInputType.text,
                            obscureText: obscureText_Confirm,
                          ),
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

                              ForgetPasswordValidator();
                            },
                            child: Text('Forget',style: textTheme.bodyLarge?.copyWith(
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
