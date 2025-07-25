import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/home/home_order_card.dart';
import 'package:get/get.dart';

/// 主页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _editcontroller = TextEditingController();
  // 订单状态
  RxInt orderStateIndex = 0.obs;
  // 订单状态组件
  List orderState = [
    {
      "selected_icon": "order_state_make_select@3x.png",
      "un_selected_icon": "order_state_make@3x.png",
      "name": '製造中'
    },
    {
      "selected_icon": "order_state_receive_select@3x.png",
      "un_selected_icon": "order_state_receive@3x.png",
      "name": '出荷待'
    },
    {
      "selected_icon": "order_state_mail_select@3x.png",
      "un_selected_icon": "order_state_mail@3x.png",
      "name": '出荷済'
    },
    {
      "selected_icon": "order_state_finish_select@3x.png",
      "un_selected_icon": "order_state_finish@3x.png",
      "name": '完了'
    },
  ];
  // tab
  RxInt tabIndex = 0.obs;
  RxList<String> tabs = ["すべて", "配達", "引取"].obs;
  // false：邮寄 true：店取
  List orderDetails = [true, false, false];
  List<RxBool> orderDetailsSelected = <RxBool>[].obs;

  RxString time = "".obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    //  初始化：把每个元素变成 RxBool
    orderDetailsSelected.assignAll(
      List.generate(orderDetails.length, (_) => false.obs),
    );
    time.value = Utils().getCurrentDate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 编辑单号弹窗
  void _editTrackingPopup() {
    Widget widget = customWidget.setTextFieldForLogin(_editcontroller,
        hintText: "请输入单号",
        suffix: Container(
          padding: const EdgeInsets.all(10),
          child: customWidget.setAssetsImg("order_scan@2x.png"),
        ));
    customWidget.showConfirmDialog(context,
        title: "编辑单号",
        titleFontWeight: FontWeight.bold,
        titleColor: CustomColor.black_3,
        titleFontSize: 18.0,
        child: widget,
        onPressed: () {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.bg,
      appBar: customWidget.setAppBar(
          title: "注文一覧",
          isLeftShow: false,
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(40), // 设置了一个50高度的区域，用于放置自定义的TabBar
              child: Column(
                children: [
                  Container(
                      height: 1,
                      width: double.infinity,
                      color: CustomColor.grayF5),
                  Container(
                      height: 40,
                      color: CustomColor.white,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          customWidget.showMyDatePickerBottomBtn(
                            context,
                            selectDate: DateTime.now(),
                            confirm: (date) {
                              print("选中的日期：$date");
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => customWidget.setTextOverflow(time.value,
                                  fontSize: 12,
                                  color: CustomColor.black_3,
                                  margin: const EdgeInsets.only(right: 5)),
                            ),
                            customWidget.setAssetsImg("reservate_select@3x.png",
                                width: 16, height: 16)
                          ],
                        ),
                      )),
                ],
              ))),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(orderState.length, (i) {
                      final item = orderState[i];
                      return Obx(() => customWidget.setTopImgBottomText(
                          icon: i == orderStateIndex.value
                              ? item["selected_icon"]
                              : item["un_selected_icon"],
                          iconSize: 32,
                          margin: const EdgeInsets.all(0),
                          textTopMargin: 0,
                          text: item["name"],
                          color: i == orderStateIndex.value
                              ? CustomColor.black_3
                              : CustomColor.black_9,
                          fontSize: 12,
                          onTap: () {
                            orderStateIndex.value = i;
                            if (orderStateIndex.value == 2) {
                              tabs.value = ["すべて", "配達"];
                            } else {
                              tabs.value = ["すべて", "配達", "引取"];
                            }
                          }));
                    })),
              ),
              // 全部、邮寄、店取
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Obx(() => Row(
                      children: List.generate(tabs.length, (i) {
                        return Obx(() => customWidget.setUnderLineButton(
                                tabs[i],
                                margin: const EdgeInsets.only(left: 30),
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
                    )),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Obx(() => Column(
                      children: List.generate(orderDetails.length, (i) {
                        final selected = orderDetailsSelected[i].value; // 读一次即可
                        Widget widget = Container();
                        if (tabIndex.value == 0) {
                          widget = Obx(
                            () => HomeOrderCard(
                              orderStateIndex: orderStateIndex.value,
                              orderDetail: {},
                              isSelected: selected,
                              isStorePickup: orderDetails[i],
                              onTap: () => orderDetailsSelected[i].toggle(),
                              editTrackingPopup: _editTrackingPopup,
                              finishOnTap: () {},
                            ),
                          );
                        }
                        if (tabIndex.value == 1) {
                          widget = orderDetails[i]
                              ? Container()
                              : Obx(
                                  () => HomeOrderCard(
                                    orderStateIndex: orderStateIndex.value,
                                    orderDetail: {},
                                    isSelected: selected,
                                    isStorePickup: orderDetails[i],
                                    onTap: () =>
                                        orderDetailsSelected[i].toggle(),
                                    editTrackingPopup: _editTrackingPopup,
                                    finishOnTap: () {},
                                  ),
                                );
                        }
                        if (tabIndex.value == 2) {
                          if (orderStateIndex.value == 2) {
                            widget = Container();
                          } else {
                            widget = !orderDetails[i]
                                ? Container()
                                : Obx(
                                    () => HomeOrderCard(
                                      orderStateIndex: orderStateIndex.value,
                                      orderDetail: {},
                                      isSelected: selected,
                                      isStorePickup: orderDetails[i],
                                      onTap: () =>
                                          orderDetailsSelected[i].toggle(),
                                      editTrackingPopup: _editTrackingPopup,
                                      finishOnTap: () {},
                                    ),
                                  );
                          }
                        }
                        return widget;
                      }),
                    )),
              )),
              Obx(() => orderStateIndex.value == 0 || orderStateIndex.value == 1
                  ? const SizedBox(
                      height: 70,
                    )
                  : Container())
            ],
          ),
          Positioned(
              bottom: 0,
              child: Obx(() => orderStateIndex.value == 2 ||
                      orderStateIndex.value == 3
                  ? Container()
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration:
                          BoxDecoration(color: CustomColor.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // 阴影颜色
                          blurRadius: 8, // 模糊半径
                          spreadRadius: 0, // 扩散半径（0 表示不放大）
                          offset: const Offset(0, 4), //  正 Y 值：向下偏移
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          customWidget.setOutLinedButton("すべて選択",
                              circular: 8.0,
                              minimumSize: const Size(79, 30),
                              fontColor: CustomColor.black_3,
                              lineColor: CustomColor.blackD,
                              linewidth: 0.5, onPressed: () {
                            if (tabIndex.value == 0) {
                              orderDetailsSelected.assignAll(
                                  orderDetailsSelected
                                      .map((e) => true.obs)
                                      .toList());
                            }
                            // if(tabIndex.value == 1){
                            //   orderDetailsSelected.assignAll(orderDetailsSelected.map((e)=>(e.value == true?false:e.value).obs).toList());
                            // }
                            // if(tabIndex.value == 2){
                            //   orderDetailsSelected.assignAll(orderDetailsSelected.map((e)=>(e.value == false?true:e.value).obs).toList());
                            // }
                          }),
                          customWidget.setCupertinoButton(
                              orderStateIndex.value == 0 ? "完了" : "受け取り/発送済み",
                              minimumSize: 120,
                              height: 30,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              textColor: CustomColor.black_3,
                              color: CustomColor.redE8,
                              onPressed: () {})
                        ],
                      ),
                    )))
        ],
      ),
    );
  }
}
