import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/order_summary.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';

class TimeSelectionScreen extends StatelessWidget {
  final _state=_TimeSelectionState();
  TimeSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = Constant.getWidth(context);
    // double height = Constant.getHeight(context);
    return ChangeNotifierProvider(
      create: (context) => _state,
      builder: (context,child){
        return  Scaffold(
          backgroundColor: Constant.white,
          appBar: AppBar(
            title: Text(LocaleKeys.Mutawaffer.tr()),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child:Consumer<_TimeSelectionState>(
                  builder: (context,state,child){
                   // print("rebuild2");
                    return Column(
                      children: [
                         Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(LocaleKeys.MainScreenUser_SelectPreferredVisitTime.tr(),style: TextStyle(fontSize: 20),),
                        ),
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:[
                              Text("<",style: TextStyle(fontSize: 20,color: Constant.primaryColor),),
                              Text(_state.formatedDate,style: TextStyle(fontSize: 18,color: Constant.primaryColor),),
                              Text(">",style: TextStyle(fontSize: 20,color: Constant.primaryColor),)
                            ],
                          ),
                          onTap: (){
                            _state.showDateTimePicker(context);
                          },
                        ),
                        const SizedBox(height: 5,),
                        // TextButton(
                        //     onPressed: (){
                        //       _state.showDateTimePicker(context);
                        //     },
                        //     child: Text("< ${ _state.formatedDate} >")
                        // ),
                        GridView.builder(
                          itemCount: _state.times.length+1,
                          padding: const EdgeInsets.all(5),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3,mainAxisSpacing: 10,crossAxisSpacing: 10),
                          itemBuilder: (context,index){

                            //last visit now button
                            bool lastButtonIndex=(_state.times.length)==index;
                            if(lastButtonIndex){
                              return GestureDetector(
                                onTap: (){
                                  _state.showCurrentTime(context);
                                },
                                child: Container(
                                  decoration:  const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 3,color: Colors.black38)]
                                  ),
                                  child:  Center(child: Text(LocaleKeys.MainScreenUser_VisitNow.tr(),style: TextStyle(color: Colors.red)),),
                              ));
                            }

                            if(!_state.isTimeSelectable(index)){
                              return GestureDetector(
                                child: Container(
                                  decoration:  BoxDecoration(
                                      color: Colors.black12.withOpacity(0),
                                      boxShadow: const [BoxShadow(blurRadius: 3,color: Colors.black38)]
                                  ),
                                  child:  Center(child: Text(_state.times[index])),),
                              );
                            }

                            return GestureDetector(
                              onTap: (){

                                _state.changeSelection(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: index==_state.index?Border.all():Border(),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Constant.white,
                                      boxShadow: const [BoxShadow(blurRadius: 3,color: Colors.black38)]
                                  ),
                                  child:  Center(child: Text(_state.times[index])),),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 50,)
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                    children: [
                      const SizedBox(width: 5,),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child:  Text(LocaleKeys.MainItems_Back.tr()),
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
                              onPressed: (){
                                _state.confirmTime(context);
                              },
                              child: Text(LocaleKeys.MainItems_Continue.tr(),style: TextStyle(color: Constant.white),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(127, 127, 127, 1)),
                                elevation: MaterialStateProperty.all(0),
                                overlayColor: MaterialStateProperty.all(Colors.white12),
                              )
                          )
                      ),
                      const SizedBox(width: 5,),
                    ],
                  ),
              )
            ],
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
                BottomNavigationBarItem(icon: Icon(Icons.home),label:  LocaleKeys.Drawer_Home.tr()),
                BottomNavigationBarItem(icon: Stack(
                  children: [
                    Notifications.getList.isNotEmpty?
                    const Positioned(top:0,right:0,child: Icon(Icons.fiber_manual_record,size: 12,color: Colors.red,))
                        :
                    const SizedBox(),
                    const Icon(Icons.access_time),
                  ],
                ),label: LocaleKeys.MainScreenUser_Dashboard.tr()),
                 BottomNavigationBarItem(icon: Icon(Icons.person),label: LocaleKeys.MainScreenUser_Profile.tr())
              ]
          ),
        );
      },
    );
  }
}


class _TimeSelectionState with ChangeNotifier{
  String formatedDate=DateFormat("E, MMMM d").format(DateTime.now());
  String date= DateTime.now().toString();
  bool isToday = true;
  String time="";
  int index=-1;
  bool canCreateOrder=true;
 List<String> times=["08:00 - 09:00 ",
    "09:00  - 10:00 ",
    "10:00  - 11:00 ",
    "11:00  - 12:00 ",
    "12:00  - 13:00 ",
    "13:00  - 14:00 ",
    "14:00  - 15:00 ",
    "15:00  - 16:00 ",
    "16:00  - 17:00 ",
    "17:00  - 18:00 ",
    "18:00  - 19:00 ",
  ];

  bool isTimeSelectable(int index){
    var time=times[index];
    DateTime now = DateTime.now();
    var availableHour=int.parse(time.split(":")[0]);
    String am_pm = DateFormat("a").format(now) ;
    print(am_pm);
    var currentHour=-1;
    if(am_pm=="AM"){
      currentHour=int.parse(DateFormat('H').format(now)) ;
    }else{
      currentHour=int.parse(DateFormat('kk').format(now)) ;
    }
    print("available hour"+availableHour.toString());
    print("current hour"+ currentHour.toString());
    if(isToday){
      if(currentHour<availableHour){
        return true;
      }else{
        return false;
      }
    }else{
      return true;
    }
  }


  void changeSelection(index){
    time=times[index];
    this.index=index;
    DateTime now = DateTime.now();
    var selectedHour=int.parse(time.split(":")[0]);
    
    //var currentHour=int.parse(DateFormat('kk').format(now)) ;
    String am_pm = DateFormat("a").format(now) ;
    print(am_pm);
    var currentHour=-1;
    if(am_pm=="AM"){
      currentHour=int.parse(DateFormat('H').format(now)) ;
    }else{
      currentHour=int.parse(DateFormat('kk').format(now)) ;
    }

    // print(selectedHour);
    // print(DateFormat("h").format(DateTime.now()));

    if(isToday){
      if(currentHour<selectedHour){
        canCreateOrder=true;
      }else{
        canCreateOrder=false;
      }
    }else{
      canCreateOrder=true;
    }

  //  if(currentHour<selectedHour || !isToday){
    //
    //  // print('1');
    //   canCreateOrder=true;
    // }else{
    //  // print('2');
    //   canCreateOrder=false;
    //
    //   print(isToday);
    // }
    notifyListeners();
  }

  void confirmTime(context){
    if(time.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.MainScreenUser_PleaseSelectTime.tr())));
    }else if(date.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.MainScreenUser_PleaseSelectDate.tr())));
    }else if(!canCreateOrder){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.MainScreenUser_PleaseSelectValidTime.tr())));
    }else{
      OrderSummary().time=date+","+time;
      print(OrderSummary().time);
      Navigator.pushNamed(context, "/orderSummary");
    }
  }
  
  void showDateTimePicker(context) async{
    var dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    //format datetime into 
    var dateFormat = DateFormat("E, MMMM d");
    if(dateTime!=null) {
      date=dateTime.toString();
      var suffix = getDayNumberSuffix(dateTime.day);
      final now = DateTime.now();
      final diff =now.difference(dateTime).inDays;
      isToday = diff == 0 && now.day == dateTime.day;
      //print('$now is here');
    //  print('datetime $dateTime');
      //print('difference $diff');
      formatedDate = dateFormat.format(dateTime)+suffix;

    //  print(date);
      //print(formatedDate);
      notifyListeners();
    }
  }

  String getDayNumberSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  void showCurrentTime(context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${LocaleKeys.MainScreenUser_Yourselectedtimeis.tr()} $formatedDate")));
    var currentTime=DateTime.now().add(const Duration(minutes: 5)).toString().split(" ")[1].split(".")[0];
    OrderSummary().time=date+","+currentTime;
    print(OrderSummary().time);
    Navigator.pushNamed(context, "/orderSummary");
  }
}