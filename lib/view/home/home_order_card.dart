import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';

/// 今日订单订单卡片
class HomeOrderCard extends StatelessWidget {
  /// 订单状态编号 0：制作中 1：待取 2：出货 3：结束
  int orderStateIndex;

  /// 订单详情
  Map orderDetail;
  // 点击顶部单选按钮后所执行的方法
  Function()? onTap;
  // 是否选中
  bool? isSelected = false;
  // 是否为店取
  bool isStorePickup;
  // 完成按钮
  Function()? finishOnTap;
  // 编辑单号按钮
  Function()? editTrackingPopup;
  HomeOrderCard(
      {super.key,
      required this.orderStateIndex,
      required this.orderDetail,
      this.onTap,
      this.isSelected,
      required this.isStorePickup,
      this.editTrackingPopup,
      this.finishOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    customWidget.setRichText("", "A3013405769958",
                        color: CustomColor.black_3,
                        subtitleColor: CustomColor.black_3,
                        fontSize: 15,
                        subFontSize: 18),
                    if (orderStateIndex == 0 || orderStateIndex == 1) ...[
                      GestureDetector(
                        onTap: onTap,
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
            margin: EdgeInsets.only(top: isStorePickup == false ? 0 : 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customWidget.setText(
                  "田中",
                  color: CustomColor.black_3,
                  fontSize: 14,
                ),
                // customWidget.setCupertinoButton("注文取消",
                //     height: 40,
                //     minimumSize: 80,
                //     fontWeight: FontWeight.normal,
                //     fontSize: 15,
                //     textColor: CustomColor.black_3,
                //     color: CustomColor.grayC7,
                //     onPressed: finishOnTap)
              ],
            ),
          ),
          // 详情
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: CustomColor.grayF8,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customWidget.setRichText("受取方式：", isStorePickup ? "引取" : "配達", margin:  const EdgeInsets.only(bottom: 10),fontSize: 14,subFontSize: 14,color: CustomColor.black_9),
                customWidget.setRichText("受取番号：", "C297", margin:  const EdgeInsets.only(bottom: 10),fontSize: 14,subFontSize: 14,color: CustomColor.black_9),
                customWidget.setRichText("数量：", "竹炭ココナッツバンx1 黑胡麻ロ-ルンx1", margin:  const EdgeInsets.only(bottom: 10),fontSize: 14,subFontSize: 14,color: CustomColor.black_9),
                customWidget.setRichText("コメント：","", fontSize: 14,subFontSize: 14,color: CustomColor.black_9),
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
                  customWidget.setText("2025-07-25",
                      color: CustomColor.black_3, fontSize: 16),
                ],
              ),
              if (orderStateIndex == 0) ...[
                customWidget.setCupertinoButton("焼き上がリ",
                    height: 40,
                    minimumSize: 80,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    textColor: CustomColor.black_3,
                    onPressed: finishOnTap)
              ],
              if (orderStateIndex == 1 && isStorePickup == true) ...[
                customWidget.setCupertinoButton("已取",
                    height: 40,
                    minimumSize: 80,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    textColor: CustomColor.black_3,
                    onPressed: finishOnTap)
              ],
              if (orderStateIndex == 1 && isStorePickup == false) ...[
                Row(
                  children: [
                    GestureDetector(
                      onTap: editTrackingPopup,
                      child: Container(
                        width: 90,
                        height: 40,
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CustomColor.grayF8,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: CustomColor.blackD)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customWidget.setAssetsImg("edit.png",
                                width: 16, height: 16),
                            customWidget.setText("送状番号",
                                fontSize: 12, color: CustomColor.black_3)
                          ],
                        ),
                      ),
                    ),
                    customWidget.setCupertinoButton("出荷",
                        height: 40,
                        minimumSize: 80,
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
                    customWidget.setText("送状番号",
                        color: CustomColor.gray_6, fontSize: 12),
                    customWidget.setText("YD03161240",
                        color: CustomColor.black_3, fontSize: 16),
                  ],
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}
