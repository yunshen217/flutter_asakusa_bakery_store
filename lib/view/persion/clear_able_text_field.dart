import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';

/// 带有清除按钮的输入框
class ClearableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final bool isNum;
  final bool isPsd;
  final dynamic margin;

  const ClearableTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.readOnly = false,
      this.isNum = false,
      this.isPsd = false,
      this.margin = const EdgeInsets.symmetric(horizontal: 15)})
      : super(key: key);

  @override
  State<ClearableTextField> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // クリアボタンを表示するかどうかを判断する
    final showClear = _hasFocus && widget.controller.text.isNotEmpty;

    return customWidget.setTextField(
      widget.controller,
      _focusNode,
      hintText: widget.hintText,
      circular: 5,
      readOnly: widget.readOnly,
      keyboardType: widget.isNum ? TextInputType.number : TextInputType.text,
      inputFormatters: widget.isNum
          ? [
              FilteringTextInputFormatter.digitsOnly, // 只允许输入数字（0-9）
            ]
          : null,
      isShow: true,
      obscureText: widget.isPsd,
      suffixIcon: showClear
          ? GestureDetector(
              onTap: () => widget.controller.clear(),
              child: customWidget.setAssetsImg(
                "icon_clear.png",
                width: 24,
                margin: const EdgeInsets.all(13),
              ),
            )
          : null,
      borderSide: BorderSide(
        color: widget.readOnly
            ? CustomColor.blackD.withOpacity(0.7)
            : CustomColor.blackD,
        width: 0.5,
      ),
      margin: widget.margin,
    );
  }
}
