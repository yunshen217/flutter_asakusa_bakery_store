import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';

/// 带有清除按钮的输入框
class ClearableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;

  const ClearableTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<ClearableTextField> createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<ClearableTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    // 添加焦点监听器
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    // 监听文本变化
    widget.controller.addListener(() {
      setState(() {}); // 当文本变化时重新构建widget
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();  // 销毁焦点节点
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 判断是否显示清除按钮
    final showClear = _hasFocus && widget.controller.text.isNotEmpty;

    return customWidget.setTextField(
      widget.controller,
      _focusNode,
      hintText: widget.hintText,
      circular: 5,
      readOnly: widget.readOnly,
      isShow: true,
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
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
