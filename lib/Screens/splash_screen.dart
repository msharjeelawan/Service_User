import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';

import '../translations/locale_keys.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    splashToOther(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          //child: Image.asset("assets/images/logo.png"),
          child: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  splashToOther(context){
    Future.delayed(const Duration(milliseconds: 10000),() async{
      if(Seller().userId.isNotEmpty){
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }
}
