import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:mutwaffer_user/Widgets/JobScreen/job_widget.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';


class BookingScreen extends StatefulWidget {
  static BookingState? state=BookingState();
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    return ChangeNotifierProvider<BookingState>(
      create: (context) => BookingScreen.state!,
      child: Consumer<BookingState>(
        builder: (context,state,child){
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size(width,80),
                child: Container(
                  color: Constant.walletContainerBG,
                  child: Column(
                    children: [
                      const SizedBox(height: 5,),
                      Text(LocaleKeys.Drawer_ManageBookings.tr(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8,),
                      TabBar(
                        indicatorColor: Constant.tilelefttext,
                        labelColor: Constant.tilelefttext,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black87,
                        indicator: BoxDecoration(color: Constant.white,border: Border(bottom: BorderSide(color: Constant.tilelefttext,width: 2))),
                        controller: _tabController,
                        tabs:  [
                          Tab(text: LocaleKeys.Dashboard_Pending.tr(),height: 40,),
                          Tab(text: LocaleKeys.Dashboard_Cancelled.tr(),height: 40,),
                          Tab(text: LocaleKeys.Dashboard_Completed.tr(),height: 40,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                JobWidget(list: Job.newJobList,screenType: "new"),
                JobWidget(list: Job.cancelledJobList,screenType: "cancelled"),
                JobWidget(list: Job.completedJobList,screenType: "completed"),
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
}

class BookingState with ChangeNotifier{

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose(){

  }
}

