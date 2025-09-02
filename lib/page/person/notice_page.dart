import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/message_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RxInt type = 5.obs;
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getUnreadUpdate();
    getMessage();
  }

  getMessage() async{
    await backEndRepository.doGet('${Constant.base_url}merchant/messages?type=${type.value}&merchantId=${Global.merchantId}',successRequest: (result) {
      if(result["data"]!=null){
        messageList.clear();
        messageList.addAll(
          result["data"].map<MessageModel>((json) => MessageModel.fromJson(json)).toList(),
        );
      }
    },);
  }

  getUnreadUpdate() async{
    await backEndRepository.doPut("${Constant.base_url}merchant/messages/unread-update",params: {"merchantId":Global.merchantId,},successRequest: (result) {
    },);
  }

  /// 通知リスト
  Widget mainListShow() {
    return Obx(
      () =>messageList.isEmpty?customWidget.noData(): ListView.separated(
          itemBuilder: (_, index) {
            final item = messageList[index];
            return InkWell(
              onTap: () => _tabController.index == 0
                  ? Routes.goPage( '/OrderDetail',
                      param: {"id":item.businessId})
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
                            item.message!,
                            maxLines: 100,
                            fontSize: 14,
                            color: CustomColor.black_3,
                          ),
                          const SizedBox(height: 4), 
                          customWidget.setText(
                            item.createTime!,
                            maxLines: 100,
                            fontSize: 12,
                            color: CustomColor.black_9,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    customWidget.setText(
                      item.readFlag=="0"?"[未読]":"[既読]",
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
          itemCount: messageList.length),
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
                    Tab(text: '在庫アラーム'),
                  ],
                  onTap: (value) {
                    value == 0?type.value = 5:type.value = 2;
                    getMessage();
                  },
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
