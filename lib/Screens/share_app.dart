import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:share_plus/share_plus.dart';

import '../translations/locale_keys.g.dart';


class ShareApp extends StatefulWidget {
  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Constant.white),
          title: Text(LocaleKeys.Mutawaffer.tr(),style: TextStyle(color: Constant.white),),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            // Row(
            //
            //   children: [
            //     TextButton(
            //       child: Icon(Icons.arrow_back_ios,color:Colors.black),
            //       onPressed: (){
            //         Navigator.pop(context);
            //       },
            //     )
            //   ],
            // ),
            // Container(
            //   color: Colors.white,
            //   padding: EdgeInsets.only(
            //     // top: MediaQuery.of(context).padding.top,
            //       left: 16,
            //       right: 16),
            //   child: Image.asset('assets/images/invite.png'),
            // ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 8),
              child:  Text(
                LocaleKeys.MainItems_InviteYourFriends.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 16),
              child:  Text(
                LocaleKeys.SignupLogin_Areyouoneofthose.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          //method here for functionality
                          final box = context.findRenderObject() as RenderBox?;
                          Share.share('check out my website https://example.com', subject: 'Look what I made!',sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 22,
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
