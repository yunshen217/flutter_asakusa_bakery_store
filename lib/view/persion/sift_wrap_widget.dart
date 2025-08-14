import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/common_search_param_model.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SiftWrapWidget extends StatelessWidget {
  RxList<RxBool> siftBtnDataIsSelectes;
  RxList<CommonSearchParamModelItemKindList?> siftBtnData;
  RxList kindId;
  RxBool sift;
  String title;
  Widget child;
  String cancelText;
  Function()? subOnTap;
  Function()? cancelOnTap;
  SiftWrapWidget(
      {super.key,
      required this.siftBtnDataIsSelectes,
      required this.siftBtnData,
      required this.sift,
      this.title = "パンの種類",
      this.child = const SizedBox.shrink(),
      this.cancelText = "クリア",
      this.subOnTap,
      this.cancelOnTap,
      required this.kindId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: CustomColor.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customWidget.setTextOverflow(title,
                fontWeight: FontWeight.bold,
                margin: const EdgeInsets.only(top: 10, bottom: 10)),
            Wrap(
                  spacing: 12, 
                  runSpacing: 10, 
                  children: List.generate(siftBtnData.length, (index) {
                    final label = siftBtnData[index];
                    return Obx(()=>GestureDetector(
                      onTap: () {
                        siftBtnDataIsSelectes[index].value = !siftBtnDataIsSelectes[index].value;
                        siftBtnDataIsSelectes[index].value?kindId.add(label.id):kindId.remove(label.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 5),
                        decoration: BoxDecoration(
                            color: siftBtnDataIsSelectes[index].value
                                ? CustomColor.redE84F43
                                : CustomColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: CustomColor.redE84F43)),
                        child: customWidget.setText(label!.kindName!,
                            fontSize: 12,
                            color: siftBtnDataIsSelectes[index].value
                                ? CustomColor.white
                                : CustomColor.redE84F43),
                      ),
                    ));
                  }),
                ),
            const SizedBox(
              height: 15,
            ),
            child,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customWidget.setCupertinoButton(cancelText,
                    minimumSize: (Get.width - 45) / 2,
                    height: 40,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    textColor: CustomColor.black_3,
                    color: CustomColor.blackD, onPressed: () =>cancelOnTap!()),
                customWidget.setCupertinoButton("検索",
                    minimumSize: (Get.width - 45) / 2,
                    height: 40,
                    fontWeight: FontWeight.normal,
                    color: CustomColor.redE84F43,
                    fontSize: 13, onPressed: () =>subOnTap!()),
              ],
            )
          ],
        ));
  }
}
