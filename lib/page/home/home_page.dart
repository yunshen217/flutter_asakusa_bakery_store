import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/refreshable_list_view.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/page/home/mixin/home_page_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/home/home_order_card.dart';
import 'package:flutter_asakusa_bakery_store/view/home/to_login_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, HomePageMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    time.value = Utils().getCurrentDate();
    notLogin = Global.userInfo!.refreshToken == null;
    onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _editTrackingPopup() {
    Widget widget = customWidget.setTextFieldForLogin(editcontroller,
        hintText: "送り状No.を入力してください",
        suffix: Container(
          padding: const EdgeInsets.all(10),
          child: customWidget.setAssetsImg("order_scan@2x.png"),
        ));
    customWidget.showConfirmDialog(context,
        title: "番号の編集",
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
          title: "注文",
          isLeftShow: false,
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(40),
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
                            time.value,
                            maxYear: DateTime.now().year,
                            minYear: DateTime.now().year,
                            confirm: (date) {
                              time.value = date;
                              onRefresh();
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
                            orderDetailsSelectedId.value = [];
                            if (orderStateIndex.value == 2) {
                              tabs.value = ["すべて", "配達"];
                            } else {
                              tabs.value = ["すべて", "配達", "引取"];
                            }
                            tabIndex.value = 0;
                            isAllSelectedMail.value = false;
                            isAllSelectedStorePickup.value = false;
                            onRefresh();
                          }));
                    })),
              ),
              //  ["すべて", "配達", "引取"]
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
                              judgeTheValueOfIsSend();
                              onRefresh();
                            }));
                      }),
                    )),
              ),
              notLogin
                  ? const Expanded(child: ToLoginPage())
                  : Expanded(
                      child: Obx(() => records.isEmpty
                          ? customWidget.noData()
                          : RefreshableListView(
                              refreshController: refreshController,
                              onRefresh: onRefresh,
                              onLoading: onLoading,
                              itemWidget: (context) => SingleChildScrollView(
                                child: Obx(
                                  () => Column(
                                    children:
                                        List.generate(records.length, (i) {
                                      RxBool isSelected = false.obs;
                                      if (orderDetailsSelectedId.isNotEmpty) {
                                        for (var item
                                            in orderDetailsSelectedId) {
                                          if (records[i].id == item) {
                                            isSelected.value = true;
                                          }
                                        }
                                      }
                                      return Obx(
                                        () => HomeOrderCard(
                                          orderStateIndex:
                                              orderStateIndex.value,
                                          orderDetail: records[i],
                                          isSelected: isSelected.value,
                                          isStorePickup: records[i].isSend == 0,
                                          onTap: () {
                                            isSelected.toggle();
                                            if (isSelected.value) {
                                              orderDetailsSelectedId
                                                  .add(records[i].id);
                                            } else {
                                              orderDetailsSelectedId
                                                  .remove(records[i].id);
                                            }
                                          },
                                          editTrackingPopup: _editTrackingPopup,
                                          cancelOrder: () {
                                            customWidget.showConfirmDialog(
                                              context,
                                              title: "",
                                              child: customWidget.setText(
                                                  "注文を取り消しますか？",
                                                  textAlign: TextAlign.center),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 20),
                                              onPressed: () => cancelOrder(
                                                  '${records[i].id}'),
                                            );
                                          },
                                          finishOnTap: () => getOrderStatus(
                                              '${records[i].id}'),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            )),
                    ),
              Obx(() =>
                  (orderStateIndex.value == 0 || orderStateIndex.value == 1) ||
                          notLogin
                      ? const SizedBox( height: 70,)
                      : Container(height: 0,))
            ],
          ),
          Positioned(
              bottom: 0,
              child: Obx(() => (orderStateIndex.value == 2 ||
                          orderStateIndex.value == 3) ||
                      notLogin
                  ? Container()
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                      decoration:
                          BoxDecoration(color: CustomColor.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Obx(() => tabIndex.value == 0 ||
                                      tabIndex.value == 1
                                  ? customWidget.setOutLinedButton("全ての郵送",
                                      circular: 8.0,
                                      minimumSize: const Size(79, 35),
                                      fontColor: CustomColor.black_3,
                                      lineColor: CustomColor.blackD,
                                      linewidth: 0.5, onPressed: () {
                                      isAllSelectedMail.value =
                                          !isAllSelectedMail.value;
                                      isAllSelectedStorePickup.value = false;
                                      allSelectedMail();
                                    })
                                  : Container()),
                              Obx(() => tabIndex.value == 0 ||
                                      tabIndex.value == 2
                                  ? customWidget.setOutLinedButton("全ての引取",
                                      circular: 8.0,
                                      minimumSize: const Size(79, 35),
                                      fontColor: CustomColor.black_3,
                                      lineColor: CustomColor.blackD,
                                      margin: EdgeInsets.only(
                                          left: tabIndex.value == 2 ? 0 : 10),
                                      linewidth: 0.5, onPressed: () {
                                      isAllSelectedStorePickup.value =
                                          !isAllSelectedStorePickup.value;
                                      isAllSelectedMail.value = false;
                                      allSelectedStorePickup();
                                    })
                                  : Container()),
                            ],
                          ),
                          customWidget.setCupertinoButton(
                              orderStateIndex.value == 0 ? "一括処理" : "引渡／出荷",
                              width: 120,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 35,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              textColor: CustomColor.black_3,
                              color: CustomColor.redE8,
                              onPressed: () => getOrderStatusBatch())
                        ],
                      ),
                    )))
        ],
      ),
    );
  }
}
