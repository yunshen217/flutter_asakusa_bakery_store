import 'dart:collection';
import 'package:flutter/cupertino.dart';

import '../page/login/login_page.dart';
import '../page/home/home_page.dart';
import '../page/order/order_page.dart';
import '../page/person/person_page.dart';

final routes = {
  ///登陆
  '/LoginPage': (content, {arguments}) => const LoginPage(),

  ///订单
  '/OrderPage': (content, {arguments}) => const OrderPage(),

  ///选择地址
  '/HomePage': (content, {arguments}) => const HomePage(),

  ///修改密码
  '/PersonPage': (content, {arguments}) => const PersonPage(),

  ///忘记密码
  // '/ForgetPage': (content, {arguments}) => ForgetPage(arguments),
};

//固定写法命名路由传参
// ignore: missing_return, top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name]!;
  if (settings.arguments != null) {
    return CupertinoPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
  } else {
    return CupertinoPageRoute(
        builder: (context) => pageContentBuilder(context));
  }
};

class Routes {
  Routes._();

  static List<BuildContext> pages = [];

  ///路由 LinkedHashMap map = LinkedHashMap.from({'arg': '111'});
  ///接受构造方法  /Demo': (content, {arguments}) => Demo(arguments)
  static void goPage(BuildContext context, String pagePath,
      {Map<dynamic, dynamic>? param}) {
    Navigator.pushNamed(context, pagePath,
        arguments: param ?? {} as LinkedHashMap);
    // Get.toNamed("pagePath", parameters: map);
  }

  ///路由 LinkedHashMap map = LinkedHashMap.from({'arg': '111'});
  ///接受构造方法  /Demo': (content, {arguments}) => Demo(arguments)
  static void goPageForResult(BuildContext context, String pagePath,
      {Map<dynamic, dynamic>? param, then}) {
    Navigator.pushNamed(context, pagePath,
            arguments: param ?? {} as LinkedHashMap)
        .then((value) => then(value));
    // Get.toNamed("pagePath", parameters: map);
  }

  ///路由 LinkedHashMap map = LinkedHashMap.from({'arg': '111'});  关闭跳转界面
  ///接受 接受构造方法 /Demo': (content, {arguments}) => Demo(arguments)
  static void goPageAndFinish(BuildContext context, String pagePath,
      {Map<dynamic, dynamic>? param}) {
    Navigator.pushReplacementNamed(context, pagePath,
        arguments: param ?? {} as LinkedHashMap);
  }

  static void finishPage(
      {BuildContext? context,
      LinkedHashMap<dynamic, dynamic>? map,
      dynamic param}) {
    if (Navigator.canPop(context!)) Navigator.pop(context, param);
  }

  ///fromPage 为当前页
  ///eg:A=>B=>C=>D=>E
  ///fromPage为 B 调用此方法 只有 B界面和主页面“/”存活
  ///其余界面会被干掉
  ///(Route<dynamic> route) => false 只存活一个界面 String fromPage
  static void pushNamedAndRemoveUntil(
      {BuildContext? context,
      String? fromPage,
      Map? param,
      bool isRoute = true}) {
    Navigator.pushNamedAndRemoveUntil(context!, fromPage!,
        isRoute ? ModalRoute.withName("/") : (Route<dynamic> route) => false,
        arguments: param);
  }

  ///关闭制定界面集合 start
  ///添加page的 context
  ///isClear 添加银行卡的分支
  ///默认为true
  ///当为 false [popPage] 配合使用 popPage 参数二 给为false
  ///[removePage]联合使用
  /// @override
  //   void initState() {
  //     Routes.addPage(context);
  //     print("B===>initState");
  //     super.initState();
  //   }
  static addPage(BuildContext page) => pages.add(page);

  ///移除page的 context
  ///[addPage]联合使用
  // @override
  // void dispose() {
  //   print("B===>dispose");
  //   Routes.removePage(context);
  //   super.dispose();
  // }
  static removePage(BuildContext page) {
    if (pages.isNotEmpty) pages.removeLast();
  }

  ///关闭制定界面集合
  ///eg:A=>B=>C=>D=>E
  ///此时C和D界面 在initStats调用了[addPage]方法
  ///用户在<E>界面点击[popPage]及关闭了C和D界面 A和B界面依然存活
  static popPage() {
    print("object");
    for (var element in pages) {
      finishPage();
    }
    pages.clear();
  }
}
