import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
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
                    autovalidateMode: AutovalidateMode.disabled, // 关闭边输入边校验
                    child: Column(
                      children: [
                        customWidget.setCard(
                            height: 340,
                            margin:
                                EdgeInsets.only(top: 220, left: 30, right: 30),
                            child: Column(
                              children: [
                                customWidget.setText('ログイン',
                                    color: CustomColor.redE8,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                // 邮箱框
                                customWidget.setTextFieldForLogin(
                                    accountController,
                                    icon: "icon_msg.png",
                                    autofocus: true,
                                    autofillHints: [AutofillHints.email],
                                    hintText: "ユーザーIDを入力してください",
                                    keyboardType: TextInputType.emailAddress,
                                    margin: const EdgeInsets.only(
                                        top: 30, bottom: 10)),
                                // 密码框
                                customWidget.setTextFieldForLogin(pwController,
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
                                    obscureText: obscureText.value),
                                    InkWell(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: customWidget.setText("パスワードを忘れた場合",
                                            margin: const EdgeInsets.only(top: 10, )),
                                        ),
                                        onTap: () => Routes.goPage(context, "/ForgetPage", param: {
                                              Constant.FLAG: accountController?.text.trim()
                                            })),
                                // 登录按钮
                                customWidget.setCupertinoButton("ログイン",minimumSize: Get.width-100,margin: const EdgeInsets.only(top: 15),onPressed: (){
                                  if(isLogin()){

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
  // 检查是否为null
  isLogin(){
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
