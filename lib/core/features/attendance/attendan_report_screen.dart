
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/attendance/attendance_report_controller.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {

  final List<String> year = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];

  final List<String> mounth = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'Desember',
  ];

  final attendanceController = Get.put(AttendanceReportController());

  String? selectedYear,selectedMonth;


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Attendance List",style: textTheme.bodySmall?.copyWith(
          color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
        backgroundColor: HexColor("#FAFDFC"),),

      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

               Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                    'Select Year',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: year
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedYear,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value as String;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
               ),
              ),
                ),
              ),

               Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                    'Select Month',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: mounth
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: selectedMonth,
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value as String;
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
            ),
          ),
                ),
              ),

              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor:HexColor('#855EA9'),

                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                onPressed: (){
                },
                child: Text('Search',style: textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: lightColorScheme!.onPrimary)),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Expanded(
                    child: Text
                      (
                      "Date",
                      style: textTheme.bodySmall?.copyWith(
                          color: lightColorScheme.onTertiaryContainer,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "In Time",
                      style: textTheme.bodySmall?.copyWith(
                          color: lightColorScheme.onTertiaryContainer,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "Out Time",
                      style: textTheme.bodySmall?.copyWith(
                          color: lightColorScheme.onTertiaryContainer,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "Status",
                      style: textTheme.bodySmall?.copyWith(
                          color: lightColorScheme.onTertiaryContainer,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),


                ],
              ),
            ),

            SizedBox(
              height: 8,
            ),

            Expanded(
              child: attendanceController.obx((state) {
                return ListView.separated(
                  itemCount: state!.length,
                  itemBuilder: (BuildContext context,index){

                    final item = state![index];

                    return Container(
                     padding:  EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Expanded(
                            child: Text(
                              "${item.date},",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                      SizedBox(
                        width: 8,
                      ),
                          Expanded(
                            child: Text(
                              "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${item.inTime}"))}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "${item.outTime==null?"--":DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${item.outTime}"))}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "${item.status==null?"--":state![index].status}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),


                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {

                  return Divider(
                    color: Colors.black,
                  );
                },);
              }),
            ),
          ],
        ),
      ),
    ));
  }
}
