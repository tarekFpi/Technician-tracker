import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#FAFDFC"),
          title: Text("Personal Account",style: textTheme.bodySmall?.copyWith(
              color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
        ),
        backgroundColor: Colors.white,
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

                    Center(
                      child: CircleAvatar(
                        child: Image.asset("assets/images/user_image.png"),
                        radius: 50.0,
                        backgroundColor: HexColor("#F5F6FC"),
                      ),
                    ),


                    ListTile(
                      title: Text("Full Name"),
                    ),
                    Card(
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter  Full Name';
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
                            hintText: "Full Name",
                            prefixIcon: Icon(FluentIcons.person_24_regular,color: Colors.black38)

                        ),

                      ),
                    ),

                    ListTile(
                      title: Text("Email"),
                    ),
                    Card(
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter  Email';
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
                            hintText: "Your  Email",
                            prefixIcon: Icon(Icons.email,color: Colors.black38)

                        ),

                      ),
                    ),

                    ListTile(
                      title: Text("Joining Date"),
                    ),
                    Card(
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Joining  Date';
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
                            hintText: "Joining  Date",
                            prefixIcon: Icon(Icons.date_range,color: Colors.black38)

                        ),

                      ),
                    ),

                    ListTile(
                      title: Text("Address"),
                    ),
                    Card(
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter valid Address';
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
                            hintText: "Your User Address",
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

              //   LoginValidator();
            },
            child: Text('Update',style: textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightColorScheme!.onPrimary)),
          ),
        ),
      ),);
  }
}
