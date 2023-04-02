
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/auth/auth_controller.dart';
import 'package:technician_tracker/core/features/profile/personal_screen.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get_storage/get_storage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  AuthController authController = Get.put(AuthController());

  final storage = GetStorage();

  @override
  void initState() {

    super.initState();
  }

  void logoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to Logout ??"),
        actions: <Widget>[
          TextButton(
            child: Text('no'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();

              setState(() {
                authController.logout();
              });
            },
            child: Text('yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Account",
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
        actions: [

          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              child: Icon(FluentIcons.alert_24_regular),
              radius: 24.0,
              backgroundColor: HexColor("#F5F6FC"),
            ),
          ),
        ],
      ),

      body:Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/user_image.png'),
              backgroundColor: Colors.transparent,
            ),

            SizedBox(
              height: 8,
            ),

            Text("Mr. Samshul Abedin",
                style: textTheme.headlineLarge?.copyWith(
                  color: HexColor('#855EA9'),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 32,
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                //set border radius more than 50% of height and width to make circle
              ),
              elevation: 0.3,
              color: HexColor('#FCFDFF'),
              child: InkWell(
                focusColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                onTap: (){
                  //  PersonalScreen();
                  Get.to(PersonalScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [

                          CircleAvatar(
                            backgroundColor:  HexColor('#F5F6FC'),
                            radius: 16,
                            child: Icon(
                              FluentIcons.person_24_regular,size: 16,
                            ),
                          ),

                          SizedBox(width: 16,),

                          Text("Personal Account",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#5C5D72'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),

                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.3,
              color: HexColor('#FCFDFF'),
              child: InkWell(
                focusColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                onTap: (){
                  logoutDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor:  HexColor('#FCFDFF'),
                              radius: 16,
                              child:  Icon(Icons.settings,size: 16,)
                          ),

                          SizedBox(
                            width: 16,
                          ),
                          Text("Setting",
                              style: textTheme.headlineLarge?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),


                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.3,
              color: HexColor('#FCFDFF'),
              child: InkWell(
                focusColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                onTap: (){
                  logoutDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor:  HexColor('#FFEDED'),
                              radius: 16,
                              child:  Icon(Icons.logout,size: 16,)
                          ),

                          SizedBox(
                            width: 16,
                          ),
                          Text("LogOut",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#FF6464'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),


                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    ));
  }
}
