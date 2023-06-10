import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/nav/home/home_screen.dart';
import 'package:technician_tracker/core/features/profile/account_screen.dart';
import 'package:technician_tracker/core/features/task/tasklist_screen.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {

  int currentPageIndex = 1;


  List<Widget> pages =   [
    TaskListScreen(),
    HomeScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {

  var pageIndex = Get.arguments;

   if(pageIndex==2){
      currentPageIndex = 2;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: pages[currentPageIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 8,
              ),
            ],
          ),
          child: NavigationBar(
           // backgroundColor: lightColorScheme.surfaceVariant,
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.white,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.list),
                selectedIcon: Icon(
                  FluentIcons.list_16_filled,
                  color: Colors.white,
                ),
                label: 'লিস্ট',
              ),
              NavigationDestination(
                icon: Icon( FluentIcons.home_20_filled),
                label: 'হোম',
                selectedIcon: Icon(
                  FluentIcons.home_20_filled,
                  color: Colors.white,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle),
                selectedIcon: Icon(
                   Icons.account_circle,
                  color: Colors.white,
                ),
                label: 'প্রোফাইল',
              ),
            ],
          ),
        )
    );
  }
}
