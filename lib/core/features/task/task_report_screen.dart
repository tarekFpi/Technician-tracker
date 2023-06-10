import 'package:flutter/material.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:get/get.dart';

class TaskReportScreen extends StatefulWidget {
  const TaskReportScreen({Key? key}) : super(key: key);

  @override
  State<TaskReportScreen> createState() => _TaskReportScreenState();
}

class _TaskReportScreenState extends State<TaskReportScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("টাস্ক রিপোর্ট",style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            
            Card(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white38,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  hintText: "Search...Date ,Status",
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor('#855EA9'),
                  ),

                ),
                keyboardType: TextInputType.text,
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context,index){
                    return Card(
                      color:  HexColor("#FAFDFC"),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    "Task Id: 10259",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: lightColorScheme.onTertiaryContainer,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Subject:Commdo Apps",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: lightColorScheme.onTertiaryContainer,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Status:SuccessFull",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: lightColorScheme.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Date: 1-2-2023,10:23 am",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: lightColorScheme.error,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Location : Police Plaza Concord shopping mall, Dhaka 1212",
                                    style: textTheme.bodySmall?.copyWith(
                                        color: lightColorScheme.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
