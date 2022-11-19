import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Seller.dart';
import 'package:mutwaffer_user/Screens/otp_screen.dart';

class RegisterService{

   sendOTP(BuildContext context) async{
     //before phone auth first confirm in database that user exist or not...
     FirebaseDatabase.instance.ref("users").orderByChild("number").equalTo(Seller().number)
         .once().then((event) {
       DataSnapshot snapshot = event.snapshot;
       if(snapshot.value!=null){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Number already registered")));
       }else{
         var auth = FirebaseAuth.instance;
         auth.verifyPhoneNumber(
             phoneNumber: Seller().number,
             verificationCompleted: (PhoneAuthCredential credential){
             },
             verificationFailed: (FirebaseAuthException e){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
             },
             codeSent: (String verificationId,int? resendToken) async{
               Navigator.push(context, MaterialPageRoute(builder:(context){ return OTPScreen(code:verificationId);},fullscreenDialog: true));
             },
             codeAutoRetrievalTimeout: (String value){}
         );
       }
     }).catchError((e){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
     });

  }

  //this method will call from new password screen at new user registration time
  void registerUser(BuildContext context){
     var auth = FirebaseAuth.instance;
     var seller = Seller();
     if(seller.email.isNotEmpty){
       auth.createUserWithEmailAndPassword(email: seller.email, password: seller.password).then((userCredential){
         //after successful signin create user node in firebase database
         try{
           userCredential.user?.updateDisplayName("user");
           DatabaseReference sellerNode = FirebaseDatabase.instance.ref("users");
           DatabaseReference reference = sellerNode.child(userCredential.user!.uid);
          // String key = reference.key!;
           Map<String,dynamic> userProfile = {};
           userProfile['fullName']=seller.fullName;
           userProfile['email']=seller.email;
           userProfile['homeAddress']=seller.homeAddress;
           userProfile['officeAddress']=seller.officeAddress;
           userProfile['number']=seller.number;
           userProfile['rating']=seller.rating;
           userProfile['balance']=seller.balance;
           userProfile['password']="";
           userProfile['deposit']="";
           userProfile['imageUrl']=seller.imageUrl;
           userProfile['used']="";


           reference.set(userProfile);
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Created.")));
           Navigator.pushNamedAndRemoveUntil(context,'/home', (route) => false);

         }on FirebaseException catch(e){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
         }

       }).catchError((e){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
       });
     }

  }


}