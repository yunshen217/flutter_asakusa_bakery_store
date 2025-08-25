import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:uni_links/uni_links.dart';
final pushMessages = PushMessages();
class PushMessages {
  initFCM() async {
    try {
      await Firebase.initializeApp();
      _requestPermissions();
      FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        print('App was opened from a notification!');
        print('Message data: ${initialMessage.data}');
        if (initialMessage.notification != null) {
          print(
              'Message also contained a notification: ${initialMessage.notification}');
        }
      }
      await getDeviceToken();
    } catch (e) {
      print("====>$e");
    }
  }

  Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.data['messageType'] != "0") {
      Routes.goPage("/OrderDetailPage",
          param: {Constant.ID: message.data['orderId']});
    } else {
      Routes.goPage("/MessagePage", param: {'tabIndex': 1});
    }
  }

  _onMessageOpenedApp(RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print('Message data: ${message.data}');
    if (message.data['messageType'] != "0") {
      Routes.goPage("/OrderDetailPage",
          param: {Constant.ID: message.data['orderId']});
    } else {
      Routes.goPage("/MessagePage", param: {'tabIndex': 1});
    }
  }

  

  Future<void> getDeviceToken() async {
    if (Platform.isIOS) {
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('Device Token: $token');
      Global.putToken(token);
    } else {
      String? token = await FirebaseMessaging.instance.getToken();
      print('Device Token: $token');
      Global.putToken(token);
      // final fid = await FirebaseInstallations.id;
      // print('FID = $fid'); 
    }
    // String? token = await FirebaseMessaging.instance.getToken();
    // Global.putToken(token);
    // print('Device Token: $token');
  }

  Future<void> _requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true, 
        announcement: false, 
        badge: true, 
        carPlay: false,
        criticalAlert:
            false,
        provisional: false, 
        sound: true 
        );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  StreamSubscription? _deepLinkSub;

  void initDeepLinkListener() {
    _deepLinkSub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print("收到 Deep Link: $uri");
        if (uri.scheme == "user" &&
            uri.host == "order" &&
            uri.path == "/completed") {
          //
        }
      }
    }, onError: (err) {
      print("Deep Link リスニングに失敗しました: $err");
    });
  }
}
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print(message);
    print('Handling a background message: ${message.messageId}');
    if (message.data != null) {
      if (message.data['messageType'] != "0") {
        Routes.goPage("/OrderDetailPage",
            param: {Constant.ID: message.data['orderId']});
      } else {
        Routes.goPage("/MessagePage", param: {'tabIndex': 1});
      }
    }
  }
