import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Models/notification_model.dart';
import 'package:mutwaffer_user/Models/review_model.dart';
import 'package:mutwaffer_user/Models/transaction_model.dart';
import 'package:mutwaffer_user/Screens/allorder_booking_screen.dart';
import 'package:mutwaffer_user/Screens/home_screen.dart';
import 'package:mutwaffer_user/Screens/notification_screen.dart';
import 'package:mutwaffer_user/Screens/order_status_screen.dart';
import 'package:mutwaffer_user/Screens/review_screen.dart';
import 'package:mutwaffer_user/Screens/wallet_screen.dart';

import 'Seller.dart';

class DataSync{

 static late StreamSubscription userStream,jobStream,newJobStream,changeJobStream,transactionStream,reviewStream;

  void sync({Function()? isComplete}){
    if(FirebaseAuth.instance.currentUser!=null){
     // print("user login");
    }else{
      //print("user not login");
    }
    syncUser();
    syncJobs();
    syncTransactions();
    syncReviews();
    //after syncing all data now call navigation push for launching screen
    if(isComplete!=null)
      isComplete();

  }


  void syncUser(){
    Query query = FirebaseDatabase.instance.ref("users").orderByKey().equalTo(Seller().userId);
  //  DatabaseReference query = FirebaseDatabase.instance.ref("sellers");
    query.once().then((event){
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
      Map<dynamic,dynamic> user = map[Seller().userId];
     // print(user);
      //print(map.toString());
      var seller = Seller();
      if(FirebaseAuth.instance.currentUser!=null) {
        seller.userId=FirebaseAuth.instance.currentUser!.uid;
      }
      // print("userid");
      // print(seller.userId);
      seller.fullName=user['fullName'].toString();
      seller.email=user['email'].toString();
      seller.number=user['number'].toString();
      seller.homeAddress=user['homeAddress'].toString();
      seller.officeAddress=user['officeAddress'].toString();
      seller.rating=user['rating'].toString();
      seller.balance=user['balance'].toString();
      seller.deposit=user['deposit'].toString();
      seller.used=user['used'].toString();
      seller.password=user['password'].toString();
      seller.imageUrl=user['imageUrl'].toString();

    }).catchError((e){
      print(e.message!);
    });

    userStream = query.onChildChanged.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> user = snapshot.value as Map<dynamic,dynamic>;
      var seller = Seller();
      seller.balance=user['balance'].toString();
      seller.deposit=user['deposit'].toString();
      seller.used=user['used'].toString();
      HomeScreen.state.updateScreen();
      BookingScreen.state?.updateScreen();
      NotificationScreen.state?.updateScreen();
      OrderStatusScreen.state?.updateScreen();
      print("user account change");
    });

  }

  void syncJobs(){
    Job.newJobList.clear();
    Job.cancelledJobList.clear();
    Job.completedJobList.clear();
    Notifications.getList.clear();

    // //job no syncing
    jobStream = FirebaseDatabase.instance.ref("jobNo").onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      int jobNo = snapshot.value as int;
      print("defe");
      print(jobNo);
    });


    //print("sync");
    Query query = FirebaseDatabase.instance.ref("orders").orderByChild("buyerId").equalTo(Seller().userId);

   newJobStream = query.onChildAdded.listen((event) {
    //  print("added");
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
     // print(snapshot.key);
     // print(map);
      Job.jsonToModel(snapshot.key!,map);
      // print(map.toString());
     // print("new job"+Job.newJobList.length.toString());
      // print("accepted job"+Job.acceptedJobList.length.toString());
     // print("cancelled job"+Job.cancelledJobList.length.toString());
     // print("completed job"+Job.completedJobList.length.toString());
     // print("new job notification"+Notifications.getList.length.toString());

    });
   changeJobStream = query.onChildChanged.listen((event) {
   //   print("changed");
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
      Job.jobChanged(snapshot.key!, map);
    //  print(map);
      // screen updating
      HomeScreen.state.updateScreen();
      BookingScreen.state?.updateScreen();
      NotificationScreen.state?.updateScreen();
      OrderStatusScreen.state?.updateScreen();

    });

   //run future delayed for sorting data

    Future.delayed(const Duration(seconds: 20),(){
      Job.cancelledJobList.sort((job1,job2){
        return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
      Job.completedJobList.sort((job1,job2){
        return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
      Job.newJobList.sort((job1,job2){
        return DateTime.parse(job1.orderCreatedTime).isBefore(DateTime.parse(job2.orderCreatedTime))? 1:0;
      });
      HomeScreen.state.updateScreen();
      BookingScreen.state?.updateScreen();
    });

    //query.once().then((event){
     //  DataSnapshot snapshot = event.snapshot;
     //  Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
     //
     //  Job.jsonToModel(map);
     //  // print(map.toString());
     //  print("new job"+Job.newJobList.length.toString());
     // // print("accepted job"+Job.acceptedJobList.length.toString());
     //  print("cancelled job"+Job.cancelledJobList.length.toString());
     //  print("completed job"+Job.completedJobList.length.toString());
     //  print("new job notification"+Notifications.getList.length.toString());


    // }).catchError((e){
    //   print(e.message!);
    // });
  }

  void syncTransactions(){
    Transactions.transactionsList.clear();
    DatabaseReference ref = FirebaseDatabase.instance.ref("transaction");
    //first fetch transactions of type transfer
   transactionStream = ref.orderByChild("owner_id").equalTo(Seller().userId).onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;

      if(map["transfer_to"].toString().isNotEmpty && map["owner_id"].toString()!=map["transfer_to"].toString()){
        //get seller name for showing in transaction detail
        FirebaseDatabase.instance.ref("sellers").child(map["transfer_to"]).once()
            .then((event) {
          DataSnapshot snapshot = event.snapshot;
          if(snapshot.value==null) {
            return;
          }

          Map<dynamic,dynamic> seller = snapshot.value as Map<dynamic,dynamic>;
         // print("seller $seller");
          String name = seller["fullName"].toString();
          //map transaction detail into model transaction class
          try{
            Transactions.transactionsList.add(Transactions(map["amount"].toString(),map["type"].toString(),map["jobNo"].toString(),map["date"].toString(),name));
            //updating screen
            WalletScreen.state?.updateScreen();
            //sort transactions
            Transactions.transactionsList.sort((t1,t2){
              return DateTime.parse(t1.date).isBefore(DateTime.parse(t2.date))? 1:0 ;
            });
          }catch(e){
            print("error");
          }

        }).catchError((e){
          print("error ${e.toString()}");
        });

      }else{
        //map transaction detail into model transaction class
        try{
          Transactions.transactionsList.add(Transactions(map["amount"].toString(),map["type"].toString(),map["jobNo"].toString(),map["date"].toString(),""));
          //updating screen
          WalletScreen.state?.updateScreen();
          //sort transactions
          Transactions.transactionsList.sort((t1,t2){
            return DateTime.parse(t1.date).isBefore(DateTime.parse(t2.date))? 1:0 ;
          });
        }catch(e){
          print("error");
        }
      }

    });


    // ref.orderByChild("owner_id").equalTo(Seller().userId).onChildAdded.listen((event) {
    //   DataSnapshot snapshot = event.snapshot;
    //   Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
    //   //map transaction detail into model transaction class
    //   Transactions.transactionsList.add(Transactions(map["amount"].toString(),map["type"],map["jobNo"],map["date"]));
    //
    // });


    print("length of transaction");
    print(Transactions.transactionsList.length);
  }

  void syncReviews(){
    Review.list.clear();
    DatabaseReference ref = FirebaseDatabase.instance.ref("reviews");
    reviewStream = ref.orderByChild("to").equalTo(Seller().userId).onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
      //map transaction detail into model transaction class
      Review.list.add(Review(map["name"],map["comment"],map["star"].toString(),map["service"].toString()));
      Review.list.sort((r1,r2){
        return int.parse(r1.service)>int.parse(r2.service)? 0:1;
      });
      BehaviorScreen.state?.updateScreen();
      print(Review.list.length);
    });
  }

  static void removeCallBacks(){
    userStream.cancel();
    jobStream.cancel();
    newJobStream.cancel();
    changeJobStream.cancel();
    transactionStream.cancel();
    reviewStream.cancel();
  }

}