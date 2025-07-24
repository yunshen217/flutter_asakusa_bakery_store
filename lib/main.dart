import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/common/InitEventBus.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/navigation_service.dart';
import 'package:flutter_asakusa_bakery_store/page/home/home_page.dart';
import 'package:flutter_asakusa_bakery_store/page/order/order_page.dart';
import 'package:flutter_asakusa_bakery_store/page/person/person_page.dart';
import 'package:flutter_asakusa_bakery_store/view/NavigationIconView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) =>
      runApp(const MyApp())); //Global.init()返回`Future的异步方法，首屏加载前执行全局的初始化工作
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return CustomColor.redE8;
                }
                return Colors.grey;
              }),
            ),
            appBarTheme: const AppBarTheme(
                color: Colors.white, surfaceTintColor: Colors.transparent),
            scaffoldBackgroundColor: Colors.white),
        // onGenerateRoute: onGenerateRoute,
        // initialRoute: Global.token.isEmpty ? "/LoginPage" : "/",
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey, // 设置 navigatorKey
        // routes: {
        //   '/LoginPage': (context) => const LoginPage(),
        //   // 其他页面路由
        // },
        // initialRoute: '/LoginPage',
        getPages: Routes.pages,
        home: const MyHomePage()
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///底部bottom tab start
  int _selectedIndex = 0;

  ///tab展示的界面
  final tabs = [const HomePage(), const OrderPage(), const PersonPage()];

  /// tab 展示title
  final tabTitle = ['オーダー', "計画＆予約", "マイ店舗"];
  List<NavigationIconView> _navigationIconView = [];
  List<String> bottomSelectIcons = [
    "order_bar_select@3x.png",
    "reservate_bar_select@3x.png",
    "order_bar_select@3x.png"
  ];
  List<String> bottomUnSelectIcons = [
    "order_bar@3x.png",
    "reservate_bar@3x.png",
    "person_bar@3x.png"
  ];

  @override
  void initState() {
    Global.context = context;
    EventBusUtil.listen((e) {
      if (e == Constant.ID) {
        //_onItemTapped(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _navigationIconView = [
      for (var i = 0; i < tabTitle.length; i++)
        NavigationIconView(
            title: tabTitle[i],
            icon: bottomUnSelectIcons[i],
            activedIconPath: bottomSelectIcons[i])
    ];

    return BaseScaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        body: IndexedStack(index: _selectedIndex, children: tabs),
        onBack: () => exit(0));
  }

  ///底部菜单栏
  _bottomNavigationBar() => BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: _navigationIconView.map((view) => view.item).toList(),
      onTap: _onItemTapped,
      selectedItemColor: CustomColor.redE8,
      selectedLabelStyle:
          customWidget.setTextStyle(color: CustomColor.redE8, fontSize: 13),
      unselectedItemColor: CustomColor.black_3,
      unselectedLabelStyle: customWidget.setTextStyle(
          color: CustomColor.black_3,
          fontSize: 12,
          fontWeight: FontWeight.normal));

  void _onItemTapped(int value) {
    setState(() => _selectedIndex = value);
    // if (_selectedIndex == 2 && Global.userInfo!.refreshToken == null) {
    //   customWidget.showCustomSingleBtnDialog(context,
    //       confirm: () => Routes.goPage(context, "/LoginPage"));
    // } else if (_selectedIndex == 2) {
    //   EventBusUtil.fire(Constant.REFRESH_O);
    // }
  }
}
