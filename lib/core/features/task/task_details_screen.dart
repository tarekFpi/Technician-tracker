
import 'package:flutter/material.dart';
import 'package:technician_tracker/core/theme/color_scheme.dart';
import 'package:technician_tracker/core/utils/hexcolor.dart';
import 'package:get/get.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({Key? key}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  void taskDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Complete Task"),
        content: Text("Are you sure? your went to task Complete"),
        actions: <Widget>[
          TextButton(
            child: Text('no'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();

              setState(() {
              });
            },
            child: Text('yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#FAFDFC"),
        title: Text("Task Details",style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
      ),

     body: SizedBox(
       height: 200,
       child: Padding(
         padding: const EdgeInsets.all(4.0),
         child: Card(
           color:  HexColor("#FAFDFC"),
           child: Padding(
             padding: const EdgeInsets.all(4.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 Text(
                   "User Id: 10259",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.onTertiaryContainer,
                       fontSize: 14,
                       fontWeight: FontWeight.bold),
                 ),
                 SizedBox(
                   height: 4,
                 ),
                 Text(
                   "Name:Mehedi Hasan Tarek",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.onTertiaryContainer,
                       fontSize: 14,
                       fontWeight: FontWeight.bold),
                 ),
                 SizedBox(
                   height: 4,
                 ),
                 Text(
                   "Ownar : Jamal",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.error,
                       fontSize: 14,
                       fontWeight: FontWeight.bold),
                 ),
                 SizedBox(
                   height: 4,
                 ),
                 Text(
                   "Date: 1-2-2023,10:23 am",
                   style: textTheme.bodySmall?.copyWith(
                       color: lightColorScheme.error,
                       fontSize: 12,
                       fontWeight: FontWeight.w500),
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
         ),
       ),
     ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        child: SizedBox(
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

              taskDialog();
            },
            child: Text('Submit',style: textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: lightColorScheme!.onPrimary)),
          ),
        ),
      ),
    );
  }
}
