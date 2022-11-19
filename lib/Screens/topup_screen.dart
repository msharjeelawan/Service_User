import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../Models/notification_model.dart';
import 'home_screen.dart';

class TopUpScreen extends StatelessWidget {
  final _state=_TopupState();
  TopUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return ChangeNotifierProvider(
      create: (context) => _state,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
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
                       Text(LocaleKeys.Drawer_Wallet.tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(LocaleKeys.Wallet_AvailableBalance.tr(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          Text("RO ${double.parse(Seller().balance)}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constant.tilelefttext)),
                        ],
                      )
                    ],
                  )
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                    color: Constant.jobConfirmScreenContainerColor,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(LocaleKeys.Wallet_MentionAmount.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        const SizedBox(width: 25,),
                        Expanded(
                          child: Form(
                            key: _state.formKey,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              validator: (amount){
                                if(amount!.isEmpty){
                                  return LocaleKeys.Wallet_Pleaseenteramount.tr();
                                }
                              },
                              onSaved: (newValue) => _state.amount = newValue.toString().trim(),
                              decoration: InputDecoration(
                                fillColor: Constant.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: const OutlineInputBorder(
                                   // borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 1))
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Constant.primaryColor)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text( LocaleKeys.Wallet_AttachDepositSlip.tr(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: TextButton(
                            onPressed: (){
                              _state.showPicker(context);
                            },
                            style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all(Constant.black),
                              elevation: MaterialStateProperty.all(5),
                              backgroundColor:MaterialStateProperty.all(Colors.black26),
                              //fixedSize: MaterialStateProperty.all(Size(width*0.55, height*0.07)),
                              //shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                            ),
                            child:  Consumer<_TopupState>(
                              builder: (context,state,child){
                                return Text(
                                  _state.isAttached? LocaleKeys.Wallet_Attached.tr():LocaleKeys.Wallet_Attach.tr(),
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              TextButton(
                onPressed: (){
                  _state.topUp(context);
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
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Constant.primaryColor,
            selectedItemColor: Constant.white,
            unselectedItemColor: Constant.white,
            selectedIconTheme: const IconThemeData(color: Colors.black54),
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
               BottomNavigationBarItem(icon: Icon(Icons.person),label:LocaleKeys.Drawer_MyProfile.tr())
            ]
        ),
      ),
    );
  }
}

class _TopupState with ChangeNotifier{
  File? image;
  String imgPath="",amount="";
  final formKey = GlobalKey<FormState>();
  bool isAttached=false;

  void topUp(context) async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

       var map={"userId":Seller().userId,"amount":amount,"attachUrl":imgPath,"status":"pending","date":DateTime.now().toString()};
      FirebaseDatabase.instance.ref("topup").push().update(map).then((value){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.Wallet_TopUprequestsent.tr())));
        formKey.currentState!.reset();

      }).catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
      });

    }
  }

  Future<void> pickImage(source,context) async {
    // print("pick file");
    final picker=ImagePicker();
    XFile? xfile = await  picker.pickImage(source: source);
    if(xfile!=null){
      image = File(xfile.path);
      isAttached=true;
      notifyListeners();
      //upload image in firebase storage and add image url in fb db
      if(image!=null){
        showDialog(
            context: context, barrierDismissible: false, builder: (context) {
          return AlertDialog(
            title: const Text("File Uploading..."),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator()
                ]
            ),
          );
        });
        TaskSnapshot snapshot = await FirebaseStorage.instance.ref("topup").child(DateTime.now().toString()).putFile(image!);
        imgPath = await snapshot.ref.getDownloadURL();
        Navigator.pop(context);
      }
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title:  Text(LocaleKeys.MyProfile_PhotoLibrary.tr()),
                    onTap: () {
                      pickImage(ImageSource.gallery,context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title:  Text(LocaleKeys.MyProfile_Camera.tr()),
                  onTap: () {
                    pickImage(ImageSource.camera,context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}