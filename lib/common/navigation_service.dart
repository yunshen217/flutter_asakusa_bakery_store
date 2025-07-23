/*
 * @Author: liuchen 1246158996@qq.com
 * @Date: 2025-07-21 13:46:51
 * @LastEditors: liuchen 1246158996@qq.com
 * @LastEditTime: 2025-07-23 15:54:41
 * @FilePath: /flutter_asakusa_bakery_store/lib/common/navigation_service.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'custom_widget.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static void goLoginPage() {
    customWidget.showCustomSingleBtnDialog(context,
        confirm: () => Routes.goPage(context!, "/LoginPage"));
    //navigatorKey.currentState?.pushNamedAndRemoveUntil('/LoginPage', (route) => false);
  }
}
