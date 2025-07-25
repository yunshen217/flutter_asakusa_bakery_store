import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  /// tab
  List<Tab> tabs = [const Tab(text: "列表"), const Tab(text: "图表")];

  /// 列表 ： 0、图表 ： 1
  RxInt mainTabIndex = 0.obs;

  /// 副标题tab
  List subTitleTabs = ["最近一天", "预约中"];

  /// 最近一天 ： 0、预约中 ： 1
  RxInt subTitleIndex = 0.obs;

  /// 列表数据
  RxList listData = [1, 1, 1].obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 获取数据
  void getData(tag) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: BaseScaffold(
        backgroundColor: CustomColor.bg,
        appBar: customWidget.setAppBar(
            isLeftShow: false, // 左侧的按钮不显示
            centerTitle: false, // 标题不居中
            isTitle: false,
            titleChild: customWidget.setText("预约状况",
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
                preferredSize:
                    const Size.fromHeight(50), // 设置了一个50高度的区域，用于放置自定义的TabBar
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
                          children: List.generate(subTitleTabs.length, (i) {
                            return GestureDetector(
                              onTap: () {
                                subTitleIndex.value = i;
                                debugPrint(
                                    "subTitleIndex.value --------------- ${subTitleIndex.value}");
                              },
                              child: Row(
                                children: [
                                  customWidget.setTextOverflow(subTitleTabs[i],
                                      fontSize: 12,
                                      color: CustomColor.black_3,
                                      margin: const EdgeInsets.only(right: 5)),
                                  customWidget.setAssetsImg(
                                      "reservate_select@3x.png",
                                      width: 16,
                                      height: 16)
                                ],
                              ),
                            );
                          }),
                        )),
                  ],
                ))),
        body: Obx(() =>
            mainTabIndex.value == 0 ? listDataWidget() : chartDataWidget()),
      ),
    );
  }

  /// 列表数据
  Widget listDataWidget() {
    return RefreshIndicator(
      color: CustomColor.redE8,
      onRefresh: () async => getData(0),
      child: listData.isEmpty
          ? CustomScrollView(
              slivers: [
                SliverFillRemaining(
                    child: Center(
                        child: customWidget.setAssetsImg("no_data_2.png",
                            width: 160, height: 135)))
              ],
            )
          : ListView.builder(
            controller: _scrollController,
            shrinkWrap: true, // 只包裹内容
            physics: const AlwaysScrollableScrollPhysics(),// 始终允许滚动
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10), // 整个列表四周空白
              itemBuilder: (_,index){
                if(listData.isEmpty){
                  return const SizedBox();
                }
                return InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: CustomColor.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        customWidget.setRowText("2024-03-18", "预约中",text2Color: CustomColor.redE8,margin: const EdgeInsets.only(bottom: 15)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 15),
                          decoration: BoxDecoration(
                            color: CustomColor.grayF8,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              customWidget.setRowText("订单数", "20",margin: const EdgeInsets.only(bottom: 10)),
                              customWidget.setRowText("邮寄数", "5",margin: const EdgeInsets.only(bottom: 10)),
                              customWidget.setRowText("数量", "100",margin: const EdgeInsets.only(bottom: 10)),
                              customWidget.setRowText("金额", '\$ 168.00',margin: const EdgeInsets.only(bottom: 0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: listData.length),
    );
  }

  /// 图表数据
  Widget chartDataWidget() {
    return Container();
  }
}
