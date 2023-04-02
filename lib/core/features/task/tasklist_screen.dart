
 import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/task/task_details_screen.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
 import 'package:get/get.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#FAFDFC"),
        title: Text("Task List",style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
      ),

      body: Container(
        margin: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Card(
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white38,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  hintText: "Search...Here",
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor('#855EA9'),
                  ),

                ),
                keyboardType: TextInputType.text,
              ),
            ),

          SizedBox(
            height: 16,
          ),
            SizedBox(
              height: 50,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Id",
                        style: textTheme.bodySmall?.copyWith(
                            color: lightColorScheme.onTertiaryContainer,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),

                      Text(
                        "Date",
                        style: textTheme.bodySmall?.copyWith(
                            color: lightColorScheme.onTertiaryContainer,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Task",
                        style: textTheme.bodySmall?.copyWith(
                            color: lightColorScheme.onTertiaryContainer,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context,index){
                    return SizedBox(
                      height: 100,
                      child: InkWell(
                        onTap: (){

                          Get.to(TaskDetails());
                        },
                        child: Card(
                          color:  HexColor("#FAFDFC"),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  "10259",
                                  style: textTheme.bodySmall?.copyWith(
                                      color: lightColorScheme.onTertiaryContainer,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),



                                Text(
                                  "1-2-2023,10:23 am",
                                  style: textTheme.bodySmall?.copyWith(
                                      color: lightColorScheme.error,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),

                                Text(
                                  "V4",
                                  style: textTheme.bodySmall?.copyWith(
                                      color: lightColorScheme.primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
