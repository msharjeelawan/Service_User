import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Models/notification_model.dart';
import 'package:mutwaffer_user/Screens/dashboard_screen.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'order_status_screen.dart';

class NotificationScreen extends StatelessWidget {
  static NotificationState? state=NotificationState();
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    List<Notifications> notification;
    return ChangeNotifierProvider<NotificationState>(
      create: (context) => NotificationScreen.state!,
      child: Consumer<NotificationState>(
        builder: (context,state,child){
          notification = Notifications.getList;
          return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: width,
                height: 100,
                color:Constant.walletContainerBG,
                padding: const EdgeInsets.only(left: 20,right:20,top: 10),
                //  decoration: BoxDecoration(,border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(LocaleKeys.Drawer_Notifications.tr(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    TextButton(
                        onPressed: (){
                          state.clearNotifications();
                        },
                        style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(Constant.black),
                            elevation: MaterialStateProperty.all(5),
                            backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                            fixedSize: MaterialStateProperty.all(Size(width*0.55, height*0.07)),
                            //shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  Text(
                          LocaleKeys.Notifications_Clearallnotifications.tr(),
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                        )
                    ),
                  ],
                )
            ),
            ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: notification.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                        color: Constant.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color:  Colors.black54,blurRadius: 5,offset: Offset(5, 5))
                        ]
                    ),
                    child: ListTile(
                    //  tileColor: Constant.white,
                      onTap: (){
                        var tempJob;
                       if(notification[index].title==NotificationType.completed.value || notification[index].title==NotificationType.thanks.value ){
                          for (var job in Job.completedJobList) {
                            if(notification[index].time==job.orderCreatedTime){
                              tempJob=job;
                              break;
                            }
                          }
                        }else if(notification[index].title==NotificationType.cancelled.value){
                          for (var job in Job.cancelledJobList) {
                            if(notification[index].time==job.orderCreatedTime){
                              tempJob=job;
                              break;
                            }
                          }
                        }else{
                          for (var job in Job.newJobList) {
                            if(notification[index].time==job.orderCreatedTime){
                              tempJob=job;
                              break;
                            }
                          }
                        }

                        var route = MaterialPageRoute(builder: (context){
                          return OrderStatusScreen(job: tempJob);
                        });
                        Navigator.push(context, route);
                      },
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:   [
                          Text(notification[index].title,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold),),
                          Text("${LocaleKeys.MainItems_JobNumber.tr()}${notification[index].trailingTitle}",maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext),),
                        ],
                      ),
                      subtitle:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text(notification[index].subTitle,maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold,color: Constant.black),),
                          const SizedBox(width: 5,),
                          Flexible(child: Text("${notification[index].trailingSubTitle}.",maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext),)),
                        ],
                      ),
                      // trailing:  Text("Job#0046        ",style:TextStyle(color: Constant.tilelefttext,fontSize: 15),),
                     // shape: RoundedRectangleBorder(
                     //     borderRadius: BorderRadius.circular(20)
                     // ),
                    ),
                  );

                })
          ],
        ),
      ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Constant.primaryColor,
                selectedItemColor: Constant.white,
                unselectedItemColor: Constant.white,
                selectedIconTheme: IconThemeData(color: Constant.black),
                unselectedIconTheme: const IconThemeData(color: Colors.black54),
                onTap: (index){
                  Navigator.popUntil(context, (route){
                    if(route.settings.name=="/home"){
                      HomeScreen.state.bottomNavigationIndex=index;
                      HomeScreen.state.updateScreen();
                      return true;
                    }
                    return false;
                  });
                  },
                items: [
                 BottomNavigationBarItem(icon: Icon(Icons.home),label: LocaleKeys.Drawer_Home.tr()),
                  BottomNavigationBarItem(icon: Stack(
                    children: [
                      Notifications.getList.isNotEmpty?
                      const Positioned(top:0,right:0,child: Icon(Icons.fiber_manual_record,size: 12,color: Colors.red,))
                          :
                      const SizedBox(),
                      const Icon(Icons.access_time),
                    ],
                  ),label:LocaleKeys.MainScreenUser_Dashboard.tr()),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label:LocaleKeys.MainScreenUser_Profile.tr())
                ]
            ),
          );
          },
      ),
    );
  }
}


class NotificationState with ChangeNotifier{

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose(){

  }


  void clearNotifications(){

    Notifications.getList.forEach((notification) async {
      await FirebaseDatabase.instance.ref("orders").child(notification.jobId).update({"isNotificationView":true});
      Notifications.getList.remove(notification);
      updateScreen();
      DashboardScreen.state.updateScreen();
      HomeScreen.state.updateScreen();
    });

  }
}