import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:get/get.dart';

class ToLoginPage extends StatelessWidget {
  const ToLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: customWidget.setCupertinoButton("ログインしてください",
          padding: const EdgeInsets.symmetric(horizontal: 15),
          fontWeight: FontWeight.normal,
          color: CustomColor.blackD,
          textColor: CustomColor.black_3, onPressed: () {
        customWidget.showConfirmDialog(
          context,
          title: "",
          cancelText: "キャンセル",
          submitText: "ログイン",
          child:
              customWidget.setText("ログインしてください", textAlign: TextAlign.center),
          contentPadding: const EdgeInsets.only(bottom: 10),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          cancelBtnIsOutLinedButton: false,
          onPressed: () {
            Get.back();
            Routes.goPage('/LoginPage');
          },
        );
      }),
    );
  }
}
