import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/image_selector.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/product_detail_model.dart';
import 'package:flutter_asakusa_bakery_store/page/person/mixin/product_detail_info_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';

/// 商品詳細
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin, ProductDetailInfoMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = arguments["id"];
    _tabController = TabController(length: 2, vsync: this);
    topTitleController =
        List.generate(topTitle.length, (_) => TextEditingController()).obs;
    bottomTitleController =
        List.generate(bottomTitle.length, (_) => TextEditingController()).obs;
    allergyInfoIsSelected
        .assignAll(List.generate(allergyInfo.length, (_) => false.obs));
    getCommonSearchParam() ;
    gettimePeriods();
    getProductIngredientList();
    if (id != "") {
      getProductDetail();
    }
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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: CustomColor.white,
        appBar: customWidget.setAppBar(
          title: "商品詳細",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                const Divider(height: 1, color: CustomColor.bg),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '商品情報'),
                    Tab(text: 'レシピ'),
                  ],
                  dividerHeight: 1,
                  dividerColor: CustomColor.bg,
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: Colors.transparent,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        const BorderSide(color: CustomColor.redE8, width: 2),
                    insets: EdgeInsets.symmetric(
                      horizontal: (Get.width - (Get.width - 30) / 2) / 2,
                    ),
                  ),
                  labelColor: CustomColor.black_3,
                  unselectedLabelColor: CustomColor.black_9,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 詳細
                  productDetailInfo(),
                  // レシピ
                  productDetailRecipe(),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                  decoration:
                      BoxDecoration(color: CustomColor.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ]),
                  child: customWidget.setCupertinoButton("保存",
                      width: Get.width - 30,
                      height: 30,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      circular: 5,
                      textColor: CustomColor.black_3,
                      color: CustomColor.redE8, onPressed: () {
                        if(bottomTitleController[0].text.trim() == ""){
                          customWidget.toastShowNotIcon("単価(税込)を入力してください");
                          return;
                        }
                        if(bottomTitleController[3].text.trim() == ""){
                          customWidget.toastShowNotIcon("幅を入力してください");
                          return;
                        }
                        if(bottomTitleController[4].text.trim() == ""){
                          customWidget.toastShowNotIcon("奥行きを入力してください");
                          return;
                        }
                        if(bottomTitleController[5].text.trim() == ""){
                          customWidget.toastShowNotIcon("高さを入力してください");
                          return;
                        }
                        if(bottomTitleController[6].text.trim() == ""){
                          customWidget.toastShowNotIcon("デフォルト計画数を入力してください");
                          return;
                        }
                    updateProduct();
                  }),
                ))
          ],
        ));
  }

  Widget textEditingList(List name, RxList<TextEditingController> controller,bool isNum) {
    return Column(
      children: List.generate(name.length, (index) {
        return Column(
          children: [
            infoWidget.titleWidget(name[index], false),
            ClearableTextField(
                controller: controller[index],
                hintText: name[index],
                isNum: isNum,
                readOnly: false),
          ],
        );
      }),
    );
  }

  Widget productDetailInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textEditingList(topTitle, topTitleController,false),
          infoWidget.titleWidget("商品画像(2枚)", false),
          SelectImageWidget(
              localAssets: image,
              maxLength: 3,
              fileIds: fileIdList,
              netUrls: assetsImg),
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
          infoWidget.titleWidget("商品焼きたて時間帯", false),
          Obx(() => infoWidget.pickerSelected(
                  freshlyBakedTimeZoneSelected.value,
                  freshlyBakedTimeZoneSelected.value == '時間帯を選択してください',
                  () {
                customWidget.showCustomizationPicker(
                  context,
                  columnsData: [
                    freshlyBakedTimeZone.map((e) => e.toString()).toList()
                  ],
                  initialIndex: [0],
                  title: '時間帯を選択してください',
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
          infoWidget.titleWidget("アレルギー情報(特定8品目)", false),
          Obx(() => Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 217,
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
          infoWidget.titleWidget("ステータス", false),
          Obx(() => infoWidget.pickerSelected(
                  statusSelected.value, statusSelected.value == "ステータス", () {
                customWidget.showCustomizationPicker(
                  context,
                  columnsData: [status.map((e) => e.toString()).toList()],
                  initialIndex: [0],
                  title: '商品ステータスを選択してください',
                  confirm: (list) => statusSelected.value = list[0],
                );
              })),
          textEditingList(bottomTitle, bottomTitleController,true),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

  Widget productDetailRecipe() {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          for (var data in focusNodeList) {
            data.unfocus();
          }
        },
        child: Column(
          children: [
            Obx(() => psIngredientsList.isEmpty
                ? Container()
                : Column(
                    children: List.generate(psIngredientsList.length, (index) {
                      if (index < controllerList.length) {
                        final item = psIngredientsList[index]!;
                        controllerList[index].text = item.count.toString();
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                infoWidget.titleWidget(
                                    item.ingredientName!, false),
                                GestureDetector(
                                  onTap: () {
                                    currentlyselectTheMaterial.removeAt(index);
                                    controllerList.removeAt(index);
                                    focusNodeList.removeAt(index);
                                    psIngredientsList.removeAt(index);
                                  },
                                  child: customWidget.setAssetsImg(
                                      "icon_clear.png",
                                      width: 16,
                                      height: 16,
                                      margin: const EdgeInsets.only(right: 15)),
                                )
                              ],
                            ),
                            customWidget.setTextField(
                              controllerList[index],
                              focusNodeList[index],
                              borderSide: const BorderSide(
                                color: CustomColor.blackD,
                                width: 0.5,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              isShow: true,
                              suffixIcon: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 15, 0, 15),
                                child: customWidget.setText(item.unit!,
                                    color: CustomColor.black_3,
                                    fontSize: 12,
                                    textAlign: TextAlign.center),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  )),
            customWidget.setOutLinedButton("材料の追加",
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 70),
                onPressed: () => customWidget.showCustomizationPicker(context,
                        columnsData: [
                          selectTheMaterial.map((e) => e.toString()).toList()
                        ],
                        initialIndex: [0],
                        title: '材料を選択してください', confirm: (list) {
                      String id = "";
                      String minUnitId = "";
                      String unit = "";
                      for (var data in productIngredientListModel) {
                        if (data.ingredientName == list[0]) {
                          id = data.id!;
                          minUnitId = data.minUnitId!;
                          unit = data.unit!;
                        }
                      }
                      currentlyselectTheMaterial
                          .add({"id": id, "count": "", "minUnitId": minUnitId});
                      psIngredientsList.add(
                          ProductDetailModelPsIngredientsList.fromJson({
                        "id": id,
                        "ingredientName": list[0],
                        "count": "",
                        "unit": unit
                      }));
                      controllerList.add(TextEditingController());
                      focusNodeList.add(FocusNode());
                    }),
                circular: 5,
                linewidth: 0.5,
                minimumSize: Size(Get.width - 15, 34),
                isHaveLeftIcon: true,
                imgPath: "组 239@3x.png",
                lineColor: CustomColor.blackD,
                fontColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
