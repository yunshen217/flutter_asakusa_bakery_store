import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 预约详情
class ReservationDetails extends StatefulWidget {
  const ReservationDetails({super.key});

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  /// 时间
  RxString time = "2024-03-21".obs;

  /// 详情数据列表
  RxList detailsData = [
    {
      "name": "test",
      "plannedQuantity": "12",
      "orderNumber": "0",
      "inventory": "12"
    },
    {
      "name": "黑骑士バン",
      "plannedQuantity": "12",
      "orderNumber": "0",
      "inventory": "12"
    },
    {
      "name": "コ-ヒ-クリ-ムチ-ズバン",
      "plannedQuantity": "12",
      "orderNumber": "0",
      "inventory": "12"
    },
    {
      "name": "ココナッツバン",
      "plannedQuantity": "12",
      "orderNumber": "0",
      "inventory": "12"
    }
  ].obs;

  /// 控制器
  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 清空再生成，避免热重载重复添加
    controllerList.clear();
    controllerList.assignAll(
      List.generate(detailsData.length, (_) => TextEditingController()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (final c in controllerList) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _row(
      String name,
      String plannedQuantity,
      String orderNumber,
      String inventory,
      bool isBg,
      bool isTextEditing,
      TextEditingController controller) {
    controller.text = plannedQuantity;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 11, 0, 11),
      decoration: BoxDecoration(
        color: isBg ? CustomColor.bg : Colors.transparent,
        border: const Border(bottom: BorderSide(color: CustomColor.bg)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: customWidget.setText(name,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: isTextEditing
                      ? customWidget.setTextField(controller,
                          height: 34,
                          circular: 5,
                          margin: const EdgeInsets.only(top: 10),
                          textAlign: TextAlign.center,
                          fillColor: Colors.transparent,
                          borderSide: const BorderSide(
                              color: CustomColor.blackD, width: 1))
                      : customWidget.setText(plannedQuantity,
                          color:
                              isBg ? CustomColor.gray_6 : CustomColor.black_3,
                          fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: customWidget.setText(orderNumber,
                      textAlign: TextAlign.center,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: customWidget.setText(inventory,
                      textAlign: TextAlign.center,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
        ],
      ),
    );
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
                            customWidget.setCupertinoButton("注文数書戾",
                                fontSize: 12,
                                textColor: CustomColor.black_3,
                                height: 30,
                                circular: 8,
                                fontWeight: FontWeight.normal,
                                minimumSize: 85,
                                margin: const EdgeInsets.only(right: 10),
                                onPressed: () {
                              customWidget.showConfirmDialog(context,
                                  title: "",
                                  contentPadding:const EdgeInsets.fromLTRB(24, 0, 24, 10),
                                  barrierDismissible:false,
                                  useDefaultWidth:true,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  child: customWidget.setText(
                                      "全商品の注文数を計画数に上書きしますか?",
                                      maxLines: 100,
                                      textAlign: TextAlign.center,
                                      color: CustomColor.black_9),
                                  onPressed: (){});
                            }),
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
                _row("商品名", "計画数", "注文数", "在庫数", true, false,
                    TextEditingController()),
                Expanded(
                    child: ListView.builder(
                        itemCount: detailsData.length,
                        itemBuilder: (context, index) {
                          final item = detailsData[index];
                          return _row(
                              item["name"],
                              item["plannedQuantity"],
                              item["orderNumber"],
                              item["inventory"],
                              false,
                              true,
                              controllerList[index]);
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
