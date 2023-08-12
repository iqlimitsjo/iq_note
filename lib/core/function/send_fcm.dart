import 'dart:convert';

import 'package:http/http.dart' as http;

sendFCM(
    {required String topic,
    required String title,
    required String body,
    String? pageId,
    String? pageName}) async {
  String fcmUrl = "https://fcm.googleapis.com/fcm/send";
  String fcmKey =
      "AAAAjXxSex8:APA91bGodELbaxdR0WpI2XEY3wbeUxxungbd9HvmwtOugANaksmyLsDqUmF0jpPq5kNH-xmaSqdbt3QP82I367DqX_jTz7tto1Jj-2zGJr8uwp-9syWeL76rk42W6Tt979siLHLCEzZQ";
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$fcmKey'
  };
  final Map<String, dynamic> message = {
    "to": "/topics/$topic",
    "priority": "high",
    'content_available': true,
    "notification": {
      "title": title,
      "body": body,
      "sound": "default",
    },
    "data": {
      "page_id": pageId,
      "page_name": pageName,
    }
  };

  var response = await http.post(Uri.parse(fcmUrl),
      headers: headers, body: jsonEncode(message));
  print(response.body);
  if (response.statusCode == 200) {
  } else {}
}
