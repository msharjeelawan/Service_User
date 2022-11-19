import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Helper/order_summary.dart';
import 'package:mutwaffer_user/Widgets/SubServices.dart';

import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';

class OrderScreen extends StatelessWidget {
  final _state=_OrderScreenState();
   OrderScreen({Key? key,required int index}) : super(key: key){
     _state.index=index;
     _state.subService.state.index=index;
   }

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
   // double height = Constant.getHeight(context);
    return Scaffold(
      backgroundColor: Constant.white,
      appBar: AppBar(
        title: Text(LocaleKeys.Mutawaffer.tr()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 100,
                  decoration: BoxDecoration(border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
                  child: Center(
                      child: Text("Advertising Banner", textAlign: TextAlign.center, style: TextStyle(fontSize: 23,color: Constant.tilelefttext),)
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(top: 10,bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color:Colors.black12)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(LocaleKeys.MainItems_Note.tr(),style: TextStyle(fontSize: 20,color: Constant.tilelefttext),),
                      ),
                      const SizedBox(height: 5,),
                      DottedBorder(
                        dashPattern: [1,5],
                        padding: EdgeInsets.zero,
                        child: SizedBox(width:width,height:0),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const SizedBox(width: 15,),
                          Image.asset("assets/images/star.png",height: 30,),
                          const SizedBox(width: 10,),
                          Expanded(child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_ACPriceList_DontforgettorateService.tr())),
                          const SizedBox(width: 15,),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        children:  [
                          const SizedBox(width: 15,),
                          Image.asset("assets/images/star.png",height: 30,),
                          const SizedBox(width: 10,),
                          Expanded(child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_ACPriceList_Warrantyonlybevalidif.tr())),
                          const SizedBox(width: 15,),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/priceList');
                          },
                          child: Image.asset("assets/images/price_btn_bg.png",width: 120,),
                        ),
                      )
                    ],
                  ),
                ),
                //_state.index==0?
                _state.subService,
                    //:SizedBox(),
                Image.asset("assets/images/order_bottom_note.png"),
                const SizedBox(height: 10,)
              ],
            ),
          ),
          Positioned(
            child:  Row(
            children: [
              const SizedBox(width: 5,),
              Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text(LocaleKeys.MainItems_Back.tr()),
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
                        _state.isSubServiceSelected(context);
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
            bottom: 0,
            left: 0,
            right: 0,
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
             BottomNavigationBarItem(icon: Icon(Icons.home),label:LocaleKeys.Drawer_Home.tr()),
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
  }
}

class _OrderScreenState{
  //this is widget
  SubServices  subService=SubServices();
  // List<Widget> list=[AcService()];
  int index=0;

  //services
  // ["Ac","Dish","Plumber","Electrician","Carpenter","Painter","Decor","Curtains","Cleaning","PestControl"];
  void isSubServiceSelected(context){
   bool isSelected = subService.state.isSubServicesSelected();
   var types=["Ac","Dish","Plumber","Electrician","Carpenter","Painter","Decor","Curtains","Cleaning","PestControl"];
   if(isSelected){
     OrderSummary().type=types[index];
     Navigator.pushNamed(context, '/location');
   }else{
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select at least one sub service")));
   }
  }
}