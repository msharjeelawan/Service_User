import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Models/job_model.dart';
import 'package:provider/provider.dart';

import '../translations/locale_keys.g.dart';

class TrackLocationScreen extends StatelessWidget {
  final _state=_TrackLocationScreenState();
   TrackLocationScreen({Key? key,required Job job}) : super(key: key){
     _state.job=job;
     _state.subscribe();
   }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _state,
      child: Consumer<_TrackLocationScreenState>(
        builder: (context,state,child){
          return Scaffold(
            backgroundColor: Constant.white,
            appBar: AppBar(
              title: Text(LocaleKeys.Mutawaffer.tr()),
              centerTitle: true,
            ),
            body: GoogleMap(
              initialCameraPosition: CameraPosition(target: _state.position,zoom: 14),
              mapType: MapType.normal,
              //myLocationEnabled: true,
              markers: _state.marker,
              onCameraMove: (position){
                //print(position.target);
              },
              onMapCreated: (controller){
                _state.controller.complete(controller);
              },
              // onTap: (location) async{
              //   _state.saveLocation(location,context);
              // },
            ),
          );
        },
      ),
    );
  }
}


class _TrackLocationScreenState with ChangeNotifier{
  LatLng position = LatLng(21.4735, 55.9754);
  final Completer<GoogleMapController> controller=Completer();
  Set<Marker> marker={Marker(markerId: const MarkerId("112233"), position: LatLng(21.4735, 55.9754),icon: BitmapDescriptor.defaultMarker)};
  Job? job;
  double zoom=0.0;
  void subscribe() {
    FirebaseDatabase.instance.ref("location").orderByChild("id").equalTo(job?.sellerId)
        .onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic> map = snapshot.value as Map<dynamic,dynamic>;
      //{grgr: {lat: 21.44735, id: g16jD7T4ZfZ7bX5E32tunA7kSyz2, lng: 55.9754}}
      map.forEach((k, v) async{
        marker.clear();
        marker.add(Marker(
          markerId: const MarkerId("112233"),
          position: LatLng(v["lat"], v["lng"]),
        ));
        //position=LatLng(v["lat"], v["lng"]);
        var googleMapController = await controller.future;
        zoom=await googleMapController.getZoomLevel();
       // googleMapController.moveCamera(CameraUpdate.newLatLng(LatLng(v["lat"], v["lng"])));
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom:zoom,target: LatLng(v["lat"], v["lng"]))));
        notifyListeners();
      });
     // print("value change");
    //  print(map);
    });
  }

  // @override
  // void dispose(){
  //
  // }

}
