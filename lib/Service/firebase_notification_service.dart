import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:mutwaffer_user/Helper/local_notification.dart';

class FirebaseNotificationService{
  final _fcm=FirebaseMessaging.instance;

  static String? token="";
  String? getToken(){
    return token;
  }

  //this method will register callbacks and generate device id
  void initialize() async{
    //register to some topic
    //_fcm.subscribeToTopic("job");

    if(Platform.isIOS){
      //check permission on ios
      _fcm.requestPermission().then((NotificationSettings settings){

      });
    }else if(Platform.isAndroid){
      //no permission required for notification
      token = await _fcm.getToken();
      //print("token");
    //  print(token);
      //listener on foreground
      FirebaseMessaging.onMessage.listen((remoteMessage) {
        RemoteNotification? remote= remoteMessage.notification;
        AndroidNotification? android = remote?.android;
        if(remote!=null && android!=null && !kIsWeb){
        //  print("ok");
        //   print(remote.title);
        //   print(remoteMessage.data);
        //   print(remote.body);
          String myType="Ac";
          if(remoteMessage.data["service"]==myType){
            LocalNotification.initNotification();
            LocalNotification.showNotification(remote.title!,remote.body!,jsonEncode(remoteMessage.data).toString());
          }else{
            //print("you are not capable for this job");
          }

        }
      });

      //listener on background
      FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
      
      FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage){
        print("on message opened app");
        print(remoteMessage.data);
        print(remoteMessage.notification?.title);
        print(remoteMessage.notification?.body);
      });
    }
  }

}

Future<void> onBackgroundHandler(remoteMessage) async{
  RemoteNotification? remote= remoteMessage.notification;
  AndroidNotification? android = remote?.android;
  if(remote!=null && android!=null && !kIsWeb){
    print("ok");
    print(remote.title);
    print(remoteMessage.data);
    print(remote.body);
    String myType="Ac";
    if(remoteMessage.data["service"]==myType){
      LocalNotification.initNotification();
      LocalNotification.showNotification(remote.title!,remote.body!,remoteMessage.data.toString());
    }else{
      print("you are not capable for this job");
    }
  }
}