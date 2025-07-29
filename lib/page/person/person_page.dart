import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 我的页面
class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.bg,
      appBar: customWidget.setAppBar(
          isLeftShow: false,
          title: 'マイ店舗',
          centerTitle: false,
          backgroundColor: CustomColor.orangeFFB554),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/person_back@3x.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 顶部标题
              customWidget.setContain(
                  margin: EdgeInsets.fromLTRB(15, 55, 15, 15),
                  padding: EdgeInsets.all(15),
                  SizedBox(
                    width: Get.width - 30 - 30,
                    child: Column(
                      children: [
                        customWidget.setAssetsImg(
                            "converted_icon_1024x1024 (2).png",
                            width: 46),
                        customWidget.setTextOverflow("クリックしてログイン",
                            fontSize: 13,
                            color: CustomColor.black_3,
                            margin: const EdgeInsets.only(top: 15))
                      ],
                    ),
                  )),

              /// 下面数据
              customWidget.setContain(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  padding: const EdgeInsets.all(0),
                  Column(
                    children: [
                      // 主页
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("ホ-ムペ-ジ",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_shoppage@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      // 通知
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("お知らせ",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_notification@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      // 未付款订单
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("未払注文",
                              fontWeight: FontWeight.bold),
                          leading:  customWidget.setAssetsImg("order_bar_select@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("商品管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_commodity@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),

                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("引取時間管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_reservate@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("在庫管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_inventory@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      // 库存警报
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("在庫アラ-ム",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_notification@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("バスフ-ドの変更",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("login_secret@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                      // 注销登录
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("ログオンの終了",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg("person_loginout@3x.png",width: 24),
                          onTap: () => Routes.goPage(context, "/SettingPage")),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
