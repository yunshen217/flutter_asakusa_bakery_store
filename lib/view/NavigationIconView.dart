/*
 * @Author: liuchen 1246158996@qq.com
 * @Date: 2025-07-23 10:32:40
 * @LastEditors: liuchen 1246158996@qq.com
 * @LastEditTime: 2025-07-23 10:32:52
 * @FilePath: /flutter_asakusa_bakery_store/lib/view/NavigationIconView.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';


class NavigationIconView {
  final BottomNavigationBarItem item;

  final String title;

  final String icon;

  final String activedIconPath;

  NavigationIconView(
      {required this.title, required this.icon, required this.activedIconPath})
      : item = BottomNavigationBarItem(
            icon: customWidget.setAssetsImg(icon),
            activeIcon: customWidget.setAssetsImg(activedIconPath),
            label: title);
}
