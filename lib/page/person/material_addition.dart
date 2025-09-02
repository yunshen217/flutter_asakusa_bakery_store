import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/ingredients_stocks_model.dart';
import 'package:flutter_asakusa_bakery_store/page/person/mixin/material_addition_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';

/// 材料の追加
class MaterialAddition extends StatefulWidget {
  const MaterialAddition({super.key});

  @override
  State<MaterialAddition> createState() => _MaterialAdditionState();
}

class _MaterialAdditionState extends State<MaterialAddition> with MaterialAdditionMixin{
  
  @override
  void initState() {
    super.initState();
    isHaveDeletedBtn.value = arguments["isHaveDeletedBtn"];
    var idArg = arguments["id"];
    if (idArg is String) {
      id.value = idArg;
    } else {
      id.value = "";
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUnitsMin();
      if(isHaveDeletedBtn.value){
        await getDisplayUnits();
      }
      var ingredientsStocksModelArg = arguments["IngredientsStocksModel"];
      if (ingredientsStocksModelArg is IngredientsStocksModel) {
        ingredientsStocksModel.value = ingredientsStocksModelArg;
        setIngredientsStocksData();
      } else {
        ingredientsStocksModel.value = IngredientsStocksModel.fromJson({});
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    inboundQuantityThresholdController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title:isHaveDeletedBtn.value?"材料変更": "材料追加",
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
                hintText: '数値を入力してください',
                readOnly: false),
            infoWidget.titleWidget("アレルゲン区分", false),
            Obx(() => infoWidget.pickerSelected(allergenCategory.value,
                    allergenCategory.value == "数値を入力してください", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      allergenCategoryList.map((e) => e.toString()).toList()
                    ],
                    initialIndex: [0],
                    title: 'アレルゲン区分',
                    confirm: (list) => allergenCategory.value = list[0],
                  );
                })),
            infoWidget.titleWidget("最小単位", false),
            Obx(() => infoWidget.pickerSelected(
                    minimumUnit.value, minimumUnit.value == "数値を入力してください", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      minimumUnitList.map((e) => e.toString()).toList()
                    ],
                    initialIndex: [0],
                    title: '最小単位',
                    confirm: (list) {
                      minimumUnit.value = list[0];
                      for (var element in unitsMinList) {
                        if(minimumUnit.value == element.unit){
                          id.value = element.id!;
                        }
                      }
                      getDisplayUnits();
                    },
                  );
                })),
            infoWidget.titleWidget("表示単位", false),
            Obx(() => infoWidget.pickerSelected(
                    displayUnit.value, displayUnit.value == "数値を入力してください", () {
                      if(minimumUnit.value == "数値を入力してください"){
                        customWidget.toastShowNotIcon("最小単位を先に入力してください");
                        return;
                      }
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      displayUnitList.map((e) => e.toString()).toList()
                    ],
                    initialIndex: [0],
                    title: '表示単位',
                    confirm: (list) => displayUnit.value = list[0],
                  );
                })),
            infoWidget.titleWidget("入荷閾値", false),
            ClearableTextField(
                controller: inboundQuantityThresholdController,
                isNum: true,
                hintText: '数値を入力してください',
                readOnly: false),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    isHaveDeletedBtn.value
                        ? customWidget.setCupertinoButton("削除",
                            height: 30,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            circular: 5,
                            textColor: CustomColor.black_3,
                            color: CustomColor.blackD,
                            margin: const EdgeInsets.only(top: 10, right: 15),
                            onPressed: () => deleteProductIngredient())
                        : Container(),
                    customWidget.setCupertinoButton("保存",
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.redE8,
                        margin: const EdgeInsets.only(top: 10, right: 15),
                        onPressed: () {
                      updateProductIngredient();
                    }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
