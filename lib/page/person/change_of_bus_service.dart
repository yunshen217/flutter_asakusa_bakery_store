import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';

/// バスフ-ドの変更
class ChangeOfBusService extends StatefulWidget {
  const ChangeOfBusService({super.key});

  @override
  State<ChangeOfBusService> createState() => _ChangeOfBusServiceState();
}

class _ChangeOfBusServiceState extends State<ChangeOfBusService> {
  // 現在のバスフ一ド
  TextEditingController oldPsdController = TextEditingController();
  // 新しいバスフ一ド
  TextEditingController newPsdController = TextEditingController();
  // 確認パスフ一ド
  TextEditingController confirmPsdController = TextEditingController();
  updatePassword() async {
    Map<String, dynamic> params = {
      "oldPassword": oldPsdController.text,
      "password": newPsdController.text,
      "repeatPassword": confirmPsdController.text
    };
    await backEndRepository.doPut(
      Constant.updatePassword,
      params: params,
      successRequest: (result) {
        customWidget.toastShowNotIcon("オ一ダ一の送信に成功しました");
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "バスフ一ドの変更",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoWidget.titleWidget("現在のバスフ一ド", false),
            ClearableTextField(
                controller: oldPsdController,
                hintText: "現在のバスフ一ド",
                readOnly: false,
                isPsd: true),
            infoWidget.titleWidget("新しいバスフ一ド", false),
            ClearableTextField(
                controller: newPsdController,
                hintText: '新しいバスフ一ド',
                readOnly: false,
                isPsd: true),
            infoWidget.titleWidget("確認パスフ一ド", false),
            ClearableTextField(
                controller: confirmPsdController,
                hintText: '確認パスフ一ド',
                readOnly: false,
                isPsd: true),
            customWidget.setTextOverflow("八スフ一下規則:6-8析半角英数字の組合せ",
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                fontSize: 12,
                color: CustomColor.black_9),
            Align(
              alignment: Alignment.center,
              child: customWidget.setCupertinoButton("保存",
                  minimumSize: Get.width - 60,
                  height: 40,
                  circular: 50,
                  fontWeight: FontWeight.normal,
                  margin: const EdgeInsets.only(top: 15), onPressed: () {
                if (oldPsdController.text.trim() == "") {
                  customWidget.toastShowNotIcon("現在のパスワードを入力してください");
                  return;
                }
                if (newPsdController.text.trim() == "") {
                  customWidget.toastShowNotIcon("新しいパスワードを入力してください");
                  return;
                }
                if (confirmPsdController.text.trim() == "") {
                  customWidget.toastShowNotIcon("新しいパスワード(確認)を入力してください");
                  return;
                }
                if (newPsdController.text.trim() !=
                    confirmPsdController.text.trim()) {
                  customWidget.toastShowNotIcon("パスワードが一致していません。もう一度ご確認ください。");
                  return;
                }
                updatePassword();
              }),
            )
          ],
        ),
      ),
    );
  }
}
