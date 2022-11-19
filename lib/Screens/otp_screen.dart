import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Screens/profile_screen.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {

  final _state=OTPScreenState();
  OTPScreen({Key? key,required code}) : super(key: key){
    _state.code=code;
  }

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return _state;
      },
      builder: (BuildContext context,Widget? child){
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
              Positioned(top:20,right:0,left:0,child: Center(child: Text("Mutwaffer",style:TextStyle(fontSize: 25,color: Constant.white,fontWeight: FontWeight.bold)))),
             // Image.asset("assets/images/logo.png",width: width*0.4,height: height*0.25,),
              Positioned(
              // height: height*0.6,
                top: 30,
                right: 0,left: 0,
                child:  Form(
                  key: _state.formKey,
                  child: Container(
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
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        Text("Confirm OTP",style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Constant.primaryColor),),
                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width*0.1,
                              child:  TextFormField(
                                maxLength: 1,
                                focusNode: _state.f1,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                onSaved: (newValue) => _state.otp1 = newValue.toString().trim(),
                                onChanged: (value){
                                  changeFocus("1",value);
                               //FocusScope.of(context).requestFocus(f2);
                                },
                                textAlign: TextAlign.center,
                                autofocus: true,
                                decoration: InputDecoration(
                                    fillColor: Constant.white,
                                    filled: true,
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                            SizedBox(
                              width: width*0.1,
                              child: TextFormField(
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) => _state.otp2 = newValue.toString().trim(),
                                focusNode: _state.f2,
                                onTap: (){
                                 // print("2nd tap");
                                },
                                onChanged: (value){
                                //  print("2nd changed");
                                  changeFocus("2",value);
                               //FocusScope.of(context).requestFocus(f3);
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                 fillColor: Constant.white,
                                 filled: true,
                                 counterText: '',
                                 counterStyle: const TextStyle(fontSize: 0),
                                 contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                         ),
                            SizedBox(
                              width: width*0.1,
                              child: TextFormField(
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) => _state.otp3 = newValue.toString().trim(),
                                focusNode: _state.f3,
                                onChanged: (value){
                                  changeFocus("3",value);
                               //FocusScope.of(context).requestFocus(f4);
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    fillColor: Constant.white,
                                    filled: true,
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                            SizedBox(
                              width: width*0.1,
                              child: TextFormField(
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) => _state.otp4 = newValue.toString().trim(),
                                focusNode: _state.f4,
                                onChanged: (value){
                                  changeFocus("4",value);
                               //FocusScope.of(context).unfocus();
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    fillColor: Constant.white,
                                    filled: true,
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                            SizedBox(
                              width: width*0.1,
                              child: TextFormField(
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) => _state.otp5 = newValue.toString().trim(),
                                focusNode: _state.f5,
                                onChanged: (value){
                                  changeFocus("5",value);
                                  //FocusScope.of(context).requestFocus(f4);
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    fillColor: Constant.white,
                                    filled: true,
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                            SizedBox(
                              width: width*0.1,
                              child: TextFormField(
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onSaved: (newValue) => _state.otp6 = newValue.toString().trim(),
                                focusNode: _state.f6,
                                onChanged: (value){
                                  changeFocus("6",value);
                                  //FocusScope.of(context).unfocus();
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    fillColor: Constant.white,
                                    filled: true,
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                            ),
                       ],
                     ),
                        const SizedBox(height: 25,),
                       Consumer<OTPScreenState>(
                           builder:(context,state,child){
                             return  CheckboxListTile(
                               value: state.terms,
                               onChanged: (value){
                                /// state.checkTerms();
                                  Provider.of<OTPScreenState>(context,listen: false).checkTerms();
                               },
                               title: const Text("I accept the terms and privacy policy",style:TextStyle(fontSize: 11)),);
                           }),
                        TextButton(
                            onPressed: () async{
                             _state.confirmOTP(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                                minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                            )
                        ),
                        const SizedBox(height: 5,),
                        Consumer<OTPScreenState>(
                          builder: (BuildContext context,state,Widget? child){
                            return Text(state.message,style: const TextStyle(fontSize: 18),);
                            },
                        ),
                        const SizedBox(height: 5,),
                        TextButton(
                         onPressed: (){
                           Provider.of<OTPScreenState>(context,listen: false).showMessage(Status.resend);
                           _state.resend(context);
                         },
                         style: ButtonStyle(
                             backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                             minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                         ),
                         child:  Text(
                           "Resend OTP",
                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                         )
                     ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        },
    );
  }

  bool isNumber(value){
    return int.parse(value)!=null;
  }

  void changeFocus(String focusNode,String value){

    if(focusNode=="1"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f2.requestFocus();
      }
    }else if(focusNode=="2"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f3.requestFocus();
      }else{
        _state.f1.requestFocus();
      }
    }else if(focusNode=="3"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f4.requestFocus();
      }else{
        _state.f2.requestFocus();
      }
    }else if(focusNode=="4"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f5.requestFocus();
      }else{
        _state.f3.requestFocus();
      }
    }else if(focusNode=="5"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f6.requestFocus();
      }else{
        _state.f4.requestFocus();
      }
    }else if(focusNode=="6"){
      if(value.isNotEmpty) {
        if(!isNumber(value)){
          //if input is not number then return
          return;
        }
        _state.f6.unfocus();
      }else{
        _state.f5.requestFocus();
      }
    }
  }

}
enum Status{
  incorrect,
  match,
  resend
}

class OTPScreenState with ChangeNotifier{

  final FocusNode f1=FocusNode(),f2=FocusNode(),f3=FocusNode(),f4=FocusNode(),
      f5=FocusNode(),f6=FocusNode();
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  String code = "";
  final formKey = GlobalKey<FormState>();
  List<String> messageList = ["OTP is incorrect","OTP match","OTP resend"];
  String message="Please enter security code which has been sent to your Number";
  bool terms=false;
  void showMessage(Status status){
    //if you want to show more message then replace ternary operator with switchcase
    //status==Status.incorrect? message=messageList[0]:message=messageList[1];
    switch(status){
      case Status.incorrect:
        message=messageList[0];
        break;
      case Status.match:
        message=messageList[1];
        break;
      case Status.resend:
        message=messageList[2];
        break;
    }
    notifyListeners();
  }
  void checkTerms(){
    terms? terms=false:terms=true;
    notifyListeners();
  }

  void resend(context){
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:  Seller().number, verificationCompleted: (PhoneAuthCredential credential){},
        verificationFailed: (FirebaseAuthException e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
        },
        codeSent: (String id,int? resendCode){
          code=id;
        },
        codeAutoRetrievalTimeout: (String id){}
    );
  }

  void confirmOTP(context) async{
    if(terms){
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        String otp = otp1+otp2+otp3+otp4+otp5+otp6;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: code, smsCode: otp);
        await FirebaseAuth.instance.signInWithCredential(credential).then((UserCredential credential) {
          var route = MaterialPageRoute(builder: (context){
            return ProfileScreen(isLogin:false);
          });
          Navigator.push(context,route);
        }).catchError((e){
          Provider.of<OTPScreenState>(context,listen: false).showMessage(Status.incorrect);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
        });

        ///Navigator.pop(context,otp);
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please check terms of service")));
    }
  }
}