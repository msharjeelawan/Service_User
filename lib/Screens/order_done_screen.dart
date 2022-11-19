import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';

class OrderDoneScreen extends StatelessWidget {
  int? jobNo;
  OrderDoneScreen({Key? key,this.jobNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: 100,
            decoration: BoxDecoration(border: Border.all(color: Constant.containerBorderColor,width: 2.0)),
            child: Center(
                child: Text("Advertising Banner", textAlign: TextAlign.center, style: TextStyle(fontSize: 23,color: Constant.tilelefttext),)
            ),
          ),
          Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Constant.jobConfirmScreenContainerColor,
            child: Column(
              children: [
                Text("${LocaleKeys.MainItems_JobNumber.tr()} $jobNo", textAlign: TextAlign.center, style: TextStyle(fontSize: 23,color: Constant.tilelefttext),),
                const SizedBox(height: 20,),
                 Text( LocaleKeys.ThankyouOrder_ThankYou.tr(), textAlign: TextAlign.center, style: TextStyle(fontSize: 23,color: Colors.red,fontWeight: FontWeight.bold),),
                 Text( LocaleKeys.ThankyouOrder_Wewillrevertyoushortly.tr(), textAlign: TextAlign.center, style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child:  Text(LocaleKeys.MainItems_Back.tr()),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(231, 230, 230, 1)),
                    elevation: MaterialStateProperty.all(0),
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
