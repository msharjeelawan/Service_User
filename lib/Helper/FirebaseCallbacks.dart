import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:flutter/material.dart';

class FirebaseCallbacks{

  // FirebaseCallbacks(){
  //   registerCallbacks();
  // }

  static void registerCallbacks(context,{required Function() ifLogin}){

    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {

      if(user!=null){

        FirebaseDatabase.instance.ref("users").orderByKey()
            .equalTo(user.uid).once()
            .then((value) {
          var snapshot = value.snapshot;
          if (snapshot.value != null) {
            Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic,
                dynamic>;
            userMap.forEach((key, value) {
              var status = value["status"];
              if (status == "block") {
              //  print("block");
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Your account is block.")));
              }else{
             //   print("active");
                Seller().userId=user.uid;
                //trigger ifLogin callback
                ifLogin();
                // print("userid ${Seller().userId}");
              }
            });
          }
        }).catchError((e) {
          print(e);
        });

      }else{

      }
    });
  }

  static void logout(){
    var auth = FirebaseAuth.instance;
    auth.signOut();
  }

  // void checkUserStatus(String key){
  //    FirebaseDatabase.instance.ref("users").orderByKey()
  //       .equalTo(key).once()
  //       .then((value) {
  //     var snapshot = value.snapshot;
  //     if (snapshot.value != null) {
  //       Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic,
  //           dynamic>;
  //       userMap.forEach((key, value) {
  //         var status = value["status"];
  //         if (status == "block") {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text("Your account is block.")));
  //         }
  //       });
  //     }
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

}