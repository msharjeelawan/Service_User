import 'package:flutter/cupertino.dart';
import 'package:mutwaffer_user/Service/RegisterService.dart';

class RegisterController{
  final RegisterService _service=RegisterService();

  void sendOTP(BuildContext context){
    _service.sendOTP(context);
  }

}