
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/auth/auth_controller.dart';
import 'package:technician_tracker/core/features/profile/personal_screen.dart';
import 'package:technician_tracker/core/features/profile/profile_controller.dart';
import 'package:technician_tracker/core/features/setting/settings_screent.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:technician_tracker/core/utils/toast.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  AuthController authController = Get.put(AuthController());

  ProfileController profileController = Get.put(ProfileController());

  final storage = GetStorage();

  @override
  void initState() {

  profileController.ShowProfile();

    super.initState();
  }

  void logoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("লগআউট নিশ্চিত করুন"),
        content: Text("আপনি লগ আউট করতে চান ??"),
        actions: <Widget>[
          TextButton(
            child: Text('না'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();

              setState(() {
                authController.logout();
              });
            },
            child: Text('হ্যাঁ'),
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
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "account_info".tr,
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),

      body:Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 12,
            ),

            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/user_image.png'),
              backgroundColor: Colors.transparent,
            ),

            SizedBox(
              height: 8,
            ),

           Obx(() => Text("${profileController.UserName.value}",
               style: textTheme.headlineLarge?.copyWith(
                 color: HexColor('#855EA9'),
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
               ))),

            SizedBox(
              height: 32,
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

                          Text("personal_info".tr,
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
                 //  Get.updateLocale(Locale('en','Us'));
                  Get.to(SettingScreent());
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
                          Text("setting".tr,
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
                          Text("logout".tr,
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
