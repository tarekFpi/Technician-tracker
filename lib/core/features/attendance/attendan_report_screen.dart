
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/attendance/attendance_report_controller.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:technician_tracker/core/utils/toast.dart';
import 'package:technician_tracker/core/widgets/custom_error_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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

  var mounth_index;

    var outTime;

    var inTime;

  bool isAttendanReportRefrsh = false;


  void SearchAttendanReport(){

     if(selectedYear==null){

       Toast.errorToast("Please Year Select !!");

     }else if(selectedMonth==null){

       Toast.errorToast("Please Month Select !!");
     }else{

       mounth_index =  mounth.indexOf(selectedMonth!);

       mounth_index==0?mounth_index=1:mounth_index++;

       String mounth_year ="0${mounth_index}-${selectedYear}";

       attendanceController.FilterAttendanceReport(mounth_year);
     }
  }

  @override
  void initState() {

   attendanceController.ShowAttendanceReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("Attendance_Report".tr,style: textTheme.bodySmall?.copyWith(
          color:HexColor('#855EA9'), fontSize: 18,fontWeight: FontWeight.w500),),
         ),

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

                  SearchAttendanReport();
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
                    child: Center(
                      child: Text(
                        "Status",
                        style: textTheme.bodySmall?.copyWith(
                            color: lightColorScheme.onTertiaryContainer,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(
              height: 8,
            ),

            Expanded(
              child: attendanceController.obx((state) =>state!.isEmpty?Center(child: Text("Data is not found"),): RefreshIndicator(
                onRefresh:attendanceController.ShowAttendanceReport,
                child:  ListView.separated(
                  itemCount: state!.length,
                  itemBuilder: (BuildContext context,index){

                    final item = state![index];

                    inTime = item.inTime;

                    if(inTime!=null){

                      var temp = int.parse(inTime!.split(':')[0]);
                      String? t;
                      if(temp >= 12 && temp <24){
                        t = " PM";
                      }
                      else{
                        t = " AM";
                      }
                      if (temp > 12) {
                        temp = temp - 12;
                        if (temp < 10) {
                          inTime = inTime.replaceRange(0, 2, "$temp");
                          inTime += t;
                        } else {
                          inTime = inTime.replaceRange(0, 2, "$temp");
                          inTime += t;
                        }
                      } else if (temp == 00) {

                        inTime = inTime.replaceRange(0, 2, '12');
                        inTime += t;

                      }else{

                        inTime += t;
                      }
                    }else{

                      inTime ="---";
                    }


                    outTime = item.outTime;

                    if(outTime!=null){

                      var temp_out = int.parse(outTime!.split(':')[0]);
                      String? time;
                      if(temp_out >= 12 && temp_out <24){
                        time = " PM";
                      }
                      else{
                        time = " AM";
                      }
                      if (temp_out > 12) {
                        temp_out = temp_out - 12;
                        if (temp_out < 10) {
                          outTime = outTime.replaceRange(0, 2, "$temp_out");
                          outTime += time;
                        } else {
                          outTime = outTime.replaceRange(0, 2, "$temp_out");
                          outTime +=time;
                        }
                      } else if (temp_out == 00) {

                        outTime = outTime.replaceRange(0, 2, '12');
                        outTime += time;

                      }else{

                        outTime += time;
                      }
                    }else{

                      outTime="---";
                    }

                    return Container(
                      padding:  EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Expanded(
                            child: Text(
                              "${item.date}",
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
                              item.inTime==null?"---":inTime,
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),

//${item.outTime==null?"---":DateFormat.jm().format(DateFormat("hh:mm").parse("${item.outTime}"))}

                          Expanded(
                            child: Center(
                              child: Text(
                                "${outTime}",
                                style: textTheme.bodySmall?.copyWith(
                                    color: lightColorScheme.onTertiaryContainer,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "${item.status==null?"---":state![index].status}",
                                style: textTheme.bodySmall?.copyWith(
                                    color: lightColorScheme.onTertiaryContainer,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),


                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {

                  return Divider(
                    color: Colors.black,
                  );
                },),

              ),onError: (msg) {
                return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                  attendanceController.ShowAttendanceReport();
                    });
              }, ),
            ),
          ],
        ),
      ),

     bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            margin: EdgeInsets.all(4),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.small(
              onPressed: () {
                  attendanceController.ShowAttendanceReport();
                  setState(() {
                  });
              },
              backgroundColor: HexColor('#855EA9'),
              heroTag: UniqueKey(),
              child:  const Icon(Icons.refresh, color: Colors.white),
            ),
          )

        ],
      )
    ));
  }
}
