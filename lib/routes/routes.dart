import 'package:flutter_asakusa_bakery_store/main.dart';
import 'package:flutter_asakusa_bakery_store/page/login/forget_page.dart';
import 'package:flutter_asakusa_bakery_store/page/order/order_detail.dart';
import 'package:flutter_asakusa_bakery_store/page/order/reservation_details.dart';
import 'package:flutter_asakusa_bakery_store/page/person/Inbound_and_outbound_storage.dart';
import 'package:flutter_asakusa_bakery_store/page/person/change_of_bus_service.dart';
import 'package:flutter_asakusa_bakery_store/page/person/in_library_detail.dart';
import 'package:flutter_asakusa_bakery_store/page/person/in_library_management.dart';
import 'package:flutter_asakusa_bakery_store/page/person/material_addition.dart';
import 'package:flutter_asakusa_bakery_store/page/person/notice_page.dart';
import 'package:flutter_asakusa_bakery_store/page/person/product_detail.dart';
import 'package:flutter_asakusa_bakery_store/page/person/product_management.dart';
import 'package:flutter_asakusa_bakery_store/page/person/store_setup.dart';
import 'package:flutter_asakusa_bakery_store/page/person/time_management.dart';
import 'package:get/get.dart';

import '../page/login/login_page.dart';
import '../page/home/home_page.dart';
import '../page/order/order_page.dart';
import '../page/person/person_page.dart';

class Routes {
  Routes._();

  // ルートリスト
  static final List<GetPage> pages = [
    GetPage(name: '/MyHomePage', page: () => const MyHomePage()),
    GetPage(name: '/LoginPage', page: () => const LoginPage()),
    GetPage(name: '/OrderPage', page: () => const OrderPage()),
    GetPage(name: '/HomePage', page: () => const HomePage()),
    GetPage(name: '/PersonPage', page: () => const PersonPage()),
    GetPage(name: '/ForgetPage', page: () => const ForgetPage()),
    // 注文の詳細
    GetPage(name: '/OrderDetail', page: () => const OrderDetail()),
    // 予約の詳細1
    GetPage(
        name: '/ReservationDetails', page: () => const ReservationDetails()),
    // 通知
    GetPage(name: '/NoticePage', page: () => const NoticePage()),
    // 店舗設定
    GetPage(name: '/StoreSetup', page: () => const StoreSetup()),
    // 時間管理
    GetPage(name: '/TimeManagement', page: () => const TimeManagement()),
    // 商品管理
    GetPage(name: '/ProductManagement', page: () => const ProductManagement()),
    // 商品詳細
    GetPage(name: '/ProductDetail', page: () => const ProductDetail()),
    // 在庫管理
    GetPage(
        name: '/InLibraryManagement', page: () => const InLibraryManagement()),
    // 材料の追加
    GetPage(name: '/MaterialAddition', page: () => const MaterialAddition()),
    // 倉庫の詳細
    GetPage(name: '/InLibraryDetail', page: () => const InLibraryDetail()),
    // 入出庫
    GetPage(
        name: '/InboundAndOutboundStorage',
        page: () => const InboundAndOutboundStorage()),
    // バスフ-ドの変更
    GetPage(
        name: '/ChangeOfBusService', page: () => const ChangeOfBusService()),
  ];

  // Get.to() を使用してページを移動する
  static void goPage(String pagePath, {Map<String, dynamic>? param}) {
    Get.toNamed(pagePath, arguments: param);
  }

  // ページを移動し、結果を受け取る
  static void goPageForResult(String pagePath,
      {Map<String, dynamic>? param, required Function then}) {
    Get.toNamed(pagePath, arguments: param)?.then((value) => then(value));
  }

  // ページを切り替えて現在のページを置き換える
  static void goPageAndFinish(String pagePath, {Map<String, dynamic>? param}) {
    Get.offNamed(pagePath, arguments: param);
  }

  // 現在のページを閉じる
  static void finishPage({dynamic param}) {
    Get.back(result: param);
  }

  // ジャンプして以前のすべてのページを削除する
  static void pushNamedAndRemoveUntil(String fromPage,
      {Map<String, dynamic>? param, bool isRoute = true}) {
    Get.offAllNamed(fromPage, arguments: param);
  }
}
