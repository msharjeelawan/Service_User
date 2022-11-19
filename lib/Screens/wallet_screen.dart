import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Models/transaction_model.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';

class WalletScreen extends StatelessWidget {
  static WalletState? state=WalletState();
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    List<Transactions> transactions;
    return ChangeNotifierProvider<WalletState>(
      create: (context) => state!,
      child: Consumer<WalletState>(
        builder: (context,state,child){
          transactions=Transactions.transactionsList;
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
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
                               Text( LocaleKeys.Drawer_Wallet.tr() ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                   Text(LocaleKeys.Wallet_AvailableBalance.tr()  ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                  Text("RO ${double.parse(Seller().balance)}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constant.tilelefttext)),
                                ],
                              )
                            ],
                          )
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: transactions.length,
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
                                    Text(transactions[index].type,maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold),),
                                    Text("RO ${transactions[index].amount}",maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold,color: Constant.containerBorderColor),),
                                  ],
                                ),
                                subtitle:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(transactions[index].name.length>17? transactions[index].name.substring(0,17):transactions[index].name ,maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold),),
                                    Text(DateFormat("d LLLL ,h:mm a").format(DateTime.parse(transactions[index].date)),maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                // trailing:  Text("Job#0046        ",style:TextStyle(color: Constant.tilelefttext,fontSize: 15),),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            );

                          }),
                      const SizedBox(height: 40,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/topup');
                      },
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Constant.black),
                        elevation: MaterialStateProperty.all(5),
                        backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                        fixedSize: MaterialStateProperty.all(Size(width*0.55, height*0.07)),
                        //shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                      ),
                      child:  Text(
                        LocaleKeys.Wallet_TopUp.tr(),
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                      ),
                    ),
                  ),
                ),
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


class WalletState with ChangeNotifier{

  void updateScreen(){
    notifyListeners();
  }

  @override
  void dispose(){

  }

}