import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 通知
class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  /// 通知リスト
  RxList noticeList = [0, 0, 0, 0, 0].obs;
  Widget mainListShow() {
    return Obx(
      () => ListView.separated(
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () => _tabController.index == 0
                  ? Routes.goPage( '/OrderDetail',
                      param: {"isStorePickup": false, "orderStateIndex": 1})
                  : Routes.goPage( '/InLibraryManagement'),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customWidget.setText(
                            "新規注文のお知らせ:お客樣rrqqs が2025-07-28日に配送注文を予約しました。",
                            maxLines: 100,
                            fontSize: 14,
                            color: CustomColor.black_3,
                          ),
                          const SizedBox(height: 4), // 主副标题间距
                          customWidget.setText(
                            "2025-07-25 01:11:22",
                            maxLines: 100,
                            fontSize: 12,
                            color: CustomColor.black_9,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    customWidget.setText(
                      "[既読]",
                      maxLines: 100,
                      fontSize: 12,
                      color: CustomColor.black_9,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index) {
            return Container(
                width: Get.width - 30,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: const Divider(
                  height: 1,
                  color: CustomColor.blackD,
                ));
          },
          itemCount: noticeList.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: CustomColor.bg,
        appBar: customWidget.setAppBar(
          title: "お知らせ",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                const Divider(height: 1, color: CustomColor.bg),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'お知らせ'),
                    Tab(text: '在庫アラ-ム'),
                  ],
                  dividerHeight: 1, 
                  dividerColor: CustomColor.bg,
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: Colors.transparent, 
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(
                        color: CustomColor.redE8, width: 2),
                    insets: EdgeInsets.symmetric(
                      horizontal: (Get.width - (Get.width - 30) / 2) / 2,
                    ),
                  ),
                  labelColor: CustomColor.black_3,
                  unselectedLabelColor: CustomColor.black_9,
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: TabBarView(
              controller: _tabController,
              children: [mainListShow(), mainListShow()]),
        ));
  }
}
