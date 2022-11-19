import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Models/notification_model.dart';
import 'package:mutwaffer_user/Models/review_model.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static final state= DashboardState();
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    return ChangeNotifierProvider<DashboardState>(
      create: (context)=>state,
      builder: (context,child){
        print("chnage");
        return Consumer<DashboardState>(
          builder: (BuildContext context, value, Widget? child) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 100,
                      decoration: BoxDecoration(border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
                      child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text:TextSpan(
                                text: Constant.welcomeText,
                                style: TextStyle(fontSize: 25,color: Constant.tilelefttext),
                                children: [
                                  TextSpan(
                                      text: Constant.companyName,
                                      style: TextStyle(color: Constant.containerBorderColor)
                                  ),
                                  TextSpan(
                                      text: " Platform",
                                      style: TextStyle(color: Constant.tilelefttext)
                                  )
                                ]),
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/wallet');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            gradient: LinearGradient(
                                stops: const [0.2, 1],
                                colors: [Constant.white,Constant.tilelefttext,])
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text( LocaleKeys.Drawer_Wallet.tr() ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(LocaleKeys.Dashboard_Deposited.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Seller().deposit,style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(LocaleKeys.Dashboard_Used.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Seller().used,style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(LocaleKeys.Dashboard_Balance.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Seller().balance,style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/booking');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            gradient: LinearGradient(
                                stops: const [0.2, 1],
                                colors: [Constant.white,Constant.tilelefttext])
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(LocaleKeys.Dashboard_Bookings.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Text(LocaleKeys.Dashboard_Pending.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Job.newJobList.length.toString(),style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(LocaleKeys.Dashboard_Cancelled.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Job.cancelledJobList.length.toString(),style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(LocaleKeys.Dashboard_Completed.tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Job.completedJobList.length.toString(),style: TextStyle(color: Constant.containerBorderColor,fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/notification');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            gradient: LinearGradient(
                                stops: const [0.2, 1],
                                colors: [Constant.white,Constant.tilelefttext])
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(LocaleKeys.Drawer_Notifications.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            CircleAvatar(
                              backgroundColor: Constant.dashboardNotificationColor,
                              child: Text(Notifications.getList.length.toString()),
                              radius: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/behavior');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            gradient: LinearGradient(
                                stops: const [0.2, 1],
                                colors: [Constant.white,Constant.tilelefttext])
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(LocaleKeys.Reviews_Reviews.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            const Expanded(child: SizedBox(width: 0,)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(countTotalRating(Review.list),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                    const SizedBox(width: 5,),
                                    const Icon(Icons.star,color: Colors.yellow,)
                                  ],
                                ),
                                Text("${Review.list.length} ${LocaleKeys.Reviews_Reviews.tr()} "),
                              ],
                            ),
                            const SizedBox(width: 10,),
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/behavior');
                              },
                              child: Text( LocaleKeys.Dashboard_readAll.tr(),style: TextStyle(color: Constant.white,fontSize: 10),),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Constant.dashboardNotificationColor),
                                  minimumSize: MaterialStateProperty.all(Size(width*0.09, 30))
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                          gradient: LinearGradient(
                              stops: const [0.2, 1],
                              colors: [Constant.white,Constant.tilelefttext])
                      ),
                      child: Row(
                        children: [
                          Text(LocaleKeys.Dashboard_Subscription.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          const Expanded(child:  SizedBox(width: 1,),),
                          Text("Gold",style: TextStyle(fontWeight: FontWeight.bold,color: Constant.containerBorderColor,fontSize: 20),),
                          const SizedBox(width: 10,),
                          Stack(
                              children: [
                                Image.asset("assets/images/rank.png"),
                                Positioned(child: Text("G",style: TextStyle(color: Constant.containerBorderColor),),bottom: 9,right: 20,),
                              ]
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  String countTotalRating(List<Review> starList){
    var rating=0.0;
    if(starList.isNotEmpty){
      for (var review in starList) {
        rating += double.parse(review.star);
      }
      return (rating/starList.length).toStringAsFixed(1);
    }else {
      return "0.0";
    }
  }
}

class DashboardState with ChangeNotifier{

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose(){

  }
}