import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 订单详情
class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final arguments = Get.arguments;
  // 是否为店取
  bool isStorePickup = false;
  @override
  void initState() {
    super.initState();
    isStorePickup = arguments["isStorePickup"];
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.bg,
      appBar: customWidget.setAppBar(
          title: "注文の詳細",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 顶部
            Container(
              width: Get.width,
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 22),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    CustomColor.orangeFFB554,
                    CustomColor.orangeFFEAC7
                  ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customWidget.setAssetsImg(
                      isStorePickup
                          ? "order_detail_finish@3x.png"
                          : "order_detail_mail@3x.png",
                      width: 24,
                      height: 24),
                  customWidget.setText(isStorePickup ? "受取済" : "出荷済",
                      fontSize: 18, color: CustomColor.black2D)
                ],
              ),
            ),
            // 客户
            customWidget.setContain(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customWidget.setText("お客樣：liu",
                        fontSize: 14, color: CustomColor.black_3),
                    customWidget.setTextOverflow("15880",
                        margin: EdgeInsets.only(left: 10),
                        fontSize: 14,
                        color: CustomColor.black_3)
                  ],
                ),
                customWidget.setTextOverflow("受取番号：C295",
                    fontSize: 14,
                    color: CustomColor.black_3,
                    margin: EdgeInsets.only(top: 5)),
              ],
            )),
            // 订单详情
            customWidget.setContain(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.setTextOverflow("オ-ダ-样细",
                        fontSize: 14,
                        color: CustomColor.black_3,
                        margin: const EdgeInsets.only(bottom: 5)),
                    customWidget.setTable(color: Colors.transparent, [
                      TableRow(children: [
                        customWidget.setTextOverflow("オ-ダ-番号",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("A1753405342867",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("注文時間",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("2025-07-25 01:02:22",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("ビッキング方法",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow(isStorePickup ? "店頭引取" : "郵送(冷凍)",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      if (!isStorePickup)
                        TableRow(children: [
                          customWidget.setTextOverflow("配送先",padding: const EdgeInsets.symmetric(vertical: 5),
                              fontSize: 12, color: CustomColor.gray_6),
                          customWidget.setTextOverflow("柬京都千代田区千代田比",padding: const EdgeInsets.all(5),
                              fontSize: 12, color: CustomColor.black_3)
                        ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("予约时间",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("2025-07-2816:00-18:00",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("支付状况",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("支払済",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                    ]),
                  ],
                ),
                margin: const EdgeInsets.all(15)),
                /// 商品明细
                customWidget.setContain(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.setTextOverflow("商品の詳細",
                        fontSize: 14,
                        color: CustomColor.black_3,
                        margin: const EdgeInsets.only(bottom: 5)),
                    customWidget.setTable(color: Colors.transparent,[
                      TableRow(children: [
                        customWidget.setTextOverflow("商品名称",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_9),
                        customWidget.setTextOverflow("数量",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_9),
                        customWidget.setTextOverflow("金额",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_9),
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("黑騎士バン",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("1",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("￥ 300",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("コ-ヒ-クリ-ムチ-ズバン",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("1",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("￥ 300",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("ココナッツバン",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("1",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                        customWidget.setTextOverflow("￥ 300",margin: const EdgeInsets.symmetric(vertical: 5),fontSize: 12,color: CustomColor.black_3),
                      ]),
                    ])
                  ],
                ),margin: EdgeInsets.symmetric(horizontal: 15)),
                /// 订单金额
                customWidget.setContain(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customWidget.setTextOverflow("オ-ダ-金額",
                        fontSize: 14,
                        color: CustomColor.black_3,
                        margin: const EdgeInsets.only(bottom: 5)),
                    customWidget.setTable(color: Colors.transparent,[
                      TableRow(children: [
                        customWidget.setTextOverflow("合計金额",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 890",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.redE84F43)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("商品代金",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 890",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("商品代金",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 890",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("配送料",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 0",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("ク-ル料",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 0",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("ポイント支払 ",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("0pt",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                      TableRow(children: [
                        customWidget.setTextOverflow("合計消費税",padding: const EdgeInsets.symmetric(vertical: 5),
                            fontSize: 12, color: CustomColor.gray_6),
                        customWidget.setTextOverflow("￥ 65",padding: const EdgeInsets.all(5),
                            fontSize: 12, color: CustomColor.black_3)
                      ]),
                    ])
                  ],
                ),margin: EdgeInsets.all(15))
          ],
        ),
      ),
    );
  }
}
