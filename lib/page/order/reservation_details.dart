import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/page/order/mixin/reservation_details_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 予約詳細
class ReservationDetails extends StatefulWidget {
  const ReservationDetails({super.key});

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> with ReservationDetailsMixin{
  // time
  final arguments = Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerList.clear();
    time.value = arguments["time"]??"";
    getPlansItems();
    controllerList.assignAll(
      List.generate(detailsData.length, (_) => TextEditingController()),
    );
    focusNodeList.assignAll(
      List.generate(detailsData.length, (_) => FocusNode()),
    );

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
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          )),
      body: Stack(
        children: [
          Container(
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
                                margin: EdgeInsets.only(right: 15)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customWidget.setTextOverflow("予約時間未满",
                                    margin: EdgeInsets.only(bottom: 5.0),
                                    color: CustomColor.black_3,
                                    fontWeight: FontWeight.bold),
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
                            customWidget.setCupertinoButton("予約中止",
                                fontSize: 12,
                                textColor: CustomColor.black_3,
                                height: 30,
                                circular: 8,
                                fontWeight: FontWeight.normal,
                                minimumSize: 68,
                                onPressed: () {
                                  customWidget.showConfirmDialog(context,
                                  title: "",
                                  contentPadding:const EdgeInsets.fromLTRB(24, 0, 24, 10),
                                  barrierDismissible:false,
                                  useDefaultWidth:true,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  child: customWidget.setText(
                                      "予約終了を確認しますか?",
                                      maxLines: 100,
                                      textAlign: TextAlign.center,
                                      color: CustomColor.black_9),
                                  onPressed: (){});
                                }),
                          ],
                        )
                      ],
                    ),
                    circular: 0,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    margin: EdgeInsets.all(0)),
                customWidget.rowWithTextEditing("商品名", "計画数", "注文数", "在庫数", true, false,
                    TextEditingController(),FocusNode()),
                Expanded(
                    child: ListView.builder(
                        itemCount: detailsData.length,
                        itemBuilder: (context, index) {
                          final item = detailsData[index];
                          return customWidget.rowWithTextEditing(
                              item["name"],
                              item["plannedQuantity"],
                              item["orderNumber"],
                              item["inventory"],
                              false,
                              true,
                              controllerList[index],focusNodeList[index]);
                        })),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: customWidget.setContain(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                customWidget.setCupertinoButton("更新",
                    minimumSize: Get.width - 30,
                    height: 36,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    fontSize: 12,
                    textColor: CustomColor.black_3,
                    fontWeight: FontWeight.normal,
                    circular: 5,
                    onPressed: () {}),
              ))
        ],
      ),
    );
  }
}
