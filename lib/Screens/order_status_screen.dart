import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Screens/track_location_screen.dart';
import 'package:mutwaffer_user/Widgets/OrderStatus/AlertDialog.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';


class OrderStatusScreen extends StatelessWidget {
  final _state=_OrderStatusScreenState();//using in class
  static _OrderStatusScreenState? state;//using for updating screen from other screen
  var phoneNumber="";
  var sellerImageUrl="";
  OrderStatusScreen({Key? key,Job? job}) : super(key: key){
    _state.job=job!;
    state=_state;
    getpartnerDetails();
  }
  getpartnerDetails() async{
      Query query = FirebaseDatabase.instance.ref("sellers");
      query.once().then((event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
      Map<dynamic,dynamic> sellerData = map[_state.job.sellerId];
      phoneNumber=sellerData['number'].toString();
      sellerImageUrl = sellerData['imageUrl'].toString();
      _state.notifyListeners();
      });
   }

  @override
  Widget build(BuildContext context) {
    _state.context=context;
    double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    if(_state.job.status==JobType.completed.value){
      Future.delayed(const Duration(seconds: 1),(){
        if(!_state.job.isPaid && _state.job.paymentMethod==""){
          MyAlertDialog().showJobCompleted(context, _state.job.service, _state.job.quotation,_state.job);
        }else if(_state.job.isPaid && _state.job.reviewId.isEmpty){
          MyAlertDialog().showThankYou(context, _state.job);
        }
       
      });
    }else if(_state.job.status==JobType.quoted.value){
      Future.delayed(const Duration(seconds: 1),(){
        _state.approveQuotationDialog(context,_state.job);
        });
    }



    return ChangeNotifierProvider<_OrderStatusScreenState>(
      create: (context) => state!,
      child: Consumer<_OrderStatusScreenState>(
        builder: (context,state,child){
          return Scaffold(
            backgroundColor: Constant.white,
            appBar: AppBar(
              title: Text(LocaleKeys.Mutawaffer.tr()),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: width,
                      color: Constant.jobConfirmScreenContainerColor,
                      child: Center(
                        child: Text("${LocaleKeys.MainItems_JobNumber.tr()} ${_state.job.jobNo}",style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 25,),),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Container(
                      width: width,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                      decoration: BoxDecoration(border: Border.all(color: Constant.tilelefttext,width: 1.0),borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Text(LocaleKeys.MainScreenPartner_JobDetails_Job.tr(),style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 15),),
                                const SizedBox(height: 10,),
                                FittedBox(child: Text(_state.job.type,style:const TextStyle(fontSize: 14),maxLines: 1,)),
                              ],
                            ),
                          ),
                          Flexible(
                              child:  Column(
                                children: [
                                  Text(LocaleKeys.MainScreenPartner_JobDetails_ServiceDate.tr(), style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 15),),
                                  const SizedBox(height: 10,),
                                  Text(DateFormat("dd-MM-yyyy").format(DateTime.parse(_state.job.orderDeliveryTime.split(",").first)).toString(),style:const TextStyle(fontSize: 14),maxLines: 1,),
                                ],
                              )),
                          Flexible(
                              child: Column(
                                children: [
                                  Text(LocaleKeys.MainScreenPartner_JobDetails_Status.tr(),style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 15),),
                                  const SizedBox(height: 10,),
                                  Text(_state.job.status,style:const TextStyle(fontSize: 8)),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Constant.white,
                          border: Border.all(color: Constant.tilelefttext),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               CircleAvatar(
                                 
                                 maxRadius: 30,
                                 backgroundImage: NetworkImage(sellerImageUrl),
                               

                               
                                backgroundColor: Constant.tilelefttext,),
                              const SizedBox(width: 6,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(LocaleKeys.MainScreenPartner_JobDetails_CustomerName.tr(),style:TextStyle(fontWeight: FontWeight.bold,color: Constant.tilelefttext,fontSize: 20),),
                                    Text(_state.job.sellerName,style:const TextStyle(fontSize: 20),),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text(LocaleKeys.MainScreenPartner_JobDetails_JobAddress.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Constant.tilelefttext),),
                          Text("${_state.job.buyerAddress}.",maxLines: 2,),
                          const SizedBox(height: 20,),
                          Text(LocaleKeys.MainItems_JobDetail.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Constant.tilelefttext),),
                          Text(_state.job.service,),
                          const SizedBox(height: 20,),
                          Text(LocaleKeys.MainScreenPartner_JobDetails_DetailmentionedinQuote.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Constant.tilelefttext),),
                          Text(_state.job.quotation.isNotEmpty? _state.job.quotation.split("+plus")[1] : "",),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                  _state.job.status!=JobType.pending.value?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: (){
                             // var phoneNumber=Buyer().number;
                              canLaunch('tel:123').then((result){
                                if(result){
                                  final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path: phoneNumber,
                                  );
                                  launch(launchUri.toString());
                                }
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                                // fixedSize: MaterialStateProperty.all(Size(width*0.35, height*0.07)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                            ),
                            child:  Text(
                              LocaleKeys.MainScreenPartner_JobDetails_Call.tr(),
                              style: TextStyle(fontSize: 15,  color: Constant.white),
                            )
                        ),
                        TextButton(
                            onPressed: () async {

                              String whatsAppUrl = "";

                              //String phoneNumber = Buyer().number;

                              if (Platform.isAndroid) {
                                whatsAppUrl = 'https://wa.me/+$phoneNumber';
                              } else {
                                whatsAppUrl = 'whatsapp://wa.me/$phoneNumber/';
                              }
                              if (await canLaunch(whatsAppUrl)) {
                                await launch(whatsAppUrl);
                              }else{
                                const snackBar = SnackBar(content: Text("Install WhatsApp First Please"),);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                                // fixedSize: MaterialStateProperty.all(Size(width*0.35, height*0.07)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                            ),
                            child:  Text(
                              LocaleKeys.MainScreenPartner_JobDetails_WhatsApp.tr(),
                              style: TextStyle(fontSize: 15, color: Constant.white),
                            )
                        ),
                        TextButton(
                            onPressed: (){
                             var route=MaterialPageRoute(builder: (BuildContext context) { return TrackLocationScreen(job: _state.job); });
                             Navigator.push(context, route);
                            },
                            style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                                //  fixedSize: MaterialStateProperty.all(Size(width*0.35, height*0.07)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                            ),
                            child:  Text(
                              LocaleKeys.MainScreenPartner_JobDetails_TrackLocation.tr(),
                              style: TextStyle(fontSize: 15, color: Constant.white),
                            )
                        ),
                      ],
                    ),
                  ):const SizedBox(),
                  const SizedBox(height: 25,),
                  // _state.job.status=='completed'?
                  // Container(child: Column(children: [
                  //   Card(child:  Text(_state.job.isPaid.toString()),)
                  // ]),) 
                  // : Text('')
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Constant.primaryColor,
                selectedItemColor: Constant.white,
                unselectedItemColor: Constant.white,
                selectedIconTheme: const IconThemeData(color: Colors.black54),
                unselectedIconTheme: const IconThemeData(color: Colors.black54),
                onTap: (index){
                  Navigator.popUntil(context, (route){
                    HomeScreen.state.bottomNavigationIndex=index;
                    HomeScreen.state.updateScreen();
                    if(route.settings.name=="/home"){
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


class _OrderStatusScreenState with ChangeNotifier{
  late Job job;
  BuildContext? context;

  void updateScreen(){
    notifyListeners();
    if(context!=null) {
      showDialogOnFirebaseListener(context);
    }
  }

  @override
  void dispose(){

  }

  void approveQuotationDialog(context,Job job){
    showDialog(context: context,barrierDismissible: false, builder: (context){
      return  Center(
        child: Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          child: AlertDialog(
            title: Container(
                decoration: BoxDecoration(border: Border.all(color: Constant.tilelefttext,width: 1.0),borderRadius: BorderRadius.circular(10)),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(LocaleKeys.MainScreenUser_Qoutation_VendorQuotation.tr(),style: TextStyle(color: Constant.tilelefttext , fontWeight: FontWeight.bold),)),
                )),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.MainItems_JobDetail.tr(),style: TextStyle(color: Constant.tilelefttext , fontWeight: FontWeight.bold),),
                Text(job.quotation.split("+plus")[1]),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.MainScreenUser_Qoutation_QuotedAmount.tr(),style: TextStyle(color: Constant.tilelefttext , fontWeight: FontWeight.bold),),
                    Text("RO ${job.quotation.split("+plus")[0]}" , style: TextStyle(fontWeight: FontWeight.bold) ),
                  ],
                )
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    bool hasConnection = await InternetConnectionChecker().hasConnection;
                    if(!hasConnection){
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.OrderSummary_NoInternetAccess.tr())));
                      return;
                    }
                    FirebaseDatabase.instance.ref("orders").child(job.firebaseId)
                        .update({"status":"accepted","quotation":""})
                        .then((value) {
                      Navigator.pop(context);
                    }).catchError((e){

                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child:  Text(LocaleKeys.MainScreenUser_Qoutation_Later.tr())
              ),
              ElevatedButton(
                  onPressed: () async {
                    bool hasConnection = await InternetConnectionChecker().hasConnection;
                    if(!hasConnection){
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.OrderSummary_NoInternetAccess.tr())));
                      return;
                    }
                    DatabaseReference ref = FirebaseDatabase.instance.ref("orders").child(job.firebaseId);
                    ref.update({"status":"approved"});
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child:  Text(LocaleKeys.MainScreenUser_Qoutation_Approve.tr())
              )
            ],
          ),
        ),
      );
    });
  }

  void showDialogOnFirebaseListener(context){
    if(job.status==JobType.completed.value){
      Future.delayed(const Duration(seconds: 1),(){
        if(!job.isPaid && job.paymentMethod==""){
          MyAlertDialog().showJobCompleted(context, job.service, job.quotation,job);
        }else if(job.isPaid && job.reviewId.isEmpty){
          MyAlertDialog().showThankYou(context, job);
        }

      });
    }else if(job.status==JobType.quoted.value){
      Future.delayed(const Duration(seconds: 1),(){
        approveQuotationDialog(context,job);
      });
    }
  }


}
