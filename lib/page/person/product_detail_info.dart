import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

/// 商品详情 - 商品信息
class ProductDetailInfo extends StatefulWidget {
  const ProductDetailInfo({super.key});

  @override
  State<ProductDetailInfo> createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo> {
  List topTitle = ["商品番号", "商品名", "商品名略称"];

  late final RxList<TextEditingController> topTitleController;

  List bottomTitle = [
    "望価(税込)",
    "重量(g)",
    "カロリ一",
    "幅(mm)",
    "奥行き(mm)",
    "高さ(mm)",
    "デフオルト計画数"
  ];

  late final RxList<TextEditingController> bottomTitleController;

  RxList<AssetEntity> image = <AssetEntity>[].obs;

  RxString productCategorySelected = "商品カテゴリ".obs;
  RxList productCategory = [
    "八ン",
    "食バン",
    "アイスバン",
    "プレッツエル",
    "ベ-グル",
    "ク一キ",
    "クッキ-",
    "スコ-ン",
    "スウ(酥)",
    "月餅",
    "その他",
    "新商品",
    "季限定"
  ].obs;

  RxString freshlyBakedTimeZoneSelected = "商品焼きたて時間带を選択してください".obs;
  RxList freshlyBakedTimeZone = ["12:00~13:00", "13:00~14:00"].obs;

  RxString statusSelected = "ステ一タス".obs;
  RxList status = ["贩壳中", "开発中", "服壳中止"].obs;

  TextEditingController productDescriptionController = TextEditingController();
  FocusNode productDescriptionFocusNode = FocusNode();

  TextEditingController rawMaterialsController = TextEditingController();
  FocusNode rawMaterialsFocusNode = FocusNode();

  List allergyInfo = [
    {
      "name": "小麦",
      "selected": "icon_yellow8.png",
      "notSelected": "icon_black8.png"
    },
    {
      "name": "卵",
      "selected": "icon_yellow6.png",
      "notSelected": "icon_black6.png"
    },
    {
      "name": "乳",
      "selected": "icon_yellow7.png",
      "notSelected": "icon_black7.png"
    },
    {
      "name": "工ビ匹",
      "selected": "icon_yellow1.png",
      "notSelected": "icon_black1.png"
    },
    {
      "name": "カニ匹",
      "selected": "icon_yellow2.png",
      "notSelected": "icon_black2.png"
    },
    {
      "name": "そば",
      "selected": "icon_yellow5.png",
      "notSelected": "icon_black5.png"
    },
    {
      "name": "落花生",
      "selected": "icon_yellow4.png",
      "notSelected": "icon_black4.png"
    },
    {
      "name": "くるみ",
      "selected": "icon_yellow3.png",
      "notSelected": "icon_black3.png"
    }
  ];

  RxList<RxBool> allergyInfoIsSelected = [false.obs].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topTitleController =
        List.generate(topTitle.length, (_) => TextEditingController()).obs;
    bottomTitleController =
        List.generate(bottomTitle.length, (_) => TextEditingController()).obs;
    allergyInfoIsSelected
        .assignAll(List.generate(allergyInfo.length, (_) => false.obs));
  }

  @override
  void dispose() {
    topTitleController.forEach((c) => c.dispose);
    bottomTitleController.forEach((c) => c.dispose);
    productDescriptionController.dispose();
    rawMaterialsController.dispose();
    productDescriptionFocusNode.dispose();
    rawMaterialsFocusNode.dispose();
    super.dispose();
  }

  Widget textEditingList(List name, RxList<TextEditingController> controller) {
    return Column(
      children: List.generate(name.length, (index) {
        return Column(
          children: [
            infoWidget.titleWidget(name[index], false),
            ClearableTextField(
                controller: controller[index],
                hintText: name[index],
                readOnly: false),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            textEditingList(topTitle, topTitleController),
            infoWidget.titleWidget("商品画像(2枚)", false),
            infoWidget.selectImage(image, context, 2),
            infoWidget.titleWidget("商品カテゴリ", false),
            Obx(() => infoWidget.pickerSelected(productCategorySelected.value,
                    productCategorySelected.value == "商品カテゴリ", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      productCategory.map((e) => e.toString()).toList()
                    ],
                    initialIndex: [0],
                    title: '商品カテゴリを選択してください',
                    confirm: (list) => productCategorySelected.value = list[0],
                  );
                })),
            infoWidget.titleWidget("商品焼きたて時間带", false),
            Obx(() => infoWidget.pickerSelected(
                    freshlyBakedTimeZoneSelected.value,
                    freshlyBakedTimeZoneSelected.value == '商品焼きたて時間带を選択してください',
                    () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      freshlyBakedTimeZone.map((e) => e.toString()).toList()
                    ],
                    initialIndex: [0],
                    title: '商品焼きたて時間带を選択してください',
                    confirm: (list) =>
                        freshlyBakedTimeZoneSelected.value = list[0],
                  );
                })),
            infoWidget.titleWidget("商品説明", false),
            customWidget.setTextField(
                productDescriptionController, productDescriptionFocusNode,
                hintText: '',
                circular: 5,
                maxLines: 100,
                height: 100,
                maxLength: 255,
                top: 10,
                left: 10,
                right: 10,
                borderSide:
                    const BorderSide(color: CustomColor.blackD, width: 0.5),
                margin: const EdgeInsets.symmetric(horizontal: 15)),
            infoWidget.titleWidget("原材料名", false),
            customWidget.setTextField(
                rawMaterialsController, rawMaterialsFocusNode,
                hintText: '',
                circular: 5,
                maxLines: 100,
                height: 100,
                maxLength: 255,
                top: 10,
                left: 10,
                right: 10,
                borderSide:
                    const BorderSide(color: CustomColor.blackD, width: 0.5),
                margin: const EdgeInsets.symmetric(horizontal: 15)),
            infoWidget.titleWidget("アレルギ一情報(特定8品目)", false),
            Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 170,
                  child: SingleChildScrollView(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.7,
                      children: List.generate(allergyInfo.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            allergyInfoIsSelected[index].value =
                                !allergyInfoIsSelected[index].value;
                          },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 80),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                customWidget.setAssetsImg(
                                    allergyInfoIsSelected[index].value
                                        ? allergyInfo[index]["selected"]
                                        : allergyInfo[index]["notSelected"],
                                    width: 59,
                                    height: 59),
                                customWidget.setTextOverflow(
                                    margin: const EdgeInsets.only(
                                      top: 1,
                                    ),
                                    allergyInfo[index]["name"],
                                    color: CustomColor.black_3,
                                    fontSize: 12)
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )),
            infoWidget.titleWidget("ステ一タス", false),
            Obx(() => infoWidget.pickerSelected(
                    statusSelected.value, statusSelected.value == "ステ一タス", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [status.map((e) => e.toString()).toList()],
                    initialIndex: [0],
                    title: '商品ステ-タスを選択してください',
                    confirm: (list) => statusSelected.value = list[0],
                  );
                })),
            textEditingList(bottomTitle, bottomTitleController),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
