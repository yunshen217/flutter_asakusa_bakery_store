
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/order_details_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 注文の詳細
class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  // orderStateIndex:注文の状態
  // id
  final arguments = Get.arguments;
  // Header style
  RxMap<String, String> titleUI = {"title": "受取済", "img": ""}.obs;
  final orderDetailData = Rxn<OrderDetailsModel>();
  RxString paymentStatus = "".obs;
  @override
  void initState() {
    super.initState();
    getOrderDetails();
  }

  getOrderDetails() {
    backEndRepository.doGet(
      "${Constant.base_url}merchant/orders/${arguments["id"]}",
      successRequest: (result) {
        print("result ---------------------- ${result["data"]}");
        orderDetailData.value =
            OrderDetailsModel.fromJson(result["data"] ?? {});
        paymentStatus.value = orderDetailData.value!.paymentStatus == "0"
            ? "未払い"
            : orderDetailData.value!.paymentStatus == "1"
                ? "支払済"
                : orderDetailData.value!.paymentStatus == "2"
                    ? "支払キャンセル"
                    : orderDetailData.value!.paymentStatus == "3"
                        ? "返金済"
                        : orderDetailData.value!.paymentStatus == "4"
                            ? "支払エラー"
                            : "";
        print("paymentStatus.value ------- ${paymentStatus.value}");
        print(
            "orderDetailData.value!.orderStatus ------- ${orderDetailData.value!.orderStatus}");
        switch (orderDetailData.value!.orderStatus.toString()) {
          case "0":
            titleUI.value = {"title": "キャンセル", "img": ""};
            return;
          case "1":
            titleUI.value = {"title": "支払待", "img": ""};
            return;
          case "2":
            titleUI.value = {"title": "注文確定", "img": ""};
            return;
          case "3":
            titleUI.value = {"title": "製造中", "img": "order_detail_make@3x.png"};
            return;
          case "4":
            titleUI.value = {
              "title": "焼き上り",
              "img": "order_detail_receive@3x.png"
            };
            return;
          case "5":
            titleUI.value = {"title": "出荷済", "img": "order_detail_mail@3x.png"};
            return;
          case "6":
            titleUI.value = {
              "title": "受取済",
              "img": "order_detail_finish@3x.png"
            };
            return;
          default:
            titleUI.value = {"title": "", "img": ""};
            return;
        }
      },
    );
  }

  List<TableRow> tableRowList() {
    List<TableRow> list = [];
    list.add(
      TableRow(children: [
        customWidget.setTextOverflow("商品名称",
            margin: const EdgeInsets.symmetric(vertical: 5),
            fontSize: 12,
            color: CustomColor.black_9),
        customWidget.setTextOverflow("数量",
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            fontSize: 12,
            color: CustomColor.black_9),
        customWidget.setTextOverflow("金额",
            margin: const EdgeInsets.symmetric(vertical: 5),
            fontSize: 12,
            color: CustomColor.black_9),
      ]),
    );
    if (orderDetailData.value!.psOrderDetails!.isNotEmpty) {
      for (var data in orderDetailData.value!.psOrderDetails!) {
        list.add(
          TableRow(children: [
            customWidget.setTextOverflow(data!.itemName!,
                margin: const EdgeInsets.symmetric(vertical: 5),
                fontSize: 12,
                color: CustomColor.black_3),
            customWidget.setTextOverflow("${data.itemCount!}",
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                fontSize: 12,
                color: CustomColor.black_3),
            customWidget.setTextOverflow("￥ ${data.itemPrice}",
                margin: const EdgeInsets.symmetric(vertical: 5),
                fontSize: 12,
                color: CustomColor.black_3),
          ]),
        );
      }
    }
    return list;
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
        body: Obx(() {
          final data = orderDetailData.value;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
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
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          titleUI["img"] == ""
                              ? Container()
                              : customWidget.setAssetsImg(titleUI["img"],
                                  width: 24, height: 24),
                          customWidget.setText(titleUI["title"]!,
                              fontSize: 18, color: CustomColor.black2D)
                        ],
                      )),
                ),
                customWidget.setContain(Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customWidget.setText(
                            "お客樣：${orderDetailData.value!.sendName}",
                            fontSize: 14,
                            color: CustomColor.black_3),
                        customWidget.setTextOverflow("受取番号：",
                            fontSize: 14,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(top: 5)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customWidget.setTextOverflow(
                            orderDetailData.value!.phoneNumber!,
                            margin: const EdgeInsets.only(left: 10),
                            fontSize: 14,
                            color: CustomColor.black_3),
                        customWidget.setTextOverflow(
                            orderDetailData.value!.sendNo!,
                            fontSize: 14,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(top: 5, left: 10)),
                      ],
                    )
                  ],
                )),
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
                            customWidget.setTextOverflow("オ-ダ-番号",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow(
                                orderDetailData.value!.orderNo!,
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("注文時間",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow(
                                orderDetailData.value!.orderDate!,
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("ビッキング方法",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow(
                                orderDetailData.value!.isSend == 0
                                    ? "店頭引取"
                                    : "郵送(${orderDetailData.value!.distributionMode == 0 ? '常温' : orderDetailData.value!.distributionMode == 1 ? "冷凍" : "冷蔵"})",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          if (!(orderDetailData.value!.isSend == 0))
                            TableRow(children: [
                              customWidget.setTextOverflow("配送先",
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  fontSize: 12,
                                  color: CustomColor.gray_6),
                              customWidget.setTextOverflow(
                                  "${orderDetailData.value!.prefectures}${orderDetailData.value!.municipalities}${orderDetailData.value!.streetAddress}${orderDetailData.value!.building}",
                                  padding: const EdgeInsets.all(5),
                                  fontSize: 12,
                                  color: CustomColor.black_3)
                            ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("予约时间",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow(
                                orderDetailData.value!.sendTime!,
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("支付状况",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow(paymentStatus.value,
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color:
                                    orderDetailData.value!.paymentStatus == "1"
                                        ? CustomColor.black_3
                                        : CustomColor.redE84F43)
                          ]),
                        ]),
                      ],
                    ),
                    margin: const EdgeInsets.all(15)),

                /// 商品の詳細
                customWidget.setContain(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customWidget.setTextOverflow("商品の詳細",
                            fontSize: 14,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(bottom: 5)),
                        customWidget.setTable(columnWidths: const {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1)
                        }, color: Colors.transparent, tableRowList())
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15)),

                /// 金额
                customWidget.setContain(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customWidget.setTextOverflow("オ-ダ-金額",
                            fontSize: 14,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(bottom: 5)),
                        customWidget.setTable(color: Colors.transparent, [
                          TableRow(children: [
                            customWidget.setTextOverflow("合計金额",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("￥ ${orderDetailData.value!.totalAmount!}",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.redE84F43)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("商品代金",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("￥ ${orderDetailData.value!.totalAmount}",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("配送料",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("￥ ${orderDetailData.value!.deliveryCharge}",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("クール料",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("￥ ${orderDetailData.value!.refrigerationFee}",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("獲得ポイント",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("${orderDetailData.value!.usedPoint}pt",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          TableRow(children: [
                            customWidget.setTextOverflow("ポイント支払 ",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("${orderDetailData.value!.usedPoint}pt",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                          
                          TableRow(children: [
                            customWidget.setTextOverflow("合計消費税",
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                fontSize: 12,
                                color: CustomColor.gray_6),
                            customWidget.setTextOverflow("￥ ${orderDetailData.value!.taxDeductionAmount!}",
                                padding: const EdgeInsets.all(5),
                                fontSize: 12,
                                color: CustomColor.black_3)
                          ]),
                        ])
                      ],
                    ),
                    margin: const EdgeInsets.all(15))
              ],
            ),
          );
        }));
  }
}
