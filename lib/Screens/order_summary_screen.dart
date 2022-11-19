import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Helper/order_summary.dart';
import 'package:mutwaffer_user/Service/firebase_notification_client.dart';
import 'package:mutwaffer_user/Service/firebase_notification_service.dart';

import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';
import 'order_done_screen.dart';


class OrderSummaryScreen extends StatelessWidget {
  final _state=_OrderSummaryScreenState();
  OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Mutawaffer.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: 100,
              margin: const EdgeInsets.only(left: 30,right: 30,top: 30),
              color: Constant.jobConfirmScreenContainerColor,
              child:  Center(
                  child: Text(LocaleKeys.OrderSummary_YourOrderSummary.tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Constant.jobConfirmScreenContainerColor,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width*0.6,
                    padding: const EdgeInsets.all(5),
                  //  color: Constant.jobConfirmScreenContainerColor2,
                    child:Text(OrderSummary().subService,
                        style: TextStyle(fontSize: 19,color: Constant.tilelefttext),),
                  ),
                  const SizedBox(height: 5,),
                   Text(LocaleKeys.OrderSummary_Location.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Text("${OrderSummary().location}.",maxLines: 3,style:TextStyle(fontSize: 12),),
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                             Text(LocaleKeys.OrderSummary_ExpectedTime.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                            const SizedBox(height: 7,),
                            Text(DateFormat("E, d MMMM yy").format(DateTime.parse(OrderSummary().time.split(",")[0])),style:const TextStyle(fontWeight: FontWeight.bold),),
                            Text(OrderSummary().time.split(",")[1],style:const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      const SizedBox(width: 7,),
                      Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Text(LocaleKeys.OrderSummary_PaymentMethod.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              Text(LocaleKeys.OrderSummary_YoumaypaythroughWalletorCash.tr(),style:TextStyle(),),
                            ],
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: width,
                   // height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Constant.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.OrderSummary_Kindlymentiondetailofinquiry.tr(), style: TextStyle(fontWeight: FontWeight.bold,color: Constant.black),),
                        Form(
                          key: _state.formKey,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            maxLines: 4,
                            onSaved: (newValue) => _state.inquiry = newValue.toString().trim(),
                            decoration: InputDecoration(
                             // contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                              // enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10.0),
                              //     borderSide: BorderSide(color: Constant.primaryColor)
                              // ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child:Text(LocaleKeys.MainItems_Back.tr()),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(231, 230, 230, 1)),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
                      ),
                    )
                ),
                const SizedBox(width: 5,),
                Expanded(
                    child:  ElevatedButton(
                        onPressed: () async{
                          showDialog(
                              context: context, barrierDismissible: false, builder: (context) {
                            return AlertDialog(
                              title:  Text(LocaleKeys.SignupLogin_Pleasewait.tr()),
                              content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator()
                                  ]
                              ),
                            );
                          });
                          bool hasConnection = await InternetConnectionChecker().hasConnection;
                          if(hasConnection){
                            _state.createOrder(context);
                            Navigator.pop(context);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.OrderSummary_NoInternetAccess.tr())));
                            Navigator.pop(context);
                          }
                        },
                        child: Text(LocaleKeys.MainItems_Submit.tr(),style: TextStyle(color: Constant.white),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(127, 127, 127, 1)),
                          elevation: MaterialStateProperty.all(0),
                          overlayColor: MaterialStateProperty.all(Colors.white12),
                        )
                    )
                ),
                const SizedBox(width: 10,),
              ],
            ),
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
             BottomNavigationBarItem(icon: Icon(Icons.person),label:LocaleKeys.Drawer_MyProfile.tr())
          ]
      ),
    );
  }
}

class _OrderSummaryScreenState{
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String inquiry="";
  //int jobNo=0;
  void createOrder(context){
    formKey.currentState!.save();
    var jobRef = FirebaseDatabase.instance.ref("jobNo");
    jobRef.once()
        .then((event){
          DataSnapshot snapshot = event.snapshot;
          int jobNo = snapshot.value as int;
          jobNo++;
          FirebaseDatabase.instance.ref().update({"jobNo":jobNo});

          var reference = FirebaseDatabase.instance.ref("orders").push();
          Map<String,dynamic> order={
            "jobNo":jobNo,
            "buyerId":Seller().userId,
            "buyerName":Seller().fullName,
            "buyerAddress":OrderSummary().location,
            "buyerLatLng":OrderSummary().latLng,
            "sellerId":"",
            "sellerName":"",
            "sellerAddress":"",
            "service":OrderSummary().subService,
            "service2":OrderSummary().subServiceArbi,
            "status":"pending",
            "quotation":"",
            "inquiry":inquiry,
            "paymentMethod":"",
            "paymentAmount":"",
            "isPaid":false,
            "isAccepted":false,
            "reviewId":"",
            "deliveredAt":"",
            "userReviewId":"",
            "type":OrderSummary().type,
            "isNotificationView":false,
            "isSellerNotificationView":false,
            "orderCreatedTime":DateTime.now().toString(),
            "orderDeliveryTime":OrderSummary().time
          };
          reference.update(order).then((value){
            //send notification to all seller that are providing user selected service.
            final client = FirebaseNotificationClient();
            var type=OrderSummary().type;
            String body="New ${type} Job Available...";
            var data={"service":type,"jobId":reference.key};
            client.sendNotificationRequest(token: "job", title: "New Job", notificationBody: body,data:data);

            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.OrderSummary_OrderCreated.tr())));
            var route = MaterialPageRoute(builder: (context){
              return OrderDoneScreen(jobNo:jobNo);
            });
            Navigator.pushAndRemoveUntil(context,route,(route) {
              // print(route.settings.name)
              if(route.settings.name=="/home"){
                return true;
              }
              return false;
            });
          }).catchError((e){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
          });
        }).catchError((e){
          print(e);
        });
  }
}