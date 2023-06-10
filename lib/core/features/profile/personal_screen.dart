import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/features/profile/profile_controller.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:technician_tracker/core/utils/toast.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {

  ProfileController profileController = Get.put(ProfileController());

  final fullNameTextEditing = TextEditingController();

  final emailTextEditing = TextEditingController();

  final joinDateTextEditing = TextEditingController();

  final addressTextEditing = TextEditingController();

  final phoneTextEditing = TextEditingController();

  TextEditingController dateInputController = TextEditingController();

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }


  @override
  void initState() {


    fullNameTextEditing.text = profileController.nameTextEditing.value.text;

    emailTextEditing.text = profileController.emailTextEditing.value.text;

    addressTextEditing.text = profileController.addressTextEditing.value.text;

    phoneTextEditing.text = profileController.phoneTextEditing.value.text;

    super.initState();
  }

  void ValidationUserInformation() {

    if(fullNameTextEditing.text==''){

      Toast.errorToast("Please Your Full Name!!");

    }else if(emailTextEditing.text==''){

      Toast.errorToast("Please Your Email!!");

    }else if(phoneTextEditing.text==''){

      Toast.errorToast("Please Your Phone Number!!");

    }else if(addressTextEditing.text==''){

      Toast.errorToast("Please Your Address!!");

    }else{

       String fullName =fullNameTextEditing.text.toString().trim();

       String email = emailTextEditing.text.toString().trim();

       String phone = phoneTextEditing.text.toString().trim();

       String address =addressTextEditing.text.toString().trim();

      profileController.UpdateProfile(fullName,email,phone,address);
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
          title: Text("personal_account".tr,style: textTheme.bodySmall?.copyWith(
              color: HexColor('#855EA9'), fontSize: 18,fontWeight: FontWeight.w500),),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: CircleAvatar(
                        child: Image.asset("assets/images/user_image.png"),
                        radius: 50.0,
                        backgroundColor: HexColor("#F5F6FC"),
                      ),
                    ),


                    ListTile(
                      title: Text("ফুল নাম"),
                    ),
                    Card(
                      child: TextFormField(
                        controller: fullNameTextEditing,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                            filled: true,
                            hintText: "ফুল নাম",
                            prefixIcon: Icon(FluentIcons.person_24_regular,color: Colors.black38)

                        ),

                      ),
                    ),

                    ListTile(
                      title: Text("ইমেইল"),
                    ),
                    Card(
                      child: TextFormField(
                        controller: emailTextEditing,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                            filled: true,
                            hintText: "তোমার ইমেইল",
                            prefixIcon: Icon(Icons.email,color: Colors.black38)

                        ),

                      ),
                    ),

                    ListTile(
                      title: Text("ফোন"),
                    ),
                    Card(
                      child: TextFormField(
                        controller: phoneTextEditing,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                            filled: true,
                            hintText: "তোমার ফোন",
                            prefixIcon: Icon(Icons.phone,color: Colors.black38)
                        ),
                      ),
                    ),

                    ListTile(
                      title: Text("ঠিকানা"),
                    ),

                    Card(
                      child: TextFormField(
                        controller: addressTextEditing,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'বৈধ ঠিকানা লিখুন';
                          }
                          return null;
                        }, onChanged: (value) {
                        setState(() {

                        });
                      },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            fillColor: Colors.white38,
                            filled: true,
                            hintText: "আপনার ঠিকানা",
                            prefixIcon: Icon(FluentIcons.add_12_regular,color: Colors.black38)

                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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

              ValidationUserInformation();
            },
            child: Text('আপডেট',style: textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightColorScheme!.onPrimary)),
          ),
        ),
      ),);
  }


}
