import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/data_sync.dart';
import 'package:mutwaffer_user/Screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../translations/locale_keys.g.dart';

class LoginScreen extends StatelessWidget {
  final _state=_LoginScreenState();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return _state;
      },
      child:Scaffold(
        backgroundColor: Constant.white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Constant.primaryColor,
              statusBarIconBrightness: Brightness.light
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,left: 0,
              child: Container(
                width: width,
                height: height*0.35,
                decoration: BoxDecoration(
                    color: Constant.primaryColor,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40.0),bottomRight: Radius.circular(40.0))
                ),
              ),
            ),
            Positioned(top:20,right:0,left:0,child: Center(child: Text(LocaleKeys.Mutawaffer.tr(),style:TextStyle(fontSize: 25,color: Constant.white,fontWeight: FontWeight.bold)))),
            Positioned(
              // height: height*0.6,
              top: 30,
              right: 0,left: 0,
              child:  Container(
                // height: height*0.8,
                margin: const EdgeInsets.only(left: 20.0,right:20.0,top:30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Constant.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(blurRadius: 5,offset: Offset(0,2),color: Colors.black54)
                    ]
                ),
                child:   Form(
                  key: _state.formState,
                  child: Column(
                    children: [
                      Text(LocaleKeys.SignupLogin_Login.tr(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Constant.primaryColor),),
                      // Align(alignment: Alignment.centerLeft,child: Text("    Email",style: TextStyle(fontWeight: FontWeight.bold,),),),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) => _state.email = newValue.toString().trim(),
                        validator: (email){
                          if(!email!.contains("@")){
                            return LocaleKeys.MyProfile_enteraValidEmail.tr();
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Constant.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            // labelText: "Email",
                            hintText: LocaleKeys.MyProfile_email.tr(),
                            prefixIcon: const Icon(Icons.email_outlined),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Constant.primaryColor)
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Constant.primaryColor)
                            )),
                      ),
                      const SizedBox(height: 20,),
                      //Align(alignment: Alignment.centerLeft,child: Text("    Password",style: TextStyle(fontWeight: FontWeight.bold,color:Constant.white)),),
                      // const SizedBox(height: 15,),
                      Consumer<_LoginScreenState>(
                        builder: (BuildContext context,state,Widget? child){
                          return TextFormField(
                            obscureText: _state.isObscure,
                            onSaved: (newValue) => _state.password = newValue.toString().trim(),
                            validator: (password){
                              if(password!.length<6){
                                return LocaleKeys.SignupLogin_Passwordlengthshouldgreaterthen5.tr();
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Constant.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                // labelText: "Password",
                                hintText: LocaleKeys.SignupLogin_EnterYourPassword.tr(),
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(onPressed: (){
                                  Provider.of<_LoginScreenState>(context,listen: false).showHidePassword();
                                }, icon: Icon(state.isObscure? Icons.visibility : Icons.visibility_off)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Constant.primaryColor)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Constant.primaryColor)
                                )),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/forgot');
                            },
                            child: Text(
                              LocaleKeys.SignupLogin_ForgotPassword.tr(),
                              style: TextStyle(color: Constant.black),
                            )
                        ),
                      ),
                      const SizedBox(height: 5,),
                      TextButton(
                          onPressed: (){
                            _state.signIn(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                              fixedSize: MaterialStateProperty.all(Size(width, height*0.07)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                          ),
                          child: Text(
                            LocaleKeys.SignupLogin_Login.tr(),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                          )
                      ),
                      const SizedBox(height: 5,),
                      Row(children: [
                         Text(LocaleKeys.SignupLogin_Donthaveanaccount.tr()),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, '/registration');
                        }, child:  Text(LocaleKeys.SignupLogin_RegisterNow.tr()))
                      ],),
                      context.locale.languageCode == 'ar'
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _LoginScreenState with ChangeNotifier{
  bool isObscure = true;
  String email="";
  String password="";
  final formState=GlobalKey<FormState>();

  void showHidePassword(){
    isObscure? isObscure=false:isObscure=true;
    notifyListeners();
  }

  void signIn(context) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      //fetch user status
      var firstCharacter=email.substring(0,1);
      print(firstCharacter);
      if(firstCharacter.contains(RegExp('[a-z]'))){
        firstCharacter=firstCharacter.toUpperCase();
        email=firstCharacter+email.substring(1,email.length);

      }else{
        //print("no contain");
      }


      await FirebaseDatabase.instance.ref("users").orderByChild("email")
          .equalTo(email).once()
          .then((value) {
        var snapshot = value.snapshot;
        if (snapshot.value != null) {
          Map<dynamic, dynamic> userMap = snapshot.value as Map<dynamic,
              dynamic>;
          userMap.forEach((key, value) {
            var status = value["status"];
            if (status == "block") {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.SignupLogin_Youraccountisblocked.tr())));
            }else {
              login(context);
            }
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

  void login(context){
    var auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(email: email, password: password)
        .then((credential){
      var user=credential.user;
      if(user!=null) {
        if (user.displayName != "user") {
          FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(LocaleKeys.SignupLogin_PleaseloginthroughsellerApp.tr())));
        }else{
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
          //after success login syncdata and load into classes
          final dataSync = DataSync();
          dataSync.sync(isComplete: () {
            //call this when syncing data has complete
            Future.delayed(const Duration(seconds: 5), () {
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(LocaleKeys.SignupLogin_LoginSuccessfully.tr())));
              // var route = MaterialPageRoute(builder: (context) {
              //   return HomeScreen();
              // });
              // Navigator.pushReplacement(context, route);
               Navigator.pushReplacementNamed(context, '/home');
            });
          });
        }
      }
    }).catchError((e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    });
  }

}