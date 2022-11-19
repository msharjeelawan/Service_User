import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';

import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';

// class PriceListScreen extends StatelessWidget {
//
//   PriceListScreen({Key? key}) : super(key: key);
//
//
// }


class PriceListScreen extends StatefulWidget {
  const PriceListScreen({Key? key}) : super(key: key);

  @override
  _PriceListScreenState createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  List<String>? services = ["AC Service on wall","AC Service by removing",
    "Gas Refilling","New AC Installation","AC Remove and Installation","Repair","Other"];
  bool _expand=false;
  int _index=-1;
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
      body: SingleChildScrollView(
        child: Container(
          //  margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(top: 15,bottom: 5),
          color: Constant.jobConfirmScreenContainerColor2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_ACPriceList_PriceList.tr(),style: TextStyle(fontSize: 16,color: Constant.tilelefttext,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 15,),
              DottedBorder(
                dashPattern: [1,3],
                padding: EdgeInsets.zero,
                color: const Color.fromRGBO(199, 199, 199, 1),
                child: SizedBox(width:width,height:0),
              ),
              const SizedBox(height: 10,),
              ExpansionPanelList(
                children: _expansionList()!,
                dividerColor: Constant.jobConfirmScreenContainerColor2,
                expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
                elevation: 0,
                expansionCallback: (index,isExpand){
                  _index=index;
                  _expand=!isExpand;
                  setState(() {
                  });
                },
              ),
              Center(
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child:  Text(LocaleKeys.MainScreenUser_MainScreenBookAService_ACPriceList_Close.tr()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(151, 192, 228, 1))
                  ),
                ),
              ),
            ],
          ),
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
            ),label: LocaleKeys.MainScreenUser_Dashboard.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: LocaleKeys.MainScreenUser_Profile.tr())
          ]
      ),
    );
  }


  List<ExpansionPanel>? _expansionList(){
    List<ExpansionPanel> list = [];
    int a=0;
    for(String service in  services!){
      list.add(ExpansionPanel(
        isExpanded: _expand==true && _index==a,
        canTapOnHeader: true,
        backgroundColor: Constant.jobConfirmScreenContainerColor2,
        headerBuilder: (context,isExpand){
          return  ListTile(
            title: Text(service, style: const TextStyle(color: Colors.black),),
            trailing: Container(
              decoration: BoxDecoration(border: Border(right: BorderSide(color: Constant.white,width: 3))),
              width: 10,
            ),
          );
        },
        body: Column(
          children: [
            Column(
              children: [
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('1.5 Ton Split',style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  title: Container(
                    padding: const EdgeInsets.only(left: 5,top: 20,bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Constant.white,width: 3))
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1 Unit',style: TextStyle(color: Colors.black)),
                              Text('1 - 4',style: TextStyle(color: Colors.black)),
                              Text('5 or more',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('RO 10',style: TextStyle(color: Colors.black)),
                              Text('RO 08 per unit',style: TextStyle(color: Colors.black)),
                              Text('RO 06 per unit',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
              ],
            ),
            Column(
              children: [
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('2.0 Ton Split',style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  title: Container(
                      padding: const EdgeInsets.only(left: 5,top: 20,bottom: 10),
                      decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: Constant.white,width: 3))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1 Unit',style: TextStyle(color: Colors.black)),
                              Text('1 - 4',style: TextStyle(color: Colors.black)),
                              Text('5 or more',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('RO 10',style: TextStyle(color: Colors.black)),
                              Text('RO 08 per unit',style: TextStyle(color: Colors.black)),
                              Text('RO 06 per unit',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
              ],
            ),
            Column(
              children: [
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('3.0 Ton Split',style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  title: Container(
                      padding: const EdgeInsets.only(left: 5,top: 20,bottom: 10),
                      decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: Constant.white,width: 3))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('1 Unit',style: TextStyle(color: Colors.black)),
                              Text('1 - 4',style: TextStyle(color: Colors.black)),
                              Text('5 or more',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('RO 12',style: TextStyle(color: Colors.black)),
                              Text('RO 09 per unit',style: TextStyle(color: Colors.black)),
                              Text('RO 07 per unit',style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                DottedBorder(
                  dashPattern: [1,3],
                  padding: EdgeInsets.zero,
                  color: const Color.fromRGBO(199, 199, 199, 1),
                  child: const SizedBox(width:double.infinity,height:0),
                ),
              ],
            ),
          ],
        ),
      ));
      a++;
    }

    return list;
  }
}
