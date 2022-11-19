import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Service/RegisterService.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatelessWidget {
  final _state=NewPasswordScreenState();
  NewPasswordScreen({Key? key}) : super(key: key);

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
                        text:TextSpan(
                            text: Constant.welcomeText,
                            style: TextStyle(fontSize: 20,color: Constant.black),
                            children: [
                              TextSpan(
                                  text: Constant.companyName,
                                  style: const TextStyle(fontSize: 20,color: Colors.red)
                              )
                            ]),
                      )
                  ),
                ),
                Consumer<NewPasswordScreenState>(
                  builder: (context,state,child){
                    return Container(
                      height: height*0.5,
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: _state.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: state._isObscure,
                              onSaved: (newValue) => _state.p1 = newValue.toString().trim(),
                              validator: (value){
                                if(value!.length<6){
                                  return LocaleKeys.SignupLogin_Passwordlengthshouldgreaterthen5.tr();
                                }else{
                                  //temp passowrd for matching
                                  _state.tempPassword=value;
                                }
                              },
                              decoration: InputDecoration(
                                //   icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                hintText: LocaleKeys.ChangePassword_NewPassword.tr(),
                                suffixIcon: IconButton(onPressed: (){
                                  Provider.of<NewPasswordScreenState>(context,listen: false).showHidePassword();
                                  }, icon: Icon(state._isObscure? Icons.visibility : Icons.visibility_off)),
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
                              obscureText: state._isObscure,
                              onSaved: (newValue) =>  _state.p2 = newValue.toString().trim(),
                              validator: (value){
                                if(value!.length<6){
                                  return LocaleKeys.SignupLogin_Passwordlengthshouldgreaterthen5.tr();
                                }else if(_state.tempPassword!=value){
                                  return LocaleKeys.SignupLogin_Passworddontmatch.tr();
                                }
                              },
                              decoration: InputDecoration(
                                //      icon: CircleAvatar(backgroundColor: Constant.leftCircleOnProfileScreen,),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                hintText: LocaleKeys.ChangePassword_ConfirmPassword.tr(),
                                suffixIcon: IconButton(onPressed: (){
                                  Provider.of<NewPasswordScreenState>(context,listen: false).showHidePassword();
                                }, icon: Icon(state._isObscure? Icons.visibility : Icons.visibility_off)),
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
                                 _state.completeProfile(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                                    fixedSize: MaterialStateProperty.all(Size(width*0.75, height*0.07)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                                ),
                                child:  Text(
                                  LocaleKeys.SignupLogin_CompleteAccount.tr(),
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Constant.white),
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


class NewPasswordScreenState with ChangeNotifier{
  bool _isObscure = true;
  String p1="",p2="",tempPassword="";
  final formKey = GlobalKey<FormState>();
  void showHidePassword(){
    _isObscure? _isObscure=false:_isObscure=true;
    notifyListeners();
  }

  void completeProfile(BuildContext context){
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      Seller().password=p1;
      var registerService=RegisterService();
      registerService.registerUser(context);
    }
  }

}
