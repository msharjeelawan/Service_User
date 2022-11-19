import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/order_summary.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class SubServices extends StatelessWidget{
  final state=_SubServicesState();
  SubServices({Key? key,int index=0}) : super(key: key){
    state.index=index;
  }

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    return  ChangeNotifierProvider(
      create: (context) => state,
      child: Container(
        //  margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 10,bottom: 5),
        color: Constant.jobConfirmScreenContainerColor2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(LocaleKeys.MainScreenUser_MainScreenBookAService_ACPriceList_Selecttypeofservice.tr(),style: TextStyle(fontSize: 16,color: Constant.tilelefttext),),
            ),
            const SizedBox(height: 5,),
            DottedBorder(
              dashPattern: [1,3],
              padding: EdgeInsets.zero,
              child: SizedBox(width:width,height:0),
            ),
            const SizedBox(height: 10,),
            Consumer<_SubServicesState>(
              builder: (context,state,child){
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.list[state.index].length,
                    itemBuilder: (context,index){
                      List<String> keys=state.list[state.index].keys.toList() as List<String>;
                      List<bool> values=state.list[state.index].values.toList() as List<bool>;
                      return Row(
                        children: [
                          const SizedBox(width: 15,),
                          Expanded(child: Text(keys[index])),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(left: BorderSide(color:Constant.white))
                            ),
                            child: Checkbox(value: values[index], onChanged: (value){
                              state.changeChecked(keys[index], value!);
                            },shape: const CircleBorder(),),
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}


class _SubServicesState with ChangeNotifier{
  // List<String>? services = ["AC Service on wall","AC Service by removing",
  //   "Gas Refilling","New AC Installation","AC Remove and Installation","Repair","Other"];
  // List<bool> serviceCheckedList=[false,false,false,false,false,false,false];

  //main service index
  int index=0;
  String selectedServicesEng="";
  String selectedServicesArbi="";
  Map<String,bool> ac={LocaleKeys.Subservices_AcServiceonWall.tr():false,LocaleKeys.Subservices_ACServicebyremoving.tr():false,LocaleKeys.Subservices_GasRefilling.tr():false,LocaleKeys.Subservices_NewACInstallation.tr():false,LocaleKeys.Subservices_ACRemoveandInstallation.tr():false,LocaleKeys.Subservices_Repair.tr():false,LocaleKeys.Subservices_Other.tr():false};
  Map<String,bool> dish={LocaleKeys.Subservices_Fixsatelliteandreceiver.tr():false};
  Map<String,bool> plumber={LocaleKeys.Subservices_Washbasins.tr():false,LocaleKeys.Subservices_ToiletSeats.tr():false,LocaleKeys.Subservices_Bathtubs.tr():false,LocaleKeys.Subservices_ValvesandHosesandRinsersandShowers.tr():false,LocaleKeys.Subservices_TankFloats.tr():false,LocaleKeys.Subservices_WashingmachinesandDishwashersinstallation.tr():false,LocaleKeys.Subservices_NewPlumbingSystemEstablishment.tr():false,LocaleKeys.Subservices_Other.tr():false};
  Map<String,bool> electrician={LocaleKeys.Subservices_Lighting.tr():false,LocaleKeys.Subservices_OutdoorLighting.tr():false,LocaleKeys.Subservices_Chandeliers.tr():false,LocaleKeys.Subservices_ConvertlightingtoLED.tr():false,LocaleKeys.Subservices_KeysAndSockets.tr():false,LocaleKeys.Subservices_VentilationandExhaustFans.tr():false,LocaleKeys.Subservices_ElectricityDistributionPanels.tr():false,LocaleKeys.Subservices_NewElectricalSystemEstablishment.tr():false,LocaleKeys.Subservices_Otherdoesntincluderepairingofhomeappliances.tr():false};
  Map<String,bool> carpenter={LocaleKeys.Subservices_Carpenterperday.tr():false,LocaleKeys.Subservices_Other.tr():false};
  Map<String,bool> painter={LocaleKeys.Subservices_NewPaintWork.tr():false,LocaleKeys.Subservices_PaintMaintenance.tr():false,LocaleKeys.Subservices_Other.tr():false,};
  Map<String,bool> decor={LocaleKeys.Subservices_CeilingDecor.tr():false,LocaleKeys.Subservices_WallDecor.tr():false,LocaleKeys.Subservices_InteriorDecor.tr():false,LocaleKeys.Subservices_ExteriorDecor.tr():false,LocaleKeys.Subservices_Other.tr():false};
  Map<String,bool> curtains={LocaleKeys.Subservices_Carpets.tr():false,LocaleKeys.Subservices_Curtains.tr():false,LocaleKeys.Subservices_Sofas.tr():false,LocaleKeys.Subservices_Majlis.tr():false,LocaleKeys.Subservices_Other.tr():false,};
  Map<String,bool> cleaning={LocaleKeys.Subservices_Carpets.tr():false,LocaleKeys.Subservices_Onepersoncouch.tr():false,LocaleKeys.Subservices_Sofaupto7persons.tr():false,LocaleKeys.Subservices_Smallsizecurtain.tr():false,LocaleKeys.Subservices_Mediumsizecurtain.tr():false,LocaleKeys.Subservices_Largesizecurtain.tr():false,LocaleKeys.Subservices_ArabSofa.tr():false,LocaleKeys.Subservices_Mattress.tr():false,LocaleKeys.Subservices_Otherunlistedfurniture.tr():false};
  Map<String,bool> pestControl={LocaleKeys.Subservices_GeneralPestControl.tr():false,LocaleKeys.Subservices_Pigeonrepellent.tr():false,LocaleKeys.Subservices_TermiteControl.tr():false,LocaleKeys.Subservices_RodentControl.tr():false};

  List<Map> servicesEng=[
    {"Ac Service on Wall":false,"AC Service by removing":false,"Gas Refilling":false,"New AC Installation":false,"AC Remove and Installation":false,"Repair":false,"Other":false},
    {"Fix satellite and receiver":false},
    {"Washbasins":false,"Toilet Seats":false,"Bathtubs":false,"Valves and Hoses and Rinsers and Showers":false,"Tank Floats":false,"Washing machines and Dish washers installation":false,"New Plumbing System Establishment":false,"Other":false},
    {"Lighting":false,"Outdoor Lighting":false,"Chandeliers":false,"Convert lighting to LED":false,"Keys And Sockets":false,"Ventilation and Exhaust Fans":false,"Electricity Distribution Panels":false,"New Electrical System Establishment":false,"Other - doesn't include repairing of home appliances":false},
    {"Carpenter per day":false,"Others":false},
    {"New Paint Work":false,"Paint Maintenance":false,"Others":false,},
    {"Ceiling Decor":false,"Wall Decor":false,"Interior Decor":false,"Exterior Decor":false,"Others":false},
    {"Carpets":false,"Curtains":false,"Sofas":false,"Majlis":false,"Others":false,},
    {"Carpets":false,"One person couch":false,"Sofa - up to 7 persons":false,"Small size curtain":false,"Medium size curtain":false,"Large size curtain":false,"Arab Sofa":false,"Mattress":false,"Other unlisted furniture":false},
    {"General Pest Control":false,"Pigeon repellent":false,"Termite Control":false,"Rodent Control":false}
  ];
// Map<String,bool> ac={"Ac Service on Wall":false,"AC Service by removing":false,"Gas Refilling":false,"New AC Installation":false,"AC Remove and Installation":false,"Repair":false,"Other":false};
//   Map<String,bool> dish={"Fix satellite and receiver":false};
//   Map<String,bool> plumber={"Washbasins":false,"Toilet Seats":false,"Bathtubs":false,"Valves and Hoses and Rinsers and Showers":false,"Tank Floats":false,"Washing machines and Dish washers installation":false,"New Plumbing System Establishment":false,"Other":false};
//   Map<String,bool> electrician={"Lighting":false,"Outdoor Lighting":false,"Chandeliers":false,"Convert lighting to LED":false,"Keys And Sockets":false,"Ventilation and Exhaust Fans":false,"Electricity Distribution Panels":false,"New Electrical System Establishment":false,"Other - doesn't include repairing of home appliances":false};
//   Map<String,bool> carpenter={"Carpenter per day":false,"Others":false};
//   Map<String,bool> painter={"New Paint Work":false,"Paint Maintenance":false,"Others":false,};
//   Map<String,bool> decor={"Ceiling Decor":false,"Wall Decor":false,"Interior Decor":false,"Exterior Decor":false,"Others":false};
//   Map<String,bool> curtains={"Carpets":false,"Curtains":false,"Sofas":false,"Majlis":false,"Others":false,};
//   Map<String,bool> cleaning={"Carpets":false,"One person couch":false,"Sofa - up to 7 persons":false,"Small size curtain":false,"Medium size curtain":false,"Large size curtain":false,"Arab Sofa":false,"Mattress":false,"Other unlisted furniture":false};
//   Map<String,bool> pestControl={"General Pest Control":false,"Pigeon repellent":false,"Termite Control":false,"Rodent Control":false};


  List<Map> list=[];
  _SubServicesState(){
   list.add(ac);
   list.add(dish);
   list.add(plumber);
   list.add(electrician);
   list.add(carpenter);
   list.add(painter);
   list.add(decor);
   list.add(curtains);
   list.add(cleaning);
   list.add(pestControl);
  }

  void changeChecked(String key,bool value){
    list[index][key]=value;
    //print(ac.toString());
    notifyListeners();
  }

  //this method will call for confirmation if user select sub service or not
  bool isSubServicesSelected(){
    bool isSelected=false;
    selectedServicesEng="";
    selectedServicesArbi ="";
    List<String> keys= list[index].keys.toList() as List<String>;
    List<bool> values= list[index].values.toList() as List<bool>;
    List keysEng= servicesEng[index].keys.toList();
    int totalSelected=0;
    //for eng subservuces
    for (var a=0;a<values.length;a++) {
      var value=values[a];
      if(value){
        totalSelected++;
        selectedServicesArbi += "$totalSelected- "+keys[a]+"\n";
        selectedServicesEng += "$totalSelected- "+keysEng[a]+"\n";
        isSelected=true;
      }
    }
    // //for arbi subservices
    // for (var a=0;a<values.length;a++) {
    //   var value=values[a];
    //   if(value){
    //     totalSelected++;
    //     selectedServicesArbi += "$totalSelected- "+keys[a]+"\n";
    //     isSelected=true;
    //   }
    // }
    OrderSummary().subService=selectedServicesEng;
    OrderSummary().subServiceArbi=selectedServicesArbi;
    return isSelected;
  }
}
