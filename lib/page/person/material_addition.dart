import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';

/// 材料の追加
class MaterialAddition extends StatefulWidget {
  const MaterialAddition({super.key});

  @override
  State<MaterialAddition> createState() => _MaterialAdditionState();
}

class _MaterialAdditionState extends State<MaterialAddition> {
  // 材料名
  TextEditingController nameController = TextEditingController();
  // 入荷閩值
  TextEditingController inboundQuantityThresholdController =
      TextEditingController();
  // アレルゲン区分
  RxString allergenCategory = "数値を入カしてください".obs;
  RxList allergenCategoryList = ["是", "否"].obs;
  /// 最小单位
  RxString minimumUnit = "数値を入カしてください".obs;
  RxList minimumUnitList = ["是", "否"].obs;
  /// 表示单位
  RxString displayUnit = "数値を入カしてください".obs;
  RxList displayUnitList = ["是", "否"].obs;
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "材料追加",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoWidget.titleWidget("材料名", false),
            ClearableTextField(
                controller: nameController,
                hintText: '数値を入カしてください',
                readOnly: false),
            infoWidget.titleWidget("アレルゲン区分", false),
            Obx(()=>infoWidget.pickerSelected(
                allergenCategory.value, allergenCategory.value == "数値を入カしてください",
                () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [
                  allergenCategoryList.map((e) => e.toString()).toList()
                ],
                initialIndex: [0],
                title: '商品カテゴリを選択してください',
                confirm: (list) => allergenCategory.value = list[0],
              );
            })),
            infoWidget.titleWidget("最小单位", false),
            Obx(()=>infoWidget.pickerSelected(
                minimumUnit.value, minimumUnit.value == "数値を入カしてください",
                () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [
                  minimumUnitList.map((e) => e.toString()).toList()
                ],
                initialIndex: [0],
                title: '商品カテゴリを選択してください',
                confirm: (list) => minimumUnit.value = list[0],
              );
            })),
            infoWidget.titleWidget("表示单位", false),
            Obx(()=>infoWidget.pickerSelected(
                displayUnit.value, displayUnit.value == "数値を入カしてください",
                () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [
                  displayUnitList.map((e) => e.toString()).toList()
                ],
                initialIndex: [0],
                title: '商品カテゴリを選択してください',
                confirm: (list) => displayUnit.value = list[0],
              );
            })),
            infoWidget.titleWidget("入荷閩值", false),
            ClearableTextField(
                controller: inboundQuantityThresholdController,
                hintText: '数値を入カしてください',
                readOnly: false),
            Align(
              alignment: Alignment.centerRight,
              child: customWidget.setCupertinoButton("保存",
                        minimumSize: (Get.width - 30) / 3,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.redE8,
                        margin: EdgeInsets.only(top: 10,right: 15),
                        onPressed: (){}),
            )
          ],
        ),
      ),
    );
  }
}
