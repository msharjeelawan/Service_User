import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Controller/RegisterController.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';

import '../translations/locale_keys.g.dart';


class RegistrationScreen extends StatelessWidget {
  final _state=_RegisterScreenState();
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return Scaffold(
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
        //fit: StackFit.expand,
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
          // Image.asset("assets/images/logo.png",width: width*0.4,height: height*0.25,),
          Positioned(
            // height: height*0.6,
            top: 30,
            right: 0,left: 0,
            child:  Container(
              margin: const EdgeInsets.only(left: 20.0,right:20.0,top:30),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Constant.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(blurRadius: 5,offset: Offset(0,2),color: Colors.black54)
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  Text(LocaleKeys.SignupLogin_Registration.tr(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Constant.primaryColor),),
                  const SizedBox(height: 25,),
                  Form(
                    key: _state.formKey,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            validator: (value){
                              if(value!=null){
                                if(value.length<8){
                                  return LocaleKeys.SignupLogin_Pleaseentervalidnumber.tr();
                                }else if(value.contains("+")){
                                  return LocaleKeys.SignupLogin_Pleaseremove.tr();
                                }else if(value.startsWith("968")){
                                  return LocaleKeys.SignupLogin_Pleaseremove968fromstart.tr();
                                }
                              }
                            },
                            onSaved: (newValue) => _state.number = newValue.toString().trim(),
                            autofocus: true,
                            decoration: InputDecoration(
                                fillColor: Constant.white,
                                filled: true,
                                counterText: '',
                                prefix: const Text("+968"),
                                prefixIcon: Container(margin:const EdgeInsets.only(right: 10),decoration:BoxDecoration(border: Border(right: BorderSide(color: Constant.primaryColor))),child: const Icon(Icons.call)),
                                counterStyle: const TextStyle(fontSize: 0),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 40),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Constant.primaryColor)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Constant.primaryColor)
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextButton(
                      onPressed: (){
                        //print("ffvf");
                        _state.next(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                          minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                      ),
                      child:  Text(
                        LocaleKeys.MainItems_Submit.tr(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                      )
                  ),
                  const SizedBox(height: 10,),
                  Text(LocaleKeys.SignupLogin_Youwillrecieveonetimepinforverification.tr(),style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _RegisterScreenState{
  final formKey = GlobalKey<FormState>();
  String countryCode="+968";
  String number="";

  void saveNumber(){
    Seller().number=countryCode+number;
  }

  void next(context){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      //save number in seller class for later use in registration
      saveNumber();
      //send otp using service class
      var controller=RegisterController();
      controller.sendOTP(context);
    }
  }

}