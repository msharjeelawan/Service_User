
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DeviceConnectivityChecking {
  static var isDeviceConnected = false;
  static late StreamSubscription subscription;

  static activate(){
     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result != ConnectivityResult.none) {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
      }
      print( "subscription"+isDeviceConnected.toString());
    });
  }

  static deactivate(){
    if(subscription!=null){
      subscription.cancel();
    }
  }

}