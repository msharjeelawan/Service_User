import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';


class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

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
          Positioned(top:20,right:0,left:0,child: Center(child: Text("Mutwaffer",style:TextStyle(fontSize: 25,color: Constant.white,fontWeight: FontWeight.bold)))),
          // Image.asset("assets/images/logo.png",width: width*0.4,height: height*0.25,),
          Positioned(
            // height: height*0.6,
            top: 30,
            right: 0,left: 0,
            child:  Form(
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
                    Text("Please select your preferred language",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35,),
                    TextButton(
                        onPressed: (){

                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                            minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  Text(
                          "English",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                        )
                    ),
                    const SizedBox(height: 20,),
                    TextButton(
                        onPressed: (){

                        },
                        style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Constant.primaryColor),
                            minimumSize: MaterialStateProperty.all(Size(width, height*0.07)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                        child:  Text(
                          "Arabic",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Constant.white),
                        )
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
