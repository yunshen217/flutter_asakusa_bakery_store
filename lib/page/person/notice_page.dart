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

class _NoticePageState extends State<NoticePage> {
  /// 通知列表
  RxList noticeList = [0, 0, 0, 0, 0].obs;
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
            )),
        body: Obx(
          () => ListView.separated(
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () => Routes.goPage(context, '/OrderDetail',param: {"isStorePickup":false,"orderStateIndex":1}),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
                        children: [
                          // 左侧主内容区域
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
                          // 右侧 [既読] 文字
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
        ));
  }
}
