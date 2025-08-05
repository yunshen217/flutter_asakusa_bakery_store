import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
/// 忘记密码
class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: customWidget.setAppBar(
        title: "忘记密码"
      ),
    );
  }
}