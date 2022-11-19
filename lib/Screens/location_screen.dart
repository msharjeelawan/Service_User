import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locationHelper;
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mutwaffer_user/Helper/order_summary.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';

class LocationScreen extends StatelessWidget {
  final _state=_LocationScreenState();
  LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    _state.getLocationPermission(context);

    return ChangeNotifierProvider(
      create: (context) => _state,
      child: Consumer<_LocationScreenState>(
        builder: (context,state,child){
        //  print("loc update");
         // print(_state.position.toString());
          return Scaffold(
            backgroundColor: Constant.white,
            appBar: AppBar(
              title: Text(LocaleKeys.Mutawaffer.tr()),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: height*0.68,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(target: _state.position,zoom: 18),
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        markers: {
                          Marker(
                              markerId: const MarkerId("current_location"),
                              draggable: true,
                              position: _state.position,
                              onTap: (){
                              //  print("click");
                              },
                              onDragEnd: (latLng){
                              //  print(latLng);
                              }
                            )
                        },
                        onCameraMove: (position){
                          //print(position.target);
                        },
                        onMapCreated: (controller){
                          _state.controller.complete(controller);
                        },
                        onTap: (location) async{
                          _state.updateScreen(location);
                          _state.saveLocation(location,context);
                        },
                      )),
                  Row(
                    children: [
                      const SizedBox(width: 5,),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text( LocaleKeys.MainItems_Back.tr()),
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
                                _state.confirmLocation(context);
                              },
                              child: Text( LocaleKeys.MainItems_Continue.tr(),style: TextStyle(color: Constant.white),),
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
      ),
    );
  }
}


class _LocationScreenState with ChangeNotifier{
  LatLng position = LatLng(21.4735, 55.9754);
  String address="";
  String latLng="";
  locationHelper.LocationData? locationData;
  final Completer<GoogleMapController> controller=Completer();

  void updateScreen(location){
    position=location;
    notifyListeners();
  }

  void saveLocation(location,context) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = placemarks.first;
    //address=place.name!;
    address=' ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
    print(place);
   // address=place.street!;
    latLng=location.latitude.toString()+","+location.longitude.toString();

    //print(address);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(address)));
  }

  void confirmLocation(context){
    if(address.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context){
         return AlertDialog(
           title: const Text("Confirm Location"),
           content: Container(
             child: Text(address),
           ),
           actions: [
             TextButton(
                 onPressed: (){
                   Navigator.pop(context);
                   },
                 child:  Text( LocaleKeys.MainItems_Cancel.tr())
             ),
             TextButton(
                 onPressed: (){
                   OrderSummary().location=address;
                   OrderSummary().latLng=latLng;
                   Navigator.pushReplacementNamed(context,'/timeSelection');
                 },
                 child: const Text("Confirm")
             ),
           ],
         );
        });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( LocaleKeys.OrderSummary_Location.tr())));
    }
  }

  void getLocationPermission(context) async{
    var locationService = locationHelper.Location();
    bool isServiceEnabled = await locationService.serviceEnabled();
    if(isServiceEnabled){
      var hasPermission = await locationService.hasPermission();
      if(hasPermission == locationHelper.PermissionStatus.denied){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text( LocaleKeys.MainItems_Allowpermissionforcurrentlocation.tr())));
        var permissionStatus = await locationService.requestPermission();
        getLocationPermission(context);
      }else if(hasPermission == locationHelper.PermissionStatus.granted){
        locationData = await locationService.getLocation();
        print(locationData!.latitude!);
        print(locationData!.longitude!);
        position = LatLng(locationData!.latitude!,locationData!.longitude!);
        var googleMapController = await controller.future;
        var zoom = await googleMapController.getZoomLevel();
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom:zoom,target: position)));
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enable location service")));
      await locationService.requestService();
      getLocationPermission(context);
    }
  }
}
