import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/slide_up_panel.dart';
import 'package:flutter_asakusa_bakery_store/model/items_list_model.dart';
import 'package:flutter_asakusa_bakery_store/page/person/mixin/product_management_mixin.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/sift_wrap_widget.dart';
import 'package:get/get.dart';

/// 商品管理
class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> with ProductManagementMixin{
  
  @override
  void initState() {
    super.initState();
    getCommonSearchParam();
    getItemsList();
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
                      getItemsList();
                    }));
              }),
            ),
            GestureDetector(
              onTap: () => isPanelVisible.value = !isPanelVisible.value,
              child: customWidget.setAssetsImg("switch_btn@3x.png",
                  width: 20, height: 20),
            )
          ],
        ),
        margin: const EdgeInsets.only(bottom: 0),
        border: const Border(top: BorderSide(width: 1, color: CustomColor.bg)),
        circular: 0);
  }


  Widget productCard(ItemsListModel item) {
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
      onTap: () => Routes.goPage("ProductDetail",param: {"isHavePurge":true}),
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
                    child:item.filePath==""?const SizedBox(width: 60,height: 60,): customWidget.setNetworkImg('${Constant.base_url}${item.filePath}', width: 60, height: 60),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center, // ✅ 垂直居中
                      children: [
                        customWidget.setTextOverflow(item.itemName!,
                            fontSize: 13,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(right: 6)),
                        customWidget.setRichText("累計贩壳：", "${item.totalSaleCount}",
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
                tabWidget(),
                Expanded(
                    child: Obx(()=>ListView.builder(
                        itemCount: productData.length,
                        padding: const EdgeInsets.only(bottom: 80,top: 15),
                        itemBuilder: (context, index) {
                          return productCard(
                              productData[index]);
                        })))
              ],
            ),
          ),
          Obx(
            () => SlideUpPanel(
              showPanel: isPanelVisible.value,
              child: SiftWrapWidget(
                siftBtnDataIsSelectes: siftBtnDataIsSelectes,
                siftBtnData: commonSearchList,
                kindId: kindIdList,
                sift: isPanelVisible,
                cancelText: "キャンセル",
                subOnTap: () {
                  getItemsList();
                  isPanelVisible.value = false;
                },
                cancelOnTap: () {
                  isPanelVisible.value = false;
                },
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
                  decoration: const BoxDecoration(
                    color: CustomColor.white,
                  ),
                  child: customWidget.setOutLinedButton("追加",
                  onPressed: ()=>Routes.goPage("ProductDetail",param: {"isHavePurge":false}),
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
