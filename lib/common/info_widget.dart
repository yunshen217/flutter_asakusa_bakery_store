import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:get/get.dart';

/// 詳細コンポーネント（例えば、店舗設定や商品詳細ページで使用される入力ボックス、ドロップダウン選択、画像選択）
final infoWidget = InfoWidget();

class InfoWidget {
  /// タイトル文字（必須かどうか：必須ですか）
  Widget titleWidget(String text, bool isRequired) {
    return Row(
      children: [
        customWidget.setTextOverflow(text,
            margin: EdgeInsets.fromLTRB(15, 15, isRequired ? 10 : 15, 10),
            fontSize: 13,
            color: CustomColor.black_3),
        isRequired
            ? Container(
                width: 30,
                height: 16,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 2),
                margin: const EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColor.redE84F43),
                child: customWidget.setTextOverflow("必須",
                    fontSize: 10, color: CustomColor.white),
              )
            : Container()
      ],
    );
  }

  Widget pickerSelected(String text, bool isHitText, Function fun,
      {double width = double.infinity}) {
    return customWidget.setCardForHeight(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 41,
        radius: 5,
        borderWidth: 0.5,
        width: width,
        onTap: fun,
        color: CustomColor.bg,
        borderColor: CustomColor.blackD,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customWidget.setText(text,
                color: isHitText ? CustomColor.black_9 : CustomColor.black_3),
            customWidget.setAssetsImg("cus_textfield_select@3x.png",
                width: 24, height: 24)
          ],
        ));
  }
  Widget bottomBtn(String leftTitle, String rightTitle, bool isShowLeft,
      Function leftOnTap, Function rightOnTap) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
          decoration: BoxDecoration(color: CustomColor.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              !isShowLeft
                  ? Container()
                  : customWidget.setCupertinoButton(leftTitle,
                      width: (Get.width - 50) / 2,
                      height: 30,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      circular: 5,
                      textColor: CustomColor.black_3,
                      color: CustomColor.black_9,
                      onPressed: leftOnTap),
              customWidget.setCupertinoButton(rightTitle,
                  width: (Get.width - 50) / 2,
                  height: 30,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  circular: 5,
                  textColor: CustomColor.black_3,
                  color: CustomColor.redE8,
                  onPressed: rightOnTap)
            ],
          ),
        ));
  }
}
