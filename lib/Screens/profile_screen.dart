import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final _state=ProfileScreenState();
  ProfileScreen({Key? key,bool isLogin=true}) : super(key: key){
    //this screen can access during register and after user login
    //if access during login isLogin will true otherwise false
    //login state will use later in update profile button for navigation route and screen design
    _state.isLogin=isLogin;
  }

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return ChangeNotifierProvider(
      create: (context){
        return _state;
      },
      builder: (context,child){
        return Scaffold(
          backgroundColor: Constant.white,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _state.formKey,
                child: Column(
                  children:  [
                    SizedBox(height: _state.isLogin?10:40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<ProfileScreenState>(
                          builder: (context,state,child){
                            return CircleAvatar(
                              backgroundColor: Constant.leftCircleOnProfileScreen,
                              backgroundImage: Seller().imageUrl.isNotEmpty? Image.network(Seller().imageUrl).image: _state.image!=null? Image.file(_state.image!,fit: BoxFit.fill,).image: Image.asset("assets/images/profile.png",fit: BoxFit.fill,).image,
                              child:TextButton(onPressed: (){
                                _state.showPicker(context);
                              },child: Text(LocaleKeys.MyProfile_clicktochange.tr(),style: TextStyle(color: Colors.grey.withOpacity(0))),),
                              radius: 60,
                            );
                          },
                        ),
                        const SizedBox(width: 3,),
                        Text( LocaleKeys.Drawer_MyProfile.tr() ,style: TextStyle(fontSize: 20,color: Constant.tilelefttext,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: _state.fullName,
                      validator: (value){
                        if(value!.isEmpty){
                          return LocaleKeys.MyProfile_enteraValidName.tr();
                        }
                      },
                      onSaved: (newValue) => _state.fullName = newValue.toString().trim(),
                      decoration: InputDecoration(
                        icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText:LocaleKeys.MyProfile_fullName.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                      ),

                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      initialValue: _state.email,
                      onSaved: (newValue) => _state.email = newValue.toString().trim(),
                      validator: (value){
                        if(!value!.contains("@")){
                          return LocaleKeys.MyProfile_enteraValidEmail.tr();
                        }
                      },
                      decoration: InputDecoration(
                        icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: LocaleKeys.MyProfile_email.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: _state.homeAddress,
                      maxLines: 3,
                      //  expands: true,
                      validator: (value){
                        if(value!.isEmpty){
                          return LocaleKeys.MyProfile_enteraValidAddress.tr();
                        }
                      },
                      onSaved: (newValue) => _state.homeAddress = newValue.toString().trim(),
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        hintText: LocaleKeys.MyProfile_homeAddress.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      textAlignVertical: TextAlignVertical.center,
                      initialValue: _state.officeAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return  LocaleKeys.MyProfile_enteraValidAddress.tr();
                        }
                      },
                      onSaved: (newValue) => _state.officeAddress = newValue.toString().trim(),
                      decoration: InputDecoration(
                        //  contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        hintText:  LocaleKeys.MyProfile_officeAddress.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      initialValue: _state.number,
                      // onSaved: (newValue) => email = newValue.toString().trim(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        hintText:  LocaleKeys.MyProfile_RegisteredNumber.tr(),
                        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Constant.primaryColor)
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    TextButton(
                        onPressed: (){
                          _state.updateProfile(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                            fixedSize: MaterialStateProperty.all(Size(width*0.75, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  Text(
                           LocaleKeys.MyProfile_UpdateProfile.tr(),
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                        )
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}

class ProfileScreenState with ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  String fullName="",email="",homeAddress="",officeAddress="",number="",imageUrl="";
  List<String> jobsList=[];
  bool isLogin=false;
  File? image;

  ProfileScreenState(){
    fetchState();
  }

  @override
  void dispose(){

  }

  void updateProfile(context){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //update profile data will update in user class
      var seller = Seller();
      seller.fullName=fullName;
      seller.email=email;
      seller.homeAddress=homeAddress;
      seller.officeAddress=officeAddress;
      if(!isLogin){
        Navigator.pushNamed(context, '/newPassword');
      }else{
        DatabaseReference ref = FirebaseDatabase.instance.ref("users").child(seller.userId);
        ref.update({"email":email,"fullName":fullName,"homeAddress":homeAddress,"officeAddress":officeAddress});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated")));
      }
    }
  }

  void fetchState(){
    //this will fetch data of user form user helper class
    var seller=Seller();
   // print(seller.hashCode);
    fullName=seller.fullName;
    email=seller.email;
    homeAddress=seller.homeAddress;
    officeAddress=seller.officeAddress;
    number=seller.number;
    imageUrl=seller.imageUrl;
   // print("fetch state");
   // print(seller.fullName);
   //  print(seller.email);
   //  print(seller.homeAddress);
   //  print(seller.number);
   //  print(seller.imageUrl);
  }

  Future<void> pickImage(source,context) async {
    // print("pick file");
    final picker=ImagePicker();
    XFile? xfile = await  picker.pickImage(source: source);
    if(xfile!=null){
      image = File(xfile.path);


      var imageCropper = ImageCropper();
      File? croppedFile = await imageCropper.cropImage(
          sourcePath: xfile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings:  AndroidUiSettings(
              toolbarTitle: LocaleKeys.MyProfile_Cropper.tr(),
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );

      image = croppedFile;
      notifyListeners();
      //upload image in firebase storage and add image url in fb db
      TaskSnapshot snapshot = await FirebaseStorage.instance.ref("profileImagesUser").child(Seller().userId).putFile(image!);
      String imgPath = await snapshot.ref.getDownloadURL();
      FirebaseDatabase.instance.ref("users").child(Seller().userId).update({"imageUrl":imgPath});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.MyProfile_ImageUploadedSuccessfully.tr())));
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
                    title:  Text( LocaleKeys.MyProfile_PhotoLibrary.tr()),
                    onTap: () {
                      pickImage(ImageSource.gallery,context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title:Text( LocaleKeys.MyProfile_Camera.tr()),
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