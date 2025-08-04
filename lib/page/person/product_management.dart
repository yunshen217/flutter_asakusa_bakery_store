import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 商品管理
class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  /// tab
  List tabs = ["贩壳中", "开発中", "服壳中止"];
  RxInt tabIndex = 0.obs;

  /// 商品リストデータ
  List productData = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

  /// フィルタリング
  RxBool sift = false.obs;

  /// フィルターボタン
  RxList siftBtnData = [
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

  /// ボタンがクリックされたかどうか
  RxList<RxBool> siftBtnDataIsSelectes = [false.obs].obs;
  @override
  void initState() {
    super.initState();
    siftBtnDataIsSelectes
        .assignAll(List.generate(siftBtnData.length, (_) => false.obs));
  }

  Widget tabWidget() {
    return customWidget.setContain(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(tabs.length, (i) {
                return Obx(() => customWidget.setUnderLineButton(tabs[i],
                        margin: const EdgeInsets.only(right: 30),
                        fontColor: tabIndex.value == i
                            ? CustomColor.black_3
                            : CustomColor.black_9,
                        fontSize: 14,
                        lineHeight: 2,
                        lineWidth: 20,
                        lineColor: tabIndex.value == i
                            ? CustomColor.redE8
                            : Colors.transparent,
                        lineTopMargin: 2, onTap: () {
                      tabIndex.value = i;
                    }));
              }),
            ),
            GestureDetector(
              onTap: () {sift.value = true;},
              child: customWidget.setAssetsImg("switch_btn@3x.png",
                  width: 20, height: 20),
            )
          ],
        ),
        margin: const EdgeInsets.all(0),
        border: const Border(top: BorderSide(width: 1, color: CustomColor.bg)),
        circular: 0);
  }


  Widget productCard(String img) {
    String imgPath = "person_product_make@3x.png";
    switch (tabIndex.value) {
      case 0:
        imgPath = "person_product_make@3x.png";
        break;
      case 1:
        imgPath = "person_product_develop@3x.png";
        break;
      case 2:
        imgPath = "person_product_stop@3x.png";
        break;
    }
    return GestureDetector(
      onTap: () => Routes.goPage(context,"ProductDetail",param: {"isHavePurge":true}),
      child: Stack(
        children: [
          customWidget.setCard(
              padding: const EdgeInsets.all(15),
              height: 90,
              radius: 10,
              isShowBoxShadow: false,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: customWidget.setNetworkImg(img, width: 60, height: 60),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center, // ✅ 垂直居中
                      children: [
                        customWidget.setTextOverflow("test",
                            fontSize: 13,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(right: 6)),
                        customWidget.setRichText("累計贩壳：", "70",
                            fontSize: 12,
                            color: CustomColor.black_9,
                            subtitleColor: CustomColor.black_3)
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
              top: 0,
              right: 15,
              child: customWidget.setAssetsImg(imgPath, width: 60, height: 60))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double textHeight =
        utils.getTextHeight(text: "贩壳中", style: const TextStyle(fontSize: 14));
    double allHeight = textHeight + 2 + 30;
    return BaseScaffold(
      backgroundColor: CustomColor.bg,
      appBar: customWidget.setAppBar(
          title: "商品管理",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          )),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                // tab
                tabWidget(),
                Expanded(
                    child: ListView.builder(
                        itemCount: productData.length,
                        padding: const EdgeInsets.only(bottom: 80),
                        itemBuilder: (context, index) {
                          return Obx(() => productCard(
                              "https://img95.699pic.com/photo/60078/6443.jpg_wh860.jpg"));
                        }))
              ],
            ),
          ),
          Positioned(
              top: allHeight,
              child:Obx(()=>!sift.value?Container(): Container(
                width: Get.width,
                height: Get.height - allHeight - 69,
                alignment: Alignment.topCenter,
                decoration:
                    BoxDecoration(color: CustomColor.black_3.withOpacity(0.4)),
                child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(15),
                    color: CustomColor.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customWidget.setTextOverflow("パンの種類",
                            fontWeight: FontWeight.bold,
                            margin: const EdgeInsets.only(top: 10, bottom: 10)),
                        Obx(() => Wrap(
                              spacing: 12, // 水平间距
                              runSpacing: 10, // 垂直间距（换行后的行间距）
                              children:
                                  List.generate(siftBtnData.length, (index) {
                                final label = siftBtnData[index];
                                return GestureDetector(
                                  onTap: () {
                                    siftBtnDataIsSelectes[index].value =
                                        !siftBtnDataIsSelectes[index].value;
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 3, 10, 5),
                                    decoration: BoxDecoration(
                                        color:
                                            siftBtnDataIsSelectes[index].value
                                                ? CustomColor.redE84F43
                                                : CustomColor.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: CustomColor.redE84F43)),
                                    child: customWidget.setText(label,
                                        fontSize: 12,
                                        color:
                                            siftBtnDataIsSelectes[index].value
                                                ? CustomColor.white
                                                : CustomColor.redE84F43),
                                  ),
                                );
                              }),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customWidget.setCupertinoButton("クリア",
                                minimumSize: (Get.width - 45) / 2,
                                height: 36,
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                textColor: CustomColor.black_3,
                                color: CustomColor.blackD,
                                onPressed: () {
                                  sift.value = false;
                                }),
                            customWidget.setCupertinoButton("検索",
                                minimumSize: (Get.width - 45) / 2,
                                height: 36,
                                fontWeight: FontWeight.normal,
                                color: CustomColor.redE84F43,
                                fontSize: 13,
                                onPressed: () {
                                  sift.value = false;
                                }),
                          ],
                        )
                      ],
                    )),
              ))),
          Positioned(
              bottom: 0,
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
                  decoration: const BoxDecoration(
                    color: CustomColor.white,
                  ),
                  child: customWidget.setOutLinedButton("追加",
                  onPressed: ()=>Routes.goPage(context,"ProductDetail",param: {"isHavePurge":false}),
                      circular: 5,
                      linewidth: 0.5,
                      minimumSize: Size(Get.width - 15, 34),
                      isHaveLeftIcon: true,
                      imgPath: "组 239@3x.png",
                      lineColor: CustomColor.blackD,
                      fontColor: Colors.black)))
        ],
      ),
    );
  }
}
