import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';

import '../Models/notification_model.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _state=ChangePasswordScreenState();
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
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
                  child: RichText(
                    textAlign: TextAlign.center,
                    text:TextSpan(
                        text: Constant.welcomeText,
                        style: TextStyle(fontSize: 23,color: Constant.black),
                        children: [
                          TextSpan(
                              text: Constant.companyName,
                              style: TextStyle(color: Constant.containerBorderColor)
                          ),
                          const TextSpan(
                              text: " Platform",
                              //style: const TextStyle(fontSize: 20)
                          )
                        ]),
                  )
              ),
            ),
            Container(
              height: height*0.45,
              padding: const EdgeInsets.all(15),
              child: Form(
                key:_state.formState,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onSaved: (newValue) => _state.oldPassword = newValue.toString().trim(),
                      validator: (old){
                        if(old!.isEmpty){
                          return LocaleKeys.SignupLogin_EnterOldPassword.tr();
                        }
                      },
                      decoration: InputDecoration(
                    //    icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: LocaleKeys.ChangePassword_OldPassword.tr(),
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
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                       onSaved: (newValue) => _state.newPassword = newValue.toString().trim(),
                      validator: (newPassword){
                        if(newPassword!.isEmpty){
                          return LocaleKeys.SignupLogin_Enternewpassword.tr();
                        }else{
                          _state.newPassword=newPassword;
                        }
                      },
                      decoration: InputDecoration(
                     //   icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: LocaleKeys.ChangePassword_NewPassword.tr(),
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
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onSaved: (newValue) => _state.newPassword = newValue.toString().trim(),
                      validator: (newPassword){
                        newPassword = newPassword!;
                        if(newPassword.isEmpty){
                          return LocaleKeys.SignupLogin_Enternewpassword.tr();
                        }else if(newPassword!=_state.newPassword){
                          return LocaleKeys.ChangePassword_OldPassword.tr();
                        }
                      },
                      decoration: InputDecoration(
                  //      icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: LocaleKeys.ChangePassword_ConfirmPassword.tr(),
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
                    TextButton(
                        onPressed: (){
                          _state.changePassword(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                            fixedSize: MaterialStateProperty.all(Size(width*0.75, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  Text(
                          LocaleKeys.ChangePassword_ChangePassword.tr(),
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                        )
                    ),
                  ],
                ),
              ),
            )


          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Constant.primaryColor,
          selectedItemColor: Constant.white,
          unselectedItemColor: Constant.white,
          selectedIconTheme: IconThemeData(color: Constant.black),
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


class ChangePasswordScreenState {
  final formState=GlobalKey<FormState>();
  String newPassword="",oldPassword="";

  changePassword(context){
    if(formState.currentState!.validate()){
      formState.currentState!.save();
      showDialog(
          context: context, barrierDismissible: false, builder: (context) {
        return AlertDialog(
          title:  Text(LocaleKeys.SignupLogin_Pleasewait.tr()),
          content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator()
              ]
          ),
        );
      });
      FirebaseAuth.instance.signInWithEmailAndPassword(email: Seller().email, password: oldPassword).then((value) {
       //password changing request if old password is okay
        FirebaseAuth.instance.currentUser?.updatePassword(newPassword).then((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.SignupLogin_Passwordsuccessfullychanged.tr())));
          formState.currentState!.reset();
        }).catchError((e){
          Navigator.pop(context);
          print(e.message!);
          if(e.message!=null){
            if(e.message=="This operation is sensitive and requires recent authentication. Log in again before retrying this request."){
              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.SignupLogin_Areyouoneofthose.tr())));
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
        });
      }).catchError((e){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.SignupLogin_Pleaseentercorrectoldpassword.tr())));
      });

    }
  }
}
