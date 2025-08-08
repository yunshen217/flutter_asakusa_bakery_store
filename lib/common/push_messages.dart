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
      // 初始化 Firebase
      await Firebase.initializeApp();
      // 请求推送权限
      _requestPermissions();
      // 监听应用处于前台时的推送消息
      print("监听应用处于前台时的推送消息");
      FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
      // 监听后台时的推送消息。
      print("监听后台时的推送消息。");
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      // 监听用户点击通知后的事件。
      print("监听用户点击通知后的事件。");
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

      ///监听后台通知点击事件
      print("监听后台通知点击事件");
      RemoteMessage? initialMessage = await FirebaseMessaging.instance
          .getInitialMessage(); // 获取初始消息，通常用于当用户点击推送通知打开应用时。
      print("获取初始消息，通常用于当用户点击推送通知打开应用时。----------- $initialMessage");
      if (initialMessage != null) {
        print('App was opened from a notification!');
        print('Message data: ${initialMessage.data}');
        if (initialMessage.notification != null) {
          print(
              'Message also contained a notification: ${initialMessage.notification}');
        }
        // 在这里可以根据消息内容执行相应的导航或操作
      }
      // 获取设备的 Firebase 推送令牌，用于推送消息。
      await getDeviceToken();
    } catch (e) {
      print("====>$e");
    }
  }

  ///前台消息(根据不同的接收消息，进入不同的页面)
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

  /// 监听前台通知点击事件
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

  

  ///token  获取设备的推送令牌并存储在 Global.putToken() 中。这个令牌用于发送推送通知。
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

  /// 请求推送权限
  Future<void> _requestPermissions() async {
    // 获取 Firebase 消息推送的实例
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true, // 允许显示通知的弹出框
        announcement: false, // 不允许语音通知
        badge: true, // 允许更新应用图标的徽章数量。徽章通常是一个数字，显示在应用图标上，通常用来表示未读消息的数量。
        carPlay: false, // 不支持在 Apple CarPlay 中显示通知
        criticalAlert:
            false, // 是否允许显示关键性警告（即使设备在静音模式下也能响铃的通知）。通常，重要通知（如紧急事件或系统警告）会使用该权限。
        provisional: false, // 是否允许临时授权通知，表示不需要立即要求用户授权，但应用仍可以发送通知。
        sound: true // 是否允许推送通知播放声音
        );
    // 用户已完全授权接收通知
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // 用户授权了临时通知权限
      print('User granted provisional permission');
    } else {
      // 用户拒绝了通知权限或未做任何选择
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
      print("Deep Link 监听失败: $err");
    });
  }
}
///后台消息
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Firebase SDK 的初始化
    // 通常在应用启动时只需要调用一次，但在后台或终止状态下接收推送时可能需要再次初始化 Firebase。
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
