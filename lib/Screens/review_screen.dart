import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Models/review_model.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';

class BehaviorScreen extends StatelessWidget {
  static final BehaviorScreenState? state=BehaviorScreenState();
  const BehaviorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    List<Review> list;


    // Review.list.sort((r1,r2){
    //   int job1 =int.parse(r1.service);
    //   int job2=int.parse(r2.service);
    //   return job1>job2? 0:1;
    // });

    return ChangeNotifierProvider<BehaviorScreenState>(
      create: (context) => BehaviorScreen.state!,
      child: Consumer<BehaviorScreenState>(
        builder: (context,state,child){
          list=Review.list;
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
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      //  decoration: BoxDecoration(,border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocaleKeys.Dashboard_Behaviour.tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Row(
                            children:   [
                              Text("${list.length} ${LocaleKeys.Dashboard_Reviews.tr()}",style: const TextStyle(fontSize: 18,)),
                              const Expanded(child: SizedBox(width: 1,)),
                              Text(countTotalRating(list),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                              const SizedBox(width: 10,),
                              Icon(Icons.star,color: Constant.starOrangeColor,)
                            ],
                          )
                        ],
                      )
                  ),
                  ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ListTile(
                            tileColor: Constant.tileBGColor,
                            title:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                Text(" ${LocaleKeys.MainItems_JobNumber.tr()} " +list[index].service,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold),),
                                Row(
                                    children: getStar(list[index].star)
                                )
                              ],
                            ),
                            subtitle:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(list[index].name,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold),),
                                Text(list[index].comment,maxLines: 1,style:const TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            // trailing:  Text("Job#0046        ",style:TextStyle(color: Constant.tilelefttext,fontSize: 15),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
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
                   BottomNavigationBarItem(icon: Icon(Icons.home),label: LocaleKeys.MainScreenUser_Home.tr()),
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

  List<Widget> getStar(star){
    var fullStar = int.parse(star.split(".")[0]);
    var remaningStar = int.parse(star.split(".")[1]);
    List<Widget> list=[];
    var tempHalfStar=1;
    for(int a=1;a<=5;a++) {
      if (a <= fullStar){
        list.add(Icon(Icons.star, color: Constant.starOrangeColor,));
      }else if (remaningStar>0 && tempHalfStar==1) {
        list.add(Icon(Icons.star_half, color: Constant.starOrangeColor,));
        tempHalfStar++;
      }else {
        list.add(Icon(Icons.star_border, color: Constant.starOrangeColor,));
      }
    }
    return list;
  }

}

class BehaviorScreenState with ChangeNotifier{

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose(){

  }
}