import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/FirebaseCallbacks.dart';
import 'package:mutwaffer_user/Helper/HomeScreenArgument.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:provider/provider.dart';
import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import '/Screens/dashboard_screen.dart';
import '/Screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static BuildContext? context;
  static final state=HomeState();

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;
    if(argument!=null){
      var homeArgument = argument as HomeScreenArgument;
      state.bottomNavigationIndex=homeArgument.pageIndex;
    }

    HomeScreen.context=context;
    //double width = Constant.getWidth(context);
    //double height = Constant.getHeight(context);
    return ChangeNotifierProvider<HomeState>(
      create: (context) => HomeScreen.state,
      child: Consumer<HomeState>(
        builder: (context,state,child){
          //update reference
          state.homeWidgets = [HomeBody(),DashboardScreen(),ProfileScreen()];
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Constant.white),
              title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
              centerTitle: true,
            ),
            body: state.homeWidgets[state.bottomNavigationIndex],
            drawer: Drawer(

              
              backgroundColor: Constant.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    const SizedBox(height: 40,),
                    // Container(
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //       color: Constant.white,
                    //       borderRadius: BorderRadius.circular(80),
                    //       image: DecorationImage(image: Image.asset("assets/images/logo.png",width: 50,height: 50,).image,)
                    //   ),
                    // ),
                    // const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(width: 15,),
                        //CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,radius: 40,child: Text("Photo",style: TextStyle(color: Constant.containerBorderColor),),),
                        CircleAvatar(
                          backgroundColor: Constant.leftCircleOnProfileScreen,
                          backgroundImage: Seller().imageUrl.isNotEmpty? Image.network(Seller().imageUrl).image : Image.asset("assets/images/profile.png",fit: BoxFit.fill,).image,
                          radius: 40,
                        ),
                        const SizedBox(width: 15,),
                        Expanded(child: Text(Seller().fullName,style: TextStyle(color: Constant.tilelefttext,fontWeight: FontWeight.bold,fontSize: 20),)),
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.menus.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            selected: index==state.drawerIndex,
                            selectedTileColor: Constant.jobConfirmScreenContainerColor,
                            onTap: (){
                              Navigator.pop(context);
                              if(index==0){
                                state.bottomNavigationIndex=0;
                              }else if(index==1) {
                                state.bottomNavigationIndex=2;
                              }else if(index==9) {
                                logout(context);
                              }else {
                                Navigator.pushNamed(context, "/${state.screenList?[index]}");
                              }
                              state.drawerIndex=index;
                              state.updateScreen();
                            },
                            leading: CircleAvatar(child: Icon(state.icons[index]),),
                            title: Text(state.menus[index],style: TextStyle(color: Constant.black),),
                          );
                        }),
                        ListTile(
                          leading: CircleAvatar(child: Icon(Icons.language)),
                          title: context.locale.languageCode == 'ar'
              ? TextButton(
                  onPressed: () async {
                    await context.setLocale(Locale('en'));
                  },
                  child: Text('Change Language to English'))
              : TextButton(
                  onPressed: () async {
                    await context.setLocale(Locale('ar'));
                  },
                  child: Text('تغيير اللغة إلى العربية')),
                        )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.bottomNavigationIndex,
                backgroundColor: Constant.primaryColor,
                selectedItemColor: Constant.white,
                unselectedItemColor: Constant.white,
                onTap: (index){
                  state.bottomNavigationIndex = index;
                  state.updateScreen();
                },
                selectedIconTheme: IconThemeData(color: Constant.black),
                unselectedIconTheme: const IconThemeData(color: Colors.black54),
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


  void logout(context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(LocaleKeys.Drawer_Logout.tr()),
        content:  Text(LocaleKeys.Drawer_DoyouwanttoLogout.tr()),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:  Text(LocaleKeys.MainItems_Cancel.tr())),
          TextButton(onPressed: (){
            FirebaseCallbacks.logout();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.SignupLogin_LogoutSuccessfully.tr())));
          }, child:  Text(LocaleKeys.Drawer_Logout.tr())),
        ],
      );
    });
  }
}


class HomeState with ChangeNotifier {
  final icons = <IconData> [ Icons.home , Icons.person , Icons.attach_money_sharp , Icons.notifications ,Icons.work , Icons.change_circle , Icons.policy , Icons.read_more , Icons.share , Icons.logout];

  late List<String> menus=<String>[LocaleKeys.Drawer_Home.tr(),LocaleKeys.Drawer_MyProfile.tr(),LocaleKeys.Drawer_Wallet.tr(),LocaleKeys.Drawer_Notifications.tr(),
    LocaleKeys.Drawer_ManageBookings.tr(),LocaleKeys.Drawer_ChangePassword.tr(),LocaleKeys.Drawer_PrivacyandPolicy.tr(),LocaleKeys.Drawer_TermsandConditions.tr(),LocaleKeys.Drawer_ShareApp.tr(),LocaleKeys.Drawer_Jobs.tr()];
  List<Widget>  homeWidgets = [HomeBody(),DashboardScreen(),ProfileScreen()];
  List<String>?  screenList=["home","profile","wallet","notification","booking","changePassword","privacy","terms","share"];
  int bottomNavigationIndex=0,drawerIndex=0;

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose() {
  }

}


class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    double widgetHeight = height*0.135;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            height: widgetHeight,
            decoration: BoxDecoration(border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
            child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(
                      text: Constant.welcomeText,
                      style: TextStyle(fontSize: 23,color: Constant.tilelefttext,),
                      children: [
                        TextSpan(
                            text: Constant.companyName,
                            style: TextStyle(color: Constant.containerBorderColor)
                        ),
                        const TextSpan(
                            text: "\n Platform",
                           // style: TextStyle(color: Constant.tilelefttext)
                        )
                      ]),
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:(){
                        //Navigator.pushNamed(context, '/service');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2),content: Text("Coming soon"))).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                      },
                      child: Container(
                        width: width*0.4,
                        height: widgetHeight,
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(colors: [Constant.white,Constant.primaryColor],radius: 1),
                        //  image: DecorationImage(image: Image.asset("assets/images/transport.png").image),
                          borderRadius: BorderRadius.circular(20)
                        ),
                       child: Stack(
                         children: [
                         //  const Expanded(child: SizedBox(height: 1,)),
                           Positioned(right:5,left:5,bottom:15,child: Image.asset("assets/images/transport.png",width: width*0.3,)),
                           Positioned(bottom:0,right:0,left:0,child: Center(child: Text(LocaleKeys.MainScreenUser_Transport.tr(),style: Constant.whiteStyle,),))
                         ],
                       ),
                       // child: Align(alignment:Alignment.bottomCenter,child: Text("Transport",style: Constant.whiteStyle,)),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/service');
                      },
                      child: Container(
                        width: width*0.5,
                        height: widgetHeight,
                       // padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            gradient: RadialGradient(colors: [Constant.white,Constant.starOrangeColor],radius: 1.5),
                           // image: DecorationImage(image: Image.asset("assets/images/service.png").image),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(top:0,bottom: 15,right: 0,left: 0,child: Image.asset("assets/images/service.png",)),
                            Positioned(bottom: 3,right: 0,left: 0,child: Center(child: Text(LocaleKeys.MainScreenUser_BookaService.tr(),style: Constant.whiteStyle,))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        //Navigator.pushNamed(context, '/service');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2),content: Text("Coming soon"))).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                      },
                      child: Container(
                        width: width*0.4,
                        height: widgetHeight,
                      //  padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            gradient: RadialGradient(colors: [Constant.white,Constant.tilelefttext],radius: 1),
                        //    image: DecorationImage(image: Image.asset("assets/images/tourism.png").image),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Stack(
                          children: [
                            Image.asset("assets/images/tourism.png",fit: BoxFit.fitHeight,),
                            Positioned(bottom: 5,left:0,right:0,child: Center(child: Text(LocaleKeys.MainScreenUser_Tourism.tr(),style: TextStyle(color: Constant.white,shadows: [Shadow(blurRadius: 2)]),),)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        //Navigator.pushNamed(context, '/service');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2),content: Text("Coming soon"))).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                      },
                      child: Container(
                        width: width*0.5,
                        height: widgetHeight,
                       // padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            gradient: RadialGradient(colors: [Constant.white,Color.fromRGBO(151, 105, 186, 1)],radius: 1),
                       //     image: DecorationImage(image: Image.asset("assets/images/tickets.png").image,fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/images/tickets.png",width: width*0.35,),
                            Text(LocaleKeys.MainScreenUser_FlightTickets.tr(),style: Constant.whiteStyle,),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    //Navigator.pushNamed(context, '/service');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2),content: Text("Coming soon"))).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                  },
                  child: Container(
                    width: width,
                    height: widgetHeight,
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        gradient: RadialGradient(colors: [Constant.white,Constant.tilelefttext],radius: 1.4),
                       // image: DecorationImage(image: Image.asset("assets/images/offers.png").image,fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/offers.png",width: width*0.7,),
                        const Expanded(child: SizedBox(width: 1,)),
                        RotatedBox(
                            quarterTurns: -1,
                            child: Text(LocaleKeys.MainScreenUser_Offers.tr(),style: TextStyle(color: Constant.white,fontSize: 22),)
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    //Navigator.pushNamed(context, '/service');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 2),content: Text("Coming soon"))).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                  },
                  child: Container(
                    width: width,
                    height: widgetHeight,
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        gradient: RadialGradient(colors: [Constant.white,const Color.fromRGBO(101, 187, 179, 1)],radius: 1),
                     //   image: DecorationImage(image: Image.asset("assets/images/material.png").image,fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/material.png",width: width*0.7),
                        const Expanded(child: SizedBox(width: 1,)),
                        RotatedBox(
                            quarterTurns: -1,
                            child: Align(alignment:Alignment.bottomCenter,child: Text(LocaleKeys.MainScreenUser_Material.tr(),textAlign:TextAlign.center,style: TextStyle(color: Constant.white,fontSize: 23),))
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

