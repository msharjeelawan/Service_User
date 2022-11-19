
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Screens/home_screen.dart';
import 'package:mutwaffer_user/main.dart';

class LocalNotification{

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static void initNotification(){
    var androidSetting = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSetting = const IOSInitializationSettings();
    var settings = InitializationSettings(android: androidSetting,iOS: iosSetting);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin?.initialize(settings,onSelectNotification: (value) async{

     Map<String,dynamic> payload = jsonDecode(value!);
     String jobId = payload["jobId"];
     Query query = FirebaseDatabase.instance.ref("orders").orderByKey().equalTo(jobId);
     query.once().then((event){
       DataSnapshot snapshot = event.snapshot;
       Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
       print(map[jobId]);
       Map<dynamic,dynamic> job = map[jobId];
       bool isAccepted = job["isAccepted"];
       if(!isAccepted){
        // print("job available");
         //job available
         showDialog(
           context: HomeScreen.context!,
           builder: (_) {
             return AlertDialog(
               title: const Text("Job"),
               content: const Text("Do you want to accept job?"),
               actions: [
                 TextButton(onPressed: (){
                   Navigator.pop(HomeScreen.context!);
                   }, child: const Text("Cancel")),
                 TextButton(onPressed: (){
                   var ref = FirebaseDatabase.instance.ref("orders").child(payload["jobId"]);
                   ref.update({
                     "isAccepted":true,
                     "sellerId":Seller().userId,
                     "sellerName":Seller().fullName,
                     "sellerAddress":Seller().homeAddress,
                   });
                   }, child: const Text("Accept")),
               ],
             );
             },
         );
       }else{
          //job already accepted
        // print("job not available");
       }
     }).catchError((e){});

    });
  }

  static void showNotification(String title,String body,String payload){
    var androidDetail = const AndroidNotificationDetails("40", "buyer");
    var iosDetail = const IOSNotificationDetails();
    var details = NotificationDetails(android: androidDetail,iOS: iosDetail);
    flutterLocalNotificationsPlugin?.show(0, title, body, details,payload: payload);

  }

}