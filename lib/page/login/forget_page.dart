import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController? accountController = TextEditingController();
  final map = Get.arguments;
  @override
  void initState() {
    accountController?.text = map[Constant.FLAG];
    super.initState();
  }

  @override
  void dispose() {
    accountController?.dispose();
    super.dispose();
  }
  isAccountPass() {
    if (!utils.isEmail(accountController!.text.toString().trim())) {
      customWidget.toastShow("メールアドレスが不正です", notifyType: NotifyType.warning);
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.bg,
      appBar: customWidget.setAppBar(
          title: "パスフ-ドを忘れた場合",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          )),
         body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customWidget.setText("ご登録済のメールアドレスを入力してください。新しいパスワードはご登録のメールアドレスに送信されます。",
              margin: const EdgeInsets.all(15)),
          customWidget.setTextFieldForLogin(accountController,
              icon: "icon_msg.png",
              autofocus: true,
              hintText: "ユーザーIDを入力してください",
              keyboardType: TextInputType.emailAddress,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10)),
          customWidget.setCupertinoButton("送信",
              minimumSize: utils.getScreenSize.width,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 30), onPressed: () {
            if (isAccountPass()) {
              backEndRepository.doPost(Constant.resetAccountPassword,
                  params: {"email": accountController?.text}, successRequest: (e) {
                customWidget.toastShow("操作が成功しました");
                Get.back();
              });
            }
          })
        ],
      ),
    );
  }
}