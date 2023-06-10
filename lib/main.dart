import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/auth/login_screen.dart';
import 'package:technician_tracker/core/features/splash/splash_screen.dart';
import 'package:technician_tracker/core/multilang/app_translations.dart';
import 'package:technician_tracker/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';

void main() async{

  await GetStorage.init();

  runApp(MyApp());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..backgroundColor = Colors.white
    ..indicatorColor = HexColor("#855EA9")
    ..textColor = Colors.black
    ..maskColor = Colors.white.withOpacity(0.8);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    //bn
    final storage = GetStorage();

    return OKToast(
      child: GetMaterialApp(
        locale:  Locale("${storage.read("key")==null?"bn":storage.read("key")}", "${storage.read("key")==null?"BD":"US"}"),
        translations: AppTranslations(),
        debugShowCheckedModeBanner: false,
         theme: AppTheme.lightTheme(),
        themeMode: ThemeMode.light,
        home:SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

