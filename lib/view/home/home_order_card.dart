import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/order_list_model.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:get/get.dart';

/// 今日の注文カード
// ignore: must_be_immutable
class HomeOrderCard extends StatelessWidget {
  /// 注文ステータス番号 0：製作中 1：受け取り待ち 2：出荷 3：終了
  int orderStateIndex;

  /// 注文詳細
  OrderListModelRecords orderDetail;
  // 上部のラジオボタンをクリックした後に実行されるメソッド
  Function()? onTap;
  // 選択されていますか
  bool? isSelected = false;
  // 店取ですか？
  bool isStorePickup;
  // 完了ボタン
  Function()? finishOnTap;
  // 編集番号ボタン
  Function()? editTrackingPopup;
  Function()? cancelOrder;
  HomeOrderCard(
      {super.key,
      required this.orderStateIndex,
      required this.orderDetail,
      this.onTap,
      this.isSelected,
      required this.isStorePickup,
      this.editTrackingPopup,
      this.finishOnTap,
      this.cancelOrder});

  @override
  Widget build(BuildContext context) {
    String numberText = "";
    if (orderDetail.psOrderDetails!.isNotEmpty) {
      for (var data in orderDetail.psOrderDetails!) {
        numberText == ""
            ? numberText += '${data!.itemName} ×${data.itemCount}  '
            : numberText += ' ${data!.itemName} ×${data.itemCount}  ';
      }
    }

    return GestureDetector(
      onTap: () {
        Routes.goPage('/OrderDetail', param: {
          "orderStateIndex": orderStateIndex,
          "id":orderDetail.id
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: CustomColor.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            isStorePickup == false && orderStateIndex == 3
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customWidget.setRichText("", orderDetail.orderNo,
                          color: CustomColor.black_3,
                          subtitleColor: CustomColor.black_3,
                          fontSize: 15,
                          subFontSize: 18),
                      if (orderStateIndex == 0 || orderStateIndex == 1) ...[
                        GestureDetector(
                          onTap: ()=>onTap!(),
                          child: customWidget.setAssetsImg(
                              isSelected != null && isSelected == true
                                  ? "order_circle_select@3x.png"
                                  : "order_circle@3x.png",
                              width: 24,
                              height: 24),
                        )
                      ],
                      // if (orderStateIndex == 3) ...[
                      //   customWidget.setText("结束",
                      //       color: CustomColor.gray_6, fontSize: 14)
                      // ]
                    ],
                  ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customWidget.setText(
                    orderDetail.sendName!,
                    color: CustomColor.black_3,
                    fontSize: 14,
                  ),
                  if (orderStateIndex == 0 || orderStateIndex == 1)
                    customWidget.setCupertinoButton("注文取消",
                        height: 35,
                        width: 80,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        textColor: CustomColor.black_3,
                        color: CustomColor.grayC7,
                        onPressed: cancelOrder)
                ],
              ),
            ),
            Container(
              width: Get.width-20,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: CustomColor.grayF8,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customWidget.setRichText("受取方式：", isStorePickup ? "引取" : "配達",
                      margin: const EdgeInsets.only(bottom: 10),
                      fontSize: 14,
                      subFontSize: 14,
                      color: CustomColor.black_9),
                  customWidget.setRichText("受取番号：", orderDetail.pickupNo,
                      margin: const EdgeInsets.only(bottom: 10),
                      fontSize: 14,
                      subFontSize: 14,
                      color: CustomColor.black_9),
                  customWidget.setRichText("数量：", numberText,
                      margin: const EdgeInsets.only(bottom: 10),
                      fontSize: 14,
                      subFontSize: 14,
                      color: CustomColor.black_9),
                  customWidget.setRichText("コメント：", orderDetail.remark,
                      fontSize: 14,
                      subFontSize: 14,
                      color: CustomColor.black_9),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.setText(isStorePickup ? "引取時間：" : "配達時間：",
                        color: CustomColor.gray_6, fontSize: 12),
                    customWidget.setText(orderDetail.appointmentTime!,
                        color: CustomColor.black_3, fontSize: 16),
                  ],
                ),
                if (orderStateIndex == 0) ...[
                  customWidget.setCupertinoButton("焼き上り",
                      height: 35,
                      width: 95,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      textColor: CustomColor.black_3,
                      onPressed: finishOnTap)
                ],
                if (orderStateIndex == 1 && isStorePickup == true) ...[
                  customWidget.setCupertinoButton("引渡",
                      height: 35,
                      width: 80,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      textColor: CustomColor.black_3,
                      onPressed: finishOnTap)
                ],
                if (orderStateIndex == 1 && isStorePickup == false) ...[
                  Row(
                    children: [
                      // GestureDetector(
                      //   onTap: editTrackingPopup,
                      //   child: Container(
                      //     width: 90,
                      //     height: 40,
                      //     // ignore: prefer_const_constructors
                      //     margin: EdgeInsets.only(right: 10),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: CustomColor.grayF8,
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(
                      //             width: 1, color: CustomColor.blackD)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         customWidget.setAssetsImg("edit.png",
                      //             width: 16, height: 16),
                      //         customWidget.setText("送り状No.",
                      //             fontSize: 12, color: CustomColor.black_3)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      customWidget.setCupertinoButton("出荷",
                          height: 35,
                          width: 80,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          textColor: CustomColor.black_3,
                          onPressed: finishOnTap)
                    ],
                  )
                ],
                if (orderStateIndex == 2 || orderStateIndex == 3) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      customWidget.setText("送り状No.",
                          color: CustomColor.gray_6, fontSize: 12),
                      customWidget.setText(orderDetail.sendNo!,
                          color: CustomColor.black_3, fontSize: 16),
                    ],
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
