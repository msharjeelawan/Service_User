import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
// import 'package:mutwaffer_user/Screens/job_confirm_screen.dart';
import 'package:mutwaffer_user/Screens/order_status_screen.dart';

class JobWidget extends StatelessWidget {
  final _state=_JobWidgetState();
  JobWidget({Key? key,required List<Job> list,required String screenType}) : super(key: key){
    _state.list=list;
    _state.screenType=screenType;
  }

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _state.list.length,
        itemBuilder: (context,index){
          var job=_state.list[index];
          // if(index==0) {
          //   return const Text("Today",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
          // } else if(index==2) {
          //   return const Padding(
          //     padding: EdgeInsets.only(top: 20.0),
          //     child: Text("Upcomming",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          //   );
          // } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                tileColor: Constant.tileBGColor,
                minVerticalPadding: 10,
                onTap: (){
                  // if(job.status==JobType.quoted.value){
                  //   _state.approveQuotationDialog(context,job);
                  // }else{
                    var route = MaterialPageRoute(builder: (context){
                      return OrderStatusScreen(job: job,);
                    });

                    Navigator.push(context, route);
                 // }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.buyerName,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold),),
                    Text(job.service,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    Text(job.orderCreatedTime.split(".").first),
                  ],
                ),
                trailing: SizedBox(
                  width: width*0.32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Job#${job.jobNo}",style:TextStyle(color: Constant.tilelefttext,fontSize: 15),),
                      Text("${job.buyerAddress.split(",")[0]}.",maxLines: 1,style:TextStyle(color: Constant.tilelefttext,fontSize: 13,fontWeight: FontWeight.bold,),),
                      Text(job.status,style:TextStyle(color: Constant.primaryColor),),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            );
         // }
        });
  }
}


class _JobWidgetState{
  List<Job> list=[];
  String screenType="";

  void approveQuotationDialog(context,Job job){
    showDialog(context: context,barrierDismissible: false, builder: (context){
      return  AlertDialog(
        title: Text("Vendor Quotation",style: TextStyle(color: Constant.tilelefttext),),
        content: Column(
          children: [
            Text("Job Detail",style: TextStyle(color: Constant.tilelefttext),),
            Text(job.quotation),
            Row(
              children: [
                Text("Quoted Amount:",style: TextStyle(color: Constant.tilelefttext),),
                Text("RO 50"),
              ],
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text("Later")
          ),
          ElevatedButton(
              onPressed: (){
                DatabaseReference ref = FirebaseDatabase.instance.ref("orders").child(job.firebaseId);
                ref.update({"status":"approved"});
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
              ),
              child: const Text("Submit")
          )
        ],
      );
    });
  }
}

