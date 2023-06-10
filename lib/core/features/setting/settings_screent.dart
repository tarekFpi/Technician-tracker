
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get_storage/get_storage.dart';

class SettingScreent extends StatefulWidget {
  const SettingScreent({Key? key}) : super(key: key);

  @override
  State<SettingScreent> createState() => _SettingScreentState();
}

class _SettingScreentState extends State<SettingScreent> {

  int selectedRadio = 0;

  String status = "";

  final storage = GetStorage();

  void  LanguageDialog() {

    showDialog<void>(
        context: context,
        builder: (BuildContext context)=>
        AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              clipBehavior: Clip.none,
              children: [

                 Positioned(
                    right:-20,
                    top: -20,
                     child: IconButton(onPressed: (){
                       Navigator.of(context).pop();
                     }, icon: Icon(Icons.close))),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      RadioListTile(
                        title: Text("Bangla"),
                        value: "Bangla",
                        groupValue: status,
                        onChanged: (value){
                          setState(() {

                            status =value!;
                             Get.updateLocale(Locale('bn','BD'));

                            storage.write("key","bn");
                             Navigator.of(context).pop();
                          });
                        },
                      ),

                      RadioListTile(
                        title: Text("English"),
                        value: "English",
                        groupValue: status,
                        onChanged: (value){
                          setState(() {
                             status =value!;
                             Get.updateLocale(Locale('en','Us'));
                             storage.write("key","en");
                             Navigator.of(context).pop();
                          });
                        },
                      ),
                    ],
                ),
                  )
              ],
            );
          },
        ),
      )
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
          "setting".tr,
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(left: 8, right: 8,top: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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

                  LanguageDialog();
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
                              FluentIcons.local_language_24_regular,size: 16,
                            ),
                          ),

                          SizedBox(width: 16,),

                          Text("change_language".tr,
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
          ],
        ),
      ),
    ));
  }
}
