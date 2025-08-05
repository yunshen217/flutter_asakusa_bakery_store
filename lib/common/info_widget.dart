import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/japanese_text_delegate.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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


  Widget pickerSelected(String text,bool isHitText, Function fun,
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
            customWidget.setText(text,color:isHitText?CustomColor.black_9:CustomColor.black_3),
            customWidget.setAssetsImg("cus_textfield_select@3x.png",
                width: 24, height: 24)
          ],
        ));
  }

 
  Widget selectImage(
      RxList<AssetEntity> image, BuildContext context, int imageLength) {
    return Obx(() => Container(
          // ← 只包一层 Obx
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(image.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(left:index != 0? ((Get.width - 315 - 30)/2):0),
                    child: Stack(
                      children: [
                        Container(
                          width: 105,
                          height: 105,
                          padding: const EdgeInsets.only(top: 7, right: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AssetEntityImage(
                              image[index],
                              width: 98,
                              height: 98,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              image.removeAt(index); // ← 直接删，外层 Obx 会刷新
                            },
                            child: customWidget.setAssetsImg("icon_clear.png",
                                width: 20, height: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              if (image.length < imageLength)
                GestureDetector(
                    onTap: () async {
                      await customWidget.pickImageWithPermission(context,
                          () async {
                        final List<AssetEntity>? result =
                            await AssetPicker.pickAssets(
                          context,
                          pickerConfig: AssetPickerConfig(
                            maxAssets: 1,
                            requestType: RequestType.image,
                            textDelegate: JapaneseTextDelegate(),
                          ),
                        );
                        if (result != null) {
                          if (image.isEmpty) {
                            image.assignAll(result);
                          } else {
                            if (image.length >= imageLength) return;
                            image.addAll(result.take(imageLength - image.length));
                          }
                        }
                      });
                    },
                    child: Container(
                      width: 98,
                      height: 98,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 7, right: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(width: 0.5, color: CustomColor.blackD)),
                      child: customWidget.setAssetsImg("icon_add.png",
                          width: 32, height: 32),
                    ),
                  )
            ],
          ),
        ));
  }


  Widget bottomBtn(String leftTitle,String rightTitle,bool isShowLeft,Function leftOnTap,Function rightOnTap){
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
                    !isShowLeft?Container():customWidget.setCupertinoButton(leftTitle,
                        minimumSize: (Get.width - 50) / 2,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.black_9,
                        onPressed: leftOnTap),
                    customWidget.setCupertinoButton(rightTitle,
                        minimumSize: (Get.width - 50) / 2,
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
