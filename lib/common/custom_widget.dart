//自定义封装类

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';
import "../common/custom_color.dart";

final customWidget = CustomWidget();

typedef ChooseSureCallBack = void Function();
typedef ChooseCancelCallBack = void Function();

class CustomWidget {
  bool _isDialogShowing = false;
  AppBar setAppBar(
      {String? title = "",
      bool isLeftShow = true,
      bool isRightShow = false,
      backgroundColor = Colors.white,
      color = Colors.black,
      isTitle = true,
      centerTitle = true,
      Widget? titleChild,
      Widget? right,
      PreferredSizeWidget? bottom,
      Widget? leading,
      onTap,
      onPressed}) {
    return AppBar(
        title: isTitle
            ? setText(title!, fontSize: 16, fontWeight: FontWeight.bold)
            : titleChild,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        elevation: 0.0,
        shadowColor: Colors.black,
        bottom: bottom,
        scrolledUnderElevation: 0, // 去掉滚动阴影
        surfaceTintColor: Colors.transparent,
        leading: isLeftShow ? const BackButton() : leading,
        actions: [
          isRightShow ? InkWell(onTap: onTap, child: right) : Container()
        ]);
  }

  setText(String text,
      {margin = EdgeInsets.zero,
      padding = EdgeInsets.zero,
      Color color = CustomColor.black_3,
      double fontSize = 14.0,
      maxLines = 1,
      TextAlign? textAlign,
      fontWeight = FontWeight.normal}) {
    return Container(
        margin: margin,
        padding: padding,
        child: Text(text,
            textAlign: textAlign ?? TextAlign.left,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: setTextStyle(
                color: color, fontSize: fontSize, fontWeight: fontWeight)));
  }

  /// 横向两边对齐文字
  setRowText(
    String text1,
    String text2, {
    mainAxisAlignment = MainAxisAlignment.spaceBetween,
    margin = const EdgeInsets.all(10),
    text1Color = CustomColor.black_3,
    text2Color = CustomColor.black_3,
    text1FontSize = 14.0,
    text2FontSize = 14.0,
    text1FontWidget = FontWeight.normal,
    text2FontWidget = FontWeight.normal,
  }) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          customWidget.setText(text1,
              color: text1Color,
              fontSize: text1FontSize,
              fontWeight: text1FontWidget),
          customWidget.setText(text2,
              color: text2Color,
              fontSize: text2FontSize,
              fontWeight: text2FontWidget)
        ],
      ),
    );
  }

  /// 有边距的文字
  setTextOverflow(String text,
      {margin = EdgeInsets.zero,
      padding = EdgeInsets.zero,
      Color color = CustomColor.black_3,
      double fontSize = 14.0,
      textAlign = TextAlign.left,
      fontWeight = FontWeight.normal}) {
    return Container(
        margin: margin,
        padding: padding,
        child: Text(text,
            textAlign: textAlign,
            maxLines: null,
            overflow: TextOverflow.visible,
            style: setTextStyle(
                color: color, fontSize: fontSize, fontWeight: fontWeight)));
  }

  setTextStyle({color, double fontSize = 16.0, fontWeight = FontWeight.bold}) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  setTopImgBottomText(
      {icon,
      String? text,
      margin = const EdgeInsets.all(15),
      double fontSize = 12.0,
      double iconSize = 30.0,
      double textTopMargin = 10,
      fontWeight = FontWeight.w500,
      textAlign = TextAlign.left,
      color = CustomColor.black_3,
      onTap}) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: margin,
          child: Column(children: [
            //Icon(icon, size: iconSize, color: CustomColor.hospitalBlue1),
            setAssetsImg(icon,
                width: iconSize, height: iconSize, fit: BoxFit.contain),
            setText(text!,
                textAlign: textAlign,
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
                margin: EdgeInsets.only(top: textTopMargin))
          ]),
        ));
  }

  /// 设置底部横线按钮
  setUnderLineButton(text,
      {margin = EdgeInsets.zero,
      onTap,
      double fontSize = 12,
      fontColor = CustomColor.black_3,
      maxLines = 1,
      TextAlign? textAlign,
      fontWeight = FontWeight.normal,
      double lineWidth = 15,
      double lineHeight = 1,
      double lineTopMargin = 2,
      lineColor = CustomColor.redE8}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        child: Column(
          children: [
            setText(text,
                color: fontColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                maxLines: maxLines,
                textAlign: textAlign),
            Container(
              margin: EdgeInsets.only(top: lineTopMargin),
              height: lineHeight,
              width: lineWidth,
              color: lineColor,
            )
          ],
        ),
      ),
    );
  }

  /// 设置外边框按钮
  setOutLinedButton(text,
      {margin = EdgeInsets.zero,
      Size? minimumSize,
      Size? fixedSize,
      Size? maximumSize,
      double circular = 25.0,
      fontColor = CustomColor.redE8,
      lineColor = CustomColor.redE8,
      double fontSize = 12.0,
      linewidth = 1.0,
      onPressed}) {
    return Container(
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        child: setText(text, color: fontColor, fontSize: fontSize),
        style: TextButton.styleFrom(
            minimumSize: minimumSize,
            backgroundColor: Colors.white,
            fixedSize: fixedSize,
            side: BorderSide(color: lineColor),
            maximumSize: maximumSize,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: lineColor, width: linewidth),
                borderRadius: BorderRadius.circular(circular))),
      ),
    );
  }

  setCupertinoButton(text,
      {double? minimumSize = 100.0,
      margin = EdgeInsets.zero,
      padding = EdgeInsets.zero,
      double height = 45.0,
      double fontSize = 15.0,
      fontWeight = FontWeight.w600,
      color = CustomColor.redE8,
      textColor = Colors.white,
      onPressed}) {
    return Container(
        margin: margin,
        height: height,
        child: CupertinoButton(
            onPressed: onPressed,
            child: setText(text,
                fontSize: fontSize, fontWeight: fontWeight, color: textColor),
            padding: padding,
            disabledColor: CustomColor.grayC5,
            borderRadius: BorderRadius.circular(10.0),
            minSize: minimumSize,
            color: color));
  }

  setAssetsImg(imgPath,
      {double height = 25.0,
      double width = 25.0,
      fit = BoxFit.cover,
      margin = EdgeInsets.zero,
      padding = EdgeInsets.zero}) {
    return Container(
        padding: padding,
        margin: margin,
        child: Image.asset("assets/$imgPath",
            width: width, height: height, fit: fit));
  }

//Icon()FilteringTextInputFormatter.allow("")
  setTextField(controller,
      {hintText,
      icon,
      margin = EdgeInsets.zero,
      keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters,
      maxLength,
      maxLines = 1,
      double top = 0,
      double height = 50,
      isShow = false,
      enabled = true,
      readOnly = false,
      counter = true,
      onChanged,
      obscureText = false,
      Widget? suffixIcon,
      autofocus = false}) {
    var customBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none);
    return Container(
      margin: margin,
      height: height,
      child: TextField(
          autofocus: autofocus,
          obscureText: obscureText,
          controller: controller,
          maxLength: maxLength ?? 16,
          maxLines: maxLines,
          enabled: enabled,
          readOnly: readOnly,
          cursorColor: CustomColor.redE8,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: setTextStyle(
              color: CustomColor.black_3,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          inputFormatters: inputFormatters ?? [],
          // inputFormatters: [inputFormatters],
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: CustomColor.grayF5,
              filled: true,
              contentPadding:
                  EdgeInsets.only(left: 15, top: top, bottom: 0, right: 15),
              counter: counter
                  ? const SizedBox(height: 0, width: 0)
                  : setText("100文字以内", fontSize: 12, color: CustomColor.gray_6),
              hintStyle: setTextStyle(color: CustomColor.gray_9, fontSize: 14),
              border: customBorder,
              focusedBorder: customBorder,
              suffixIcon: !isShow ? null : suffixIcon)),
    );
  }

  toastShow(text, {notifyType = NotifyType.success}) {
    SmartDialog.showNotify(
        msg: text,
        notifyType: notifyType,
        useAnimation: true,
        displayTime: const Duration(milliseconds: 1200),
        animationType: SmartAnimationType.scale);
  }

  setCard(
      {child,
      EdgeInsetsGeometry margin =
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
      padding = const EdgeInsets.all(20.0),
      color = CustomColor.white,
      boxShadowColor = CustomColor.pinkCf,
      double height = 340,
      double dy = 5,
      double dx = 1,
      double blurRadius = 10.0,
      radius = 20.0}) {
    return Container(
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                  color: boxShadowColor,
                  offset: Offset(dx, dy),
                  blurRadius: blurRadius,
                  spreadRadius: 2.0)
            ]),
        child: child);
  }

  setRichText(title, subTitle,
      {color = CustomColor.redE8,
      subtitleColor = CustomColor.black_3,
      subFontWeight = FontWeight.normal,
      fontWeight = FontWeight.normal,
      double fontSize = 13,
      margin = EdgeInsets.zero,
      double subFontSize = 13}) {
    return Container(
        margin: margin,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: title,
              style: setTextStyle(
                  fontWeight: fontWeight, color: color, fontSize: fontSize)),
          TextSpan(
              text: subTitle,
              style: setTextStyle(
                  color: subtitleColor,
                  fontWeight: subFontWeight,
                  fontSize: subFontSize))
        ])));
  }

//        position: const RelativeRect.fromLTRB(400.0, 76.0, 10.0, 0.0),
  showPop(context, items, {x = 400.0, y = 76.0, required onTap(e)}) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(x, y, x + 110, y - 40),
        items: (items as List<dynamic>)
            .map((e) => PopupMenuItem(
                onTap: () => onTap(e['tile']),
                child: Row(children: [
                  Icon(e['iconPath']),
                  setText(e['tile'], margin: const EdgeInsets.only(left: 15))
                ])))
            .toList());
  }

  setTextFieldForLogin(
    controller, {
    hintText,
    margin = EdgeInsets.zero,
    keyboardType = TextInputType.text,
    maxLength = 50,
    height = 50.0,
    enabled = true,
    icon,
    Widget? suffix,
    maxLines = 1,
    obscureText = false,
    inputFormatters = true,
    textInputAction = TextInputAction.done,
    autofocus = false,
    autofillHints = const <String>[],
    onSubmitted,
    onChanged,
    onTap,
  }) {
    var customBorder1 = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: CustomColor.grayC5));
    var customBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: CustomColor.redE8));
    return Container(
        margin: margin,
        height: height,
        child: TextField(
            controller: controller,
            maxLength: maxLength,
            enabled: enabled,
            autofocus: autofocus,
            maxLines: maxLines,
            autofillHints: autofillHints,
            cursorColor: CustomColor.redE8,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            inputFormatters: inputFormatters
                ? [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))]
                : null,
            style: setTextStyle(fontWeight: FontWeight.normal),
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.only(bottom: 5, top: 15, left: 15),
                counter: const SizedBox(height: 0, width: 0),
                hintStyle: setTextStyle(
                    color: CustomColor.grayC5,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
                border: customBorder1,
                suffixIcon: suffix ??
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          if (onTap != null) {
                            onTap.call();
                          }
                          controller.clear();
                        },
                        icon: const Icon(Icons.cancel_rounded,
                            color: CustomColor.grayC5)),
                prefixIcon: icon != null
                    ? setAssetsImg(icon,
                        margin: const EdgeInsets.only(left: 10, right: 10))
                    : null,
                prefixIconConstraints: const BoxConstraints(maxHeight: 25),
                focusedBorder: customBorder)));
  }

  setTextFieldForOtherForClear(TextEditingController? controller,
      {hintText,
      margin = EdgeInsets.zero,
      keyboardType = TextInputType.text,
      maxLength = 50,
      height = 50.0,
      enabled = true,
      onChanged,
      onTap,
      maxLines = 1,
      autofocus = false}) {
    var customBorder1 = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColor.grayF5));
    var customBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: CustomColor.redE8));
    return Container(
        margin: margin,
        height: height,
        child: TextField(
            controller: controller,
            maxLength: maxLength,
            enabled: enabled,
            cursorHeight: 20,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            autofocus: autofocus,
            maxLines: maxLines,
            keyboardType: keyboardType,
            onChanged: (e) => onChanged(e),
            style: setTextStyle(fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
                counter: const SizedBox(height: 0, width: 0),
                hintStyle: setTextStyle(color: CustomColor.grayF5),
                border: customBorder1,
                focusedBorder: customBorder)));
  }

  setCardForHeight(
      {child,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      EdgeInsetsGeometry padding = EdgeInsets.zero,
      color = CustomColor.redE8,
      radius = 10.0,
      right = 0.0,
      double height = 40,
      double width = double.infinity,
      onTap}) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: height,
            alignment: Alignment.centerLeft,
            padding: padding,
            width: width,
            margin: margin,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: CustomColor.grayF5)),
            child: child));
  }

  showCustomDialog(context,
      {title = "温馨提示",
      String? content = "",
      isChild = false,
      confirmTitle = "確定",
      child,
      confirm,
      single = false}) {
    return showAdaptiveDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Center(child: setText(title, fontWeight: FontWeight.bold)),
            content: Center(
                child: isChild
                    ? child
                    : setText(content!,
                        maxLines: 50, fontWeight: FontWeight.w500)),
            insetAnimationDuration: const Duration(milliseconds: 500),
            insetAnimationCurve: Curves.linear,
            actions: [
              CupertinoDialogAction(
                  child: setText("キャンセル"),
                  onPressed: () => Routes.finishPage(context: context)),
              CupertinoDialogAction(
                  child: setText(confirmTitle, color: CustomColor.redE8),
                  onPressed: () {
                    Routes.finishPage(context: context);
                    confirm();
                  })
            ],
          );
        });
  }

  showCustomNoTitleDialog(context,
      {title = "日付を選択してください",
      String? content = "",
      isChild = false,
      child,
      confirm,
      single = false}) {
    return showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return SimpleDialog(
            title: Center(
                child: setText(title,
                    color: CustomColor.redE8, fontWeight: FontWeight.bold)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            backgroundColor: CustomColor.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: [
              child,
              setCupertinoButton("選択する",
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  onPressed: () {
                Routes.finishPage(context: context);
                confirm();
              })
            ],
          );
          return CupertinoAlertDialog(
            content: Center(child: isChild ? child : setText(content!)),
            insetAnimationDuration: const Duration(milliseconds: 500),
            insetAnimationCurve: Curves.linear,
            actions: [
              CupertinoDialogAction(
                  child: setText("選択する", color: CustomColor.redE8),
                  onPressed: () {
                    Routes.finishPage(context: context);
                    confirm();
                  })
            ],
          );
        });
  }

  void showCustomSingleBtnDialog(context,
      {title = "現在ログインしていません", isChild = false, child, confirm}) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showAdaptiveDialog(
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            content: Center(child: isChild ? child : setText(title!)),
            actions: [
              CupertinoDialogAction(
                child: setText("キャンセル", color: CustomColor.grayA),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                  child: setText("ログインする", color: CustomColor.redE8),
                  onPressed: () {
                    Navigator.pop(context); // 先关闭弹窗
                    confirm(); // 再执行跳转
                  })
            ],
          ),
        );
      },
    ).then((_) => _isDialogShowing = false);
  }

  void showCheckNoticeDialog(context,
      {title, msg, isChild = false, child, confirm}) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showAdaptiveDialog(
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: Center(
                child: setText(title!, color: CustomColor.redE8, fontSize: 16)),
            content: Center(child: setText(msg!)),
            actions: [
              CupertinoDialogAction(
                child: setText("閉じる", color: CustomColor.grayA),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                  child: setText("次回から表示しない", color: CustomColor.redE8),
                  onPressed: () {
                    Navigator.pop(context); // 先关闭弹窗
                    confirm(); // 再执行跳转
                  })
            ],
          ),
        );
      },
    ).then((_) => _isDialogShowing = false);
  }

  void showConfirmDialog(
    BuildContext context, {
    bool barrierDismissible = true,
    String title = "提示",
    double titleFontSize = 14.0,
    Color titleColor = CustomColor.black_3,
    FontWeight titleFontWeight = FontWeight.normal,
    Widget? child,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10), // 左右留白 ↓ 宽度 ↑
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0), // 去掉底部多余空白
        actionsPadding: const EdgeInsets.fromLTRB(24, 10, 24, 16), // 按钮贴紧 child
        title: Align(
          alignment: Alignment.center,
          child: setText(title,
              fontSize: titleFontSize,
              color: titleColor,
              fontWeight: titleFontWeight),
        ),
        content: child,
        actions: [
          setOutLinedButton(
            "取消",
            minimumSize: const Size(90, 40),
            circular: 10,
            fontColor: CustomColor.black_3,
            lineColor: CustomColor.blackD,
            fontSize: 15,
            onPressed: () => Get.back(),
          ),
          setCupertinoButton(
            "完成",
            height: 40,
            minimumSize: 90,
            textColor: CustomColor.black_3,
            color: CustomColor.redE8,
            fontSize: 15,
            onPressed: onPressed,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  void showNoticeDialog(context, {title, msg, isChild = false, child}) {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    showAdaptiveDialog(
      context: context,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: Center(
                child: setText(title!, color: CustomColor.redE8, fontSize: 16)),
            content: Center(child: setText(msg!)),
            actions: [
              CupertinoDialogAction(
                child: setText("閉じる", color: CustomColor.grayA),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    ).then((_) => _isDialogShowing = false);
  }

  /// 有圆角的tabBar
  setTabBar(tabs,
      {EdgeInsetsGeometry indicatorPadding =
          const EdgeInsets.only(top: 10, bottom: 10),
      double borderRadius = 15,
      double fontSize = 14,
      unselectedLabelColor = CustomColor.black_3,
      TabController? controller,
      color = CustomColor.redE8,
      onTab}) {
    return SizedBox(
        width: 200,
        child: TabBar(
            controller: controller,
            overlayColor:
                WidgetStateProperty.resolveWith((states) => Colors.transparent),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: CustomColor.white,
            labelStyle:
                setTextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
            unselectedLabelStyle:
                setTextStyle(fontSize: fontSize, fontWeight: FontWeight.normal),
            dividerHeight: 0.0,
            indicatorPadding: indicatorPadding,
            indicator: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            unselectedLabelColor: unselectedLabelColor,
            tabs: tabs,
            onTap: onTab));
  }

  setShoppingCar({count = 0, key}) {
    return Badge(
        key: key,
        label: setText("$count",
            color: CustomColor.white,
            fontSize: 10,
            fontWeight: FontWeight.bold),
        backgroundColor: CustomColor.redE8,
        smallSize: 20,
        largeSize: 20,
        isLabelVisible: count > 0,
        offset: const Offset(8, -8),
        child: const Icon(Icons.shopping_cart, size: 30.0));
  }

  loadImg(src,
      {double width = 80,
      double height = 80,
      margin = EdgeInsets.zero,
      key,
      borderRadius}) {
    return Container(
        key: key,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            image: src,
            width: width,
            height: height,
            placeholder: "assets/icon_no_data.png",
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
            imageErrorBuilder: (_, __, ___) {
              return setAssetsImg("icon_no_data.png",
                  width: width, height: height);
            },
          ),
        ));
  }

  showMyDatePicker(context, {selectDate, required confirm(e)}) {
    Pickers.showDatePicker(
      context,
      mode: DateMode.YMD,
      suffix: Suffix(),
      selectDate: selectDate ?? PDuration.now(),
      pickerStyle: PickerStyle(
          textSize: 16,
          cancelButton: customWidget.setText("キャンセル",
              color: CustomColor.gray_9,
              fontSize: 16,
              margin: const EdgeInsets.only(left: 15),
              fontWeight: FontWeight.bold),
          commitButton: customWidget.setText("確定",
              color: CustomColor.redE8,
              fontSize: 16,
              margin: const EdgeInsets.only(right: 15),
              fontWeight: FontWeight.bold)),
      onConfirm: (value) {
        confirm("${value.year}-"
            "${value.month! < 10 ? "0${value.month}" : value.month}-"
            "${value.day! < 10 ? "0${value.day}" : value.day}");
      },
    );
  }

  /// 展示年月日Picker，确定按钮在底部
  void showMyDatePickerBottomBtn(
    BuildContext context, {
    DateTime? selectDate,
    String? title = "時間",
    required Function(String) confirm,
  }) {
    DateTime now = DateTime.now();
    DateTime _selected = selectDate ?? now;

    final int minYear = 2025;
    final int maxYear = 2025;
    final List<int> years =
        List.generate(maxYear - minYear + 1, (i) => minYear + i);
    final List<int> months = List.generate(12, (i) => i + 1);

    int yearIndex = _selected.year - minYear;
    int monthIndex = _selected.month - 1;
    int dayIndex = _selected.day - 1;
    List<int> days = List.generate(
        _daysInMonth(years[yearIndex], months[monthIndex]), (i) => i + 1);

    void _updateDays() {
      days = List.generate(
          _daysInMonth(years[yearIndex], months[monthIndex]), (i) => i + 1);
      if (dayIndex >= days.length) dayIndex = days.length - 1;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (_, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  setText(title!,fontSize: 18,color: CustomColor.black_3),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.clear,color: CustomColor.grayC7,size: 20,),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 216,
              child: Row(
                children: [
                  _buildWheel(years, yearIndex, (i) {
                    setState(() => yearIndex = i);
                    _updateDays();
                  }),
                  _buildWheel(months, monthIndex, (i) {
                    setState(() => monthIndex = i);
                    _updateDays();
                  }, formatter: (v) => v.toString().padLeft(2, '0')),
                  _buildWheel(days, dayIndex, (i) {
                    setState(() => dayIndex = i); // 这里也要 setState
                  }, formatter: (v) => v.toString().padLeft(2, '0')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final y = years[yearIndex];
                    final m = months[monthIndex].toString().padLeft(2, '0');
                    final d = days[dayIndex].toString().padLeft(2, '0');
                    confirm('$y-$m-$d');
                    Navigator.pop(context);
                  },
                  child:
                      const Text('確定', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 通用滚轮封装
  Widget _buildWheel(
    List<int> items,
    int selectedIndex, // 新增
    ValueChanged<int> onChanged, {
    String Function(int)? formatter,
  }) {
    final fixedFormatter = formatter ?? (v) => v.toString();
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 32,
            controller: FixedExtentScrollController(initialItem: selectedIndex),
            onSelectedItemChanged: onChanged,
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.005,
            diameterRatio: 1.1,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (_, index) => Center(
                child: Text(
                  fixedFormatter(items[index]),
                  // 2. 根据是否选中切换颜色
                  style: TextStyle(
                    fontSize: 18,
                    color: index == selectedIndex
                        ? Colors.redAccent
                        : CustomColor.black_9,
                  ),
                ),
              ),
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;
}
