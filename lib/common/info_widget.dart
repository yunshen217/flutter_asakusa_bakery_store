import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/japanese_text_delegate.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
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

  Widget selectImage({
  required RxList<AssetEntity> localAssets,
  required RxList<String> netUrls,
  required RxList<String> fileIds,
  required int maxLength,
  required BuildContext context,
}) {
  /* ===== Internal status ===== */
  final RxList<dynamic> images = <dynamic>[].obs; // String(url) / AssetEntity
  final RxList<String> ids   = <String>[].obs;   // Corresponding to images

  /* ===== Synchronize external data ===== */
  void syncLists() {
    images.clear();
    ids.clear();
    for (int i = 0; i < netUrls.length; i++) {
      images.add(netUrls[i]);
      ids.add(fileIds[i]);
    }
    images.addAll(localAssets);
    ids.addAll(List.filled(localAssets.length, ''));
  }

  /* ===== Sync for the first time to listen for external changes ===== */
  syncLists();
  everAll([netUrls, localAssets, fileIds], (_) => syncLists());

  /* ===== upload ===== */
  Future<void> upload(List<AssetEntity> assets) async {
    final paths = <String>[];
    for (final a in assets) {
      final f = await a.file;
      if (f != null) paths.add(f.path);
    }
    if (paths.isEmpty) return;

    await backEndRepository.upFile(
      '${Constant.base_url}common/upload/img',
      paths,
      (res) {
        print("成功啦哈哈哈哈 ---------------- ");
        final id = res is Map ? res["data"] : "";
        if (id is String) {
          // netUrls.add(id);
          fileIds.add(id);
          print("fileIds ------------------ $fileIds");
        }
      },
    );
  }

  Future<void> pick() async {
    final left = maxLength - images.length;
    if (left <= 0) return;

    final result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: left,
        requestType: RequestType.image,
        textDelegate: JapaneseTextDelegate(),
      ),
    );
    if (result != null) {
      localAssets.addAll(result);
      await upload(result);
    }
  }

  /* ===== UI ===== */
  return Obx(() {
    final count = images.length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
        spacing: 10,   
        runSpacing: 8, 
        children: [
          ...List.generate(count, (i) {
            final item = images[i];
            return SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  item is String
                      ? Container(padding: const EdgeInsets.only(top: 10,right: 10),child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(item, fit: BoxFit.cover)))
                      : Container(padding: const EdgeInsets.only(top: 10,right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AssetEntityImage(item as AssetEntity,
                              fit: BoxFit.cover),
                        ),
                      ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (item is String) {
                          final idx = netUrls.indexOf(item);
                          netUrls.removeAt(idx);
                          fileIds.removeAt(idx);
                        } else {
                          localAssets.remove(item);
                        }
                      },
                      child: Image.asset('assets/icon_clear.png',
                          width: 20),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (count < maxLength)
            SizedBox(
              width: 120,
              height: 120,
              child: GestureDetector(
                onTap: pick,
                child: Container(
                  margin: const EdgeInsets.only(top: 10,right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset('assets/icon_add.png', width: 32),
                ),
              ),
            ),
        ],
      ),
    );
  });
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
