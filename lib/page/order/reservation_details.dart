import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/slide_up_panel.dart';
import 'package:flutter_asakusa_bakery_store/page/order/mixin/reservation_details_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/sift_wrap_widget.dart';
import 'package:get/get.dart';

/// 予約詳細
class ReservationDetails extends StatefulWidget {
  const ReservationDetails({super.key});

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails>
    with ReservationDetailsMixin {
  // time、status
  final arguments = Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time.value = arguments != null ? arguments["time"] : "";
    status.value = arguments != null ? arguments["status"] : "";
    btnText.value = status.value == "予約一時中止"?"予約再開":"予約中止";
    
    getPlansItems();
    getCommonSearchParam();
    isFirstLogin.value = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (final c in controllerList) {
      c.dispose();
    }
    for (final c in focusNodeList) {
      c.dispose();
    }
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "予約詳細",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        isRightShow: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
        right: GestureDetector(
          onTap: () => isPanelVisible.value = !isPanelVisible.value,
          child: customWidget.setAssetsImg("switch_btn@3x.png",
              width: 23,
              height: 23,
              padding: const EdgeInsets.fromLTRB(0, 15, 15, 15)),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                customWidget.setContain(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 头像
                        Row(
                          children: [
                            customWidget.setAssetsImg("person_shop_icon@3x.png",
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.only(right: 15)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(()=>customWidget.setTextOverflow(status.value,
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    color: CustomColor.black_3,
                                    fontWeight: FontWeight.bold),),
                                Obx(() => customWidget.setText(time.value,
                                    fontSize: 12.0, color: CustomColor.gray_6))
                              ],
                            )
                          ],
                        ),
                        // 按钮
                        Row(
                          children: [
                            // customWidget.setCupertinoButton("注文数書戾",
                            //     fontSize: 12,
                            //     textColor: CustomColor.black_3,
                            //     height: 30,
                            //     circular: 8,
                            //     fontWeight: FontWeight.normal,
                            //     minimumSize: 85,
                            //     margin: const EdgeInsets.only(right: 10),
                            //     onPressed: () {
                            //   customWidget.showConfirmDialog(context,
                            //       title: "",
                            //       contentPadding:const EdgeInsets.fromLTRB(24, 0, 24, 10),
                            //       barrierDismissible:false,
                            //       useDefaultWidth:true,
                            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //       child: customWidget.setText(
                            //           "全商品の注文数を計画数に上書きしますか?",
                            //           maxLines: 100,
                            //           textAlign: TextAlign.center,
                            //           color: CustomColor.black_9),
                            //       onPressed: (){});
                            // }),
                            Obx(()=>customWidget.setCupertinoButton(btnText.value,
                                fontSize: 12,
                                textColor: CustomColor.black_3,
                                height: 30,
                                circular: 8,
                                fontWeight: FontWeight.normal,
                                minimumSize: 68, onPressed: () {
                              customWidget.showConfirmDialog(context,
                                  title: "",
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(24, 0, 24, 10),
                                  barrierDismissible: false,
                                  useDefaultWidth: true,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  child: customWidget.setText("予約終了を確認しますか?",
                                      maxLines: 100,
                                      textAlign: TextAlign.center,
                                      color: CustomColor.black_9),
                                  onPressed: () {
                                    Get.back();
                                    getPlansReserveStatus();
                                  });
                            }),)
                          ],
                        )
                      ],
                    ),
                    circular: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    margin: const EdgeInsets.all(0)),
                customWidget.rowWithTextEditing("","商品名", "計画数", "注文数", "在庫数",
                    true, false, TextEditingController(), FocusNode(),(){}),
                Expanded(
                    child: Obx(()=>detailsData.isEmpty&&!isFirstLogin.value?customWidget.noData(): ListView.builder(
                        itemCount: detailsData.length,
                        itemBuilder: (context, index) {
                          final item = detailsData[index];
                          return customWidget.rowWithTextEditing(
                            item.filePath!,
                          item.itemName!,
                          '${item.planCount}',
                          '${item.orderCount}',
                          '${item.stockCount}',
                          false,
                          true,
                          controllerList[index],
                          focusNodeList[index],
                          () => setState(() {
                            currentFocusNode = focusNodeList[index];
                          })) ;
                        }))),
                const SizedBox(
                  height: 50,
                )
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
                  itemName.value = searchController.text;
                  getPlansItems();
                  isPanelVisible.value = false;
                },
                cancelOnTap: () {
                  isPanelVisible.value = false;
                  searchController.text = "";
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.setTextOverflow("キーフード",
                        fontWeight: FontWeight.bold,
                        margin: const EdgeInsets.only(top: 0, bottom: 10)),
                    ClearableTextField(
                        controller: searchController,
                        hintText: 'キーフードを入カしてください',
                        margin: const EdgeInsets.only(left: 0,right: 0,bottom: 10),
                        readOnly: false),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: customWidget.setContain(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(top: 10),
                circular: 0,
                customWidget.setCupertinoButton("更新",
                    minimumSize: Get.width - 30,
                    height: 36,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    fontSize: 12,
                    textColor: CustomColor.black_3,
                    fontWeight: FontWeight.normal,
                    circular: 5,
                    onPressed: () {
                      currentFocusNode.unfocus();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        plansCountList.value = [];
                        for (var i = 0; i < detailsData.length; i++) {
                          if(controllerList[i].text != ""&&(detailsData[i].planCount.toString() != controllerList[i].text)){
                            if(int.parse(controllerList[i].text)<detailsData[i].orderCount!){
                              controllerList[i].text = detailsData[i].orderCount!.toString();
                            }
                            plansCountList.add({
                              "id": detailsData[i].id,
                              "orderDate": time.value,
                              "planCount": controllerList[i].text
                            });
                          }
                        }
                        if(plansCountList.isNotEmpty){
                          getPlansCount(context);
                          print("plansCountList --------------- $plansCountList");
                        }
                      });
                    }),
              ))
        ],
      ),
    );
  }
}
