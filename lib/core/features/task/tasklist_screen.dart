
 import 'package:flutter/material.dart';
import 'package:technician_tracker/core/features/task/model/tasklist_response.dart';
import 'package:technician_tracker/core/features/task/task_controller.dart';
import 'package:technician_tracker/core/features/task/task_details_screen.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technician_tracker/core/widgets/custom_error_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  final taskListController = Get.put(TasklistController());

  var priority_colors;

  var status_colors;

  var ChooseChip="";

  @override
  void initState() {
    super.initState();

    taskListController.ShowTasklist();
  }

  void goToDetails(TaskResponse taskResponse){

    FocusScope.of(context).unfocus();


   Get.to(() => TaskDetails(
     tasklist: taskResponse,
    ));

  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("টাস্ক লিস্ট"
       ,style: textTheme.bodySmall?.copyWith(
            color: HexColor('#855EA9'), fontSize: 18,fontWeight: FontWeight.w500),),
      ),

      body: Container(
        margin: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(
                  width: 8,
                ),

                ChoiceChip(
                  label: Text('${ChooseChip=="All"?"All (${taskListController.listLength})":'All'}',style: TextStyle(fontSize: 10),),
                  selected: (ChooseChip=="All")?true:false,
                  selectedColor: darkColorScheme.surfaceTint,
                  backgroundColor:darkColorScheme.onBackground,
                  onSelected: (bool value) {
                    setState(() {
                      ChooseChip ="All";

                      taskListController.ShowTasklist();
                    });
                  },
                ),

                 SizedBox(
                  width: 8,
                  ),

                ChoiceChip(
                  label: Text('${ChooseChip=="High"?"High (${taskListController.listLength})":'High'}',style: TextStyle(fontSize: 10),),
                  selected: (ChooseChip=="High")?true:false,
                  selectedColor: darkColorScheme.surfaceTint,
                  backgroundColor: darkColorScheme.onBackground,
                  onSelected: (bool value) {
                    setState(() {
                      ChooseChip ="High";
                      taskListController.filterTask(ChooseChip);
                    });
                  },
                ),


                SizedBox(
                  width: 8,
                ),

                ChoiceChip(
                  label: Text('${ChooseChip=="Medium"?"Medium (${taskListController.listLength})":'Medium'}',style: TextStyle(fontSize: 10),),
                  selected: ChooseChip=="Medium"?true:false,
                  selectedColor: darkColorScheme.surfaceTint,
                  backgroundColor: darkColorScheme.onBackground,
                  onSelected: (bool value) {
                   setState(() {
                     ChooseChip ="Medium";
                     taskListController.filterTask(ChooseChip);
                   });
                  },
                ),

                SizedBox(
                  width: 8,
                ),

                ChoiceChip(
                  label: Text('${ChooseChip=="Low"?"Low (${taskListController.listLength})":'Low'}',style: TextStyle(fontSize: 10),),
                  selected: ChooseChip=="Low"?true:false,
                  selectedColor: darkColorScheme.surfaceTint,
                  backgroundColor: darkColorScheme.onBackground,
                  onSelected: (bool value) {
                    setState(() {
                      ChooseChip ="Low";
                      taskListController.filterTask(ChooseChip);
                    });
                  },
                ),

              ],
            ),


            Expanded(
              child: taskListController.obx((state) => RefreshIndicator(
                onRefresh:taskListController.ShowTasklist,
                child: ListView.builder(
                    itemCount: state!.length,
                    itemBuilder: (BuildContext context,index){

                      final item = state[index];

                      if(state[index].priority!.name=="High"){

                        priority_colors=darkColorScheme.error;
                      }

                      if(state[index].priority!.name=="Medium"){

                        priority_colors= Colors.yellow;
                      }

                      if(state[index].priority!.name=="Low"){

                        priority_colors=darkColorScheme.primary;
                      }



                         if(state[index].status?.name=="InProgress"){

                          status_colors=Colors.lightGreenAccent;
                        }

                        if(state[index].status?.name=="Completed"){

                          status_colors= darkColorScheme.primary;
                        }

                        if(state[index].status?.name=="Cancelled"){

                          status_colors=darkColorScheme.tertiary;
                        }

                        if(state[index].status?.name=="Assigned"){

                          status_colors=Colors.redAccent;
                        }

                      return SizedBox(
                        height: 200,
                        child: InkWell(
                          onTap: (){

                            goToDetails(item);
                          },
                          child: Card(
                            color:  HexColor("#FAFDFC"),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    height: 4,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Expanded(
                                        child: Text(
                                          "${state[index].title}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                       Card(
                                        color: status_colors,
                                          elevation: 0.2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14.0),
                                          ),
                                           child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "${state[index].status?.name}",
                                              style: textTheme.bodySmall?.copyWith(
                                                  color: lightColorScheme.onSecondaryContainer,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                      )
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Card(
                                           color:priority_colors,
                                          elevation: 0.2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${state[index].priority!.name}",
                                              style: textTheme.bodySmall?.copyWith(

                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                      ),

                                      SizedBox(
                                        width: 4,
                                      ),

                                      Card(
                                          elevation: 0.2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${state[index].category!.name}",
                                              style: textTheme.bodySmall?.copyWith(
                                                  color: lightColorScheme.onSecondaryContainer,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                              child: Icon(Icons.arrow_drop_down_circle,size: 24,)),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${state[index].description}",
                                      style: textTheme.bodySmall?.copyWith(
                                          color: lightColorScheme.onTertiaryContainer,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Icon(Icons.date_range_outlined,size: 18,),

                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${state[index].date}",
                                        style: textTheme.bodySmall?.copyWith(
                                            color: lightColorScheme.error,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

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
                      taskListController.ShowTasklist();
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
