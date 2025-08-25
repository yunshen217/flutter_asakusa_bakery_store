import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asakusa_bakery_store/common/InitEventBus.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/push_messages.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController? accountController = TextEditingController();
  TextEditingController? pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool obscureText = true.obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // accountController!.text="1246158996@qq.com";
    // pwController!.text="Aa112233";
    accountController!.text="weidong.sun@eagletech-global.com";
    pwController!.text="AX98Yn5tHBgyBcW";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      body: Stack(
        children: [
          customWidget.setAssetsImg("login_back@3x.png",
              width: Get.width, height: 400),
          Container(
              height: 80,
              margin: const EdgeInsets.only(top: 350),
              decoration: const BoxDecoration(
                  color: CustomColor.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35)))),
          SingleChildScrollView(
            child: AutofillGroup(
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        customWidget.setCard(
                            height: 340,
                            margin: const EdgeInsets.only(
                                top: 220, left: 30, right: 30),
                            child: Column(
                              children: [
                                customWidget.setText('ログイン',
                                    color: CustomColor.redE8,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                customWidget.setTextFieldForLogin(
                                    accountController,
                                    icon: "icon_msg.png",
                                    autofocus: true,
                                    autofillHints: [AutofillHints.email],
                                    hintText: "ユーザーIDを入力してください",
                                    keyboardType: TextInputType.emailAddress,
                                    margin: const EdgeInsets.only(
                                        top: 30, bottom: 10)),
                                Obx(()=>customWidget.setTextFieldForLogin(pwController,
                                    maxLength: 16,
                                    autofillHints: [AutofillHints.password],
                                    hintText: "パスワードを入力してください（6-8桁半角英数字の組合せ）",
                                    icon: "icon_pw.png",
                                    suffix: IconButton(
                                        onPressed: () => obscureText.value =
                                            !obscureText.value,
                                        icon: !obscureText.value
                                            ? const Icon(CupertinoIcons.eye)
                                            : const Icon(
                                                CupertinoIcons.eye_slash,
                                                color: CustomColor.grayC5)),
                                    obscureText: obscureText.value)),
                                InkWell(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: customWidget.setText("パスワードを忘れた場合",
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                          )),
                                    ),
                                    onTap: () => Routes.goPage("/ForgetPage",
                                            param: {
                                              Constant.FLAG:
                                                  accountController?.text.trim()
                                            })),
                                customWidget.setCupertinoButton("ログイン",
                                    width: Get.width - 100,
                                    margin: const EdgeInsets.only(top: 15),
                                    onPressed: () async {
                                  if (isLogin()) {
                                    if (Global.token.isEmpty) {
                                      try {
                                        // 添加async/await等待设备令牌获取完成
                                        await pushMessages.getDeviceToken();
                                        // 添加上下文有效性检查
                                        if (!context.mounted) return;
                                      } catch (e) {
                                        print("获取设备令牌失败: $e");
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('デバイストークン獲得失敗')),
                                          );
                                        }
                                        return;
                                      }
                                    }
                                    backEndRepository
                                        .doPost(Constant.login, params: {
                                      "email": accountController!.text,
                                      "password": pwController!.text,
                                      "deviceToken": Global.token
                                    }, successRequest: (res) {
                                      _formKey.currentState?.save();
                                      TextInput.finishAutofillContext();
                                      Global.putUserInfo(res['data']);
                                      Routes.pushNamedAndRemoveUntil('/MyHomePage');
                                      EventBusUtil.fire(Constant.FLAG);
                                      EventBusUtil.fire(Constant.REFRESH_O);
                                    });
                                  }
                                })
                              ],
                            )),
                      ],
                    ))),
          )
        ],
      ),
    );
  }

  isLogin() {
    if (accountController!.text.trim().isEmpty) {
      customWidget.toastShow("ユーザーIDを入力してください", notifyType: NotifyType.warning);
      return false;
    } else if (!utils.isPw(pwController!.text.trim())) {
      customWidget.toastShow("パスワードフォーマットエラー", notifyType: NotifyType.warning);
      return false;
    }
    return true;
  }
}
