import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Screens/home_screen.dart';
import 'package:mutwaffer_user/Screens/order_screen.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';

import '../Models/notification_model.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    double widgetHeight = height*0.10;
    double widgetWidth = width*0.40;
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
              decoration: BoxDecoration(border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
              child: Center(
                  child: Text("Advertising Banner", textAlign: TextAlign.center, style: TextStyle(fontSize: 23,color: Constant.tilelefttext),)
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
               
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 0);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/ac.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                              RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_AC.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 15),))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 1);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/dish.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                            RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Dish.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize:18),))
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 2);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/plumber.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                              RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Plumber.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 16),))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 3);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/electrician.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                               RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Electrician.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 13),))
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 4);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children:  [
                              const Expanded(child: SizedBox.expand()),
                              Image.asset("assets/images/carpenter.png",width: width*0.25),
                              const Expanded(child: SizedBox(width: 1,)),
                               RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Carpenter.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 14),))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 5);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox.expand()),
                              Image.asset("assets/images/painter.png",width: width*0.24),
                              const Expanded(child: SizedBox(width: 1,)),
                               RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Painter.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 18),))
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 6);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox(width: 1,)),
                              Image.asset("assets/images/decor.png",width: width*0.26),
                              const Expanded(child: SizedBox(width: 1,)),
                               RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Decor.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 20),))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 7);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox(width: 1,)),
                              Image.asset("assets/images/curtain.png",width: width*0.25),
                              const Expanded(child: SizedBox(width: 1,)),
                              RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Curtains.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 14),))
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 8);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/cleaning.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                            RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_Cleaning.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 15),))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          var route=MaterialPageRoute(builder: (context){return OrderScreen(index: 9);});
                          Navigator.push(context, route);
                        },
                        child: Container(
                          width: widgetWidth,
                          height: widgetHeight,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                              image: DecorationImage(image: Image.asset("assets/images/container_bg.png").image,fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox.expand()),
                              Image.asset("assets/images/pestcontrol.png",width: width*0.3),
                              const Expanded(child: SizedBox(width: 1,)),
                               RotatedBox(
                                  quarterTurns: -1,
                                  child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_PestControl.tr(),textAlign:TextAlign.center,style: TextStyle(fontSize: 11),))
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
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
             BottomNavigationBarItem(icon: Icon(Icons.person),label:LocaleKeys.MainScreenUser_Profile.tr())
          ]
      ),
    );
  }
}
