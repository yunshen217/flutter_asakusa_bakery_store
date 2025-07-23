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

//自定义底部导航栏itme

class NavigationIconView {
  final BottomNavigationBarItem item;

  //标题
  final String title;

  //图标
  final String icon;

  //选中图标路径
  final String activedIconPath;

  NavigationIconView(
      {required this.title, required this.icon, required this.activedIconPath})
      : item = BottomNavigationBarItem(
            //默认图标
            icon: customWidget.setAssetsImg(icon),
            //选中状态
            activeIcon: customWidget.setAssetsImg(activedIconPath),
            label: title);
}
