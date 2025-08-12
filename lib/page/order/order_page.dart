import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/refreshable_list_view.dart';
import 'package:flutter_asakusa_bakery_store/common/utils.dart';
import 'package:flutter_asakusa_bakery_store/page/order/mixin/order_page_mixin.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/home/to_login_page.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin, OrderPageMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    timeStart.value = Utils().getCurrentDate();
    timeEnd.value = Utils().getCurrentDate();
    // getDetailData();
    notLogin = Global.userInfo!.refreshToken == null;
    getOrderList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getData(tag) {}

  Widget timeSelected(String time, Function fun) {
    return GestureDetector(
      onTap: () => fun(),
      child: Row(
        children: [
          customWidget.setTextOverflow(time,
              fontSize: 12,
              color: CustomColor.black_3,
              margin: const EdgeInsets.only(right: 5)),
          customWidget.setAssetsImg("reservate_select@3x.png",
              width: 16, height: 16)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: BaseScaffold(
        backgroundColor: CustomColor.bg,
        appBar: customWidget.setAppBar(
            isLeftShow: false,
            centerTitle: false,
            isTitle: false,
            titleChild: customWidget.setText("計画&予約",
                fontSize: 18, color: CustomColor.black_3),
            isRightShow: true,
            color: CustomColor.white,
            right: Container(
                height: 50,
                color: CustomColor.white,
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8, right: 15),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border:
                            Border.all(color: CustomColor.blackD, width: 1)),
                    child: customWidget.setTabBar(tabs,
                        indicatorPadding: EdgeInsets.zero,
                        fontSize: 12,
                        borderRadius: 10,
                        color: CustomColor.black_3,
                        unselectedLabelColor: CustomColor.black_3, onTab: (e) {
                      mainTabIndex.value = e;
                      debugPrint(
                          "mainTabIndex.value --------------- ${mainTabIndex.value}");
                    }))),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Column(
                  children: [
                    Container(
                        height: 1,
                        width: double.infinity,
                        color: CustomColor.grayF5),
                    Container(
                        height: 50,
                        color: CustomColor.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(() => timeSelected(timeStart.value, () {
                                  customWidget.showMyDatePickerBottomBtn(
                                    context,
                                    timeStart.value,
                                    isOnlyShowNowMonthsAndDays: true,
                                    maxYear: DateTime.now().year,
                                    minYear: DateTime.now().year,
                                    confirm: (date) {
                                      timeStart.value = date;
                                      onRefresh();
                                    },
                                  );
                                })),
                            Obx(() => timeSelected(timeEnd.value, () {
                                  customWidget.showMyDatePickerBottomBtn(
                                    context,
                                    timeEnd.value,
                                    maxYear: DateTime.now().year,
                                    isOnlyShowNowMonthsAndDays: true,
                                    minYear: DateTime.now().year,
                                    confirm: (date) {
                                      if (DateTime.parse(timeStart.value)
                                          .isAfter(
                                              DateTime.parse(timeEnd.value))) {
                                        customWidget.toastShow(
                                            "現在の時刻は開始時刻より前にすることはできません");
                                        return;
                                      }
                                      timeEnd.value = date;
                                      onRefresh();
                                    },
                                  );
                                })),
                          ],
                        )),
                  ],
                ))),
        body: notLogin
            ? const ToLoginPage()
            : Obx(() =>
                mainTabIndex.value == 0 ? listDataWidget() : chartDataWidget()),
      ),
    );
  }

  Widget listDataWidget() {
    return RefreshableListView(
      refreshController: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      itemWidget: (context) => orderPlansData.isEmpty
          ? customWidget.noData()
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Obx(() => Column(
                      children: List.generate(
                        orderPlansData.length,
                        (index) {
                          if (orderPlansData.isEmpty) {
                            return const SizedBox();
                          }
                          final item = orderPlansData[index];
                          String status = item.status == "1"
                              ? "準備中"
                              : (item.status == "2" ? "営業中" : "休み");
                          return InkWell(
                            onTap: () => Routes.goPage('/ReservationDetails',param: {"time":item.reserveDate!}),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  customWidget.setRowText(
                                      item.reserveDate!, status,
                                      text2Color: CustomColor.redE8,
                                      margin:
                                          const EdgeInsets.only(bottom: 15)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 15),
                                    decoration: BoxDecoration(
                                      color: CustomColor.grayF8,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        customWidget.setRowText(
                                            "計画倜数", '${item.planCount!}',
                                            margin: const EdgeInsets.only(
                                                bottom: 10)),
                                        customWidget.setRowText(
                                            "予約倜数", '${item.orderCount!}',
                                            margin: const EdgeInsets.only(
                                                bottom: 10)),
                                        customWidget.setRowText(
                                            "当日在庫数", "${item.todayInStore}",
                                            margin: const EdgeInsets.only(
                                                bottom: 10)),
                                        customWidget.setRowText(
                                            "予約件数", '${item.totalCount}',
                                            margin: const EdgeInsets.only(
                                                bottom: 10)),
                                        customWidget.setRowText(
                                            "予約金额", '\$ ${item.allAmount}',
                                            margin: const EdgeInsets.only(
                                                bottom: 0)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ),
            ),
    );
  }

  Widget chartBox(String text1, String text2) {
    return Container(
      width: 95,
      height: 61,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: CustomColor.grayF5, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getDetailData();
            },
            child: Text("hahahha"),
          ),
          customWidget.setText(text1, fontSize: 12, color: CustomColor.gray_6),
          const SizedBox(
            height: 5,
          ),
          customWidget.setText(text2, fontSize: 12, color: CustomColor.black_3),
        ],
      ),
    );
  }

  Widget chartDataWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: CustomColor.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(()=>chartBox("郵送件数", sendOrderCount.value)),
                Obx(()=>chartBox("商品数", totalCount.value)),
                Obx(()=>chartBox("商品の金额", allAmount.value)),
              ],
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 15),
              child: Obx(() => Echarts(
                    option: '''
        {
          grid: { left: '3%', right: '4%', bottom: '3%',top:'10%', containLabel: true },
          xAxis: {
            type: 'category',
            data: ${chartsData["xAxis"].map((e) => '"$e"').toList()},
            axisLine: { lineStyle: { color: '#999999' } },   // 只留一条直线
            axisTick: { show: false },                   // 去掉刻度
            splitLine: { show: false },                  // 去掉垂直分割线
            axisLabel: { interval: 0, rotate: 0 }
          },
          yAxis: {
            type: 'value',
            axisLabel: { show: false },   // 隐藏纵坐标数字
            splitLine: { show: true }     // 保留横线
          },
          dataZoom: [{
            type: 'inside',   // ← 关键：内置滑动，不显示滚动条
            xAxisIndex: 0,
            startValue: 0,    // 初始显示 0~4（共 5 根）
            endValue: 4
          }],
          series: [{
            name: '订单',
            type: 'bar',
            data: ${chartsData["yAxis"].map((e) => num.parse(e)).toList()}, // y轴要数字
            itemStyle: { color: '#FFDAA1' },
            barWidth: 26,
            emphasis: { itemStyle: { color: '#FFA244' } },
            label: {
              show: true,
              position: 'top',
              color: '#ffa244',
              fontSize:"14",
              formatter: '{c}'
            }
          }]
        }
        ''',
        extraScript: '''
            chart.on('click', function(params) {
              if(params.componentType === 'series') {
                // var xAxisValue = params.name;
                // Messager.postMessage(xAxisValue);
                Messager.postMessage(params.dataIndex.toString());
              }
            });
        ''',
        onMessage: (String message) {
          print("00------------$message");
                final index = int.tryParse(message) ?? -1;
                sendOrderCount.value = orderPlansData[index].sendOrderCount.toString();
        totalCount.value = orderPlansData[index].totalCount.toString();
        allAmount.value = orderPlansData[index].allAmount.toString();
              },
            )),
            )
          ],
        ),
      ),
    );
  }
}
