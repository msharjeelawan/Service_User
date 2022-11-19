import 'dart:convert';

import 'package:http/http.dart' as client;

class FirebaseNotificationClient{

  final String _host="https://fcm.googleapis.com/fcm/send";
  final _serverKey="AAAAk2J4Kx8:APA91bFiLn_MEdQG6w1iN3mdpxJk1ahQ5RRkDJXeHSVTnrlJYB5055GONauzs-gvZnhReKjrVZecyBI6l0r5S5AIotKeGNvXVIggkDl49Mb8sarY6lB-uCs1RKW7xZKDbknuTmB4eDn6";
  void sendNotificationRequest({required String token,required String title,required String notificationBody,required Map data}) async{
    final header={"Authorization":"key=$_serverKey","Content-Type": "application/json; charset=UTF-8"};
    final body={
      "to":"/topics/job",
      "notification" : {
        "title": title,
        "body" : notificationBody,
        "priority":"high",
        "content-available":true
      },
      "data":data
    };
    final response = await client.post(Uri.parse(_host),headers: header,body: jsonEncode(body));
   // print(response.body);
  }

}