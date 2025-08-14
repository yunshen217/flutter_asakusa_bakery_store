import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  RxInt messageNum = 0.obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getMessage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getMessage() async {
    await backEndRepository.doGet(
      "${Constant.base_url}merchant/messages/listGroup/2,5",
      successRequest: (result) {
        int num = 0;
        if (result["data"] != null) {
          final data2 = result["data"]["2"] ?? [];
          final data5 = result["data"]["5"] ?? [];

          num = 0; // 重置计数器

          for (var data in data2) {
            if (data["readFlag"] == "0") {
              num += 1;
            }
          }

          for (var data in data5) {
            if (data["readFlag"] == "0") {
              num += 1;
            }
          }

          messageNum.value = num;
        }
      },
    );
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
              customWidget.setContain(
                  margin: const EdgeInsets.fromLTRB(15, 55, 15, 15),
                  padding: const EdgeInsets.all(15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30 - 30,
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
              customWidget.setContain(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  padding: const EdgeInsets.all(0),
                  Column(
                    children: [
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("ホ-ムペ-ジ",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg(
                              "person_shoppage@3x.png",
                              width: 24),
                          onTap: () => Routes.goPage("/StoreSetup")),
                      // 通知
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: Row(
                            children: [
                              customWidget.setText("お知らせ",
                                  fontWeight: FontWeight.bold),
                              Obx(() => messageNum.value == 0
                                  ? Container()
                                  : Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                      margin: const EdgeInsets.only(
                                          bottom: 10, left: 3),
                                      decoration: BoxDecoration(
                                          color: CustomColor.redE84F43,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: customWidget.setText("$messageNum",
                                          color: CustomColor.white,
                                          fontSize: 10),
                                    ))
                            ],
                          ),
                          leading: customWidget.setAssetsImg(
                              "person_notification@3x.png",
                              width: 24),
                          onTap: () => Routes.goPage("/NoticePage")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("商品管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg(
                              "person_commodity@3x.png",
                              width: 24),
                          onTap: () => Routes.goPage("/ProductManagement")),

                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("引取時間管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg(
                              "person_reservate@3x.png",
                              width: 24),
                          onTap: () => Routes.goPage("/TimeManagement")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("在庫管理",
                              fontWeight: FontWeight.bold),
                          leading: customWidget.setAssetsImg(
                              "person_inventory@3x.png",
                              width: 24),
                          onTap: () => Routes.goPage("/InLibraryManagement")),
                      ListTile(
                          trailing: const Icon(Icons.chevron_right),
                          contentPadding:
                              const EdgeInsets.only(right: 15, left: 15),
                          title: customWidget.setText("バスフ-ドの変更",
                              fontWeight: FontWeight.bold),
                          leading: customWidget
                              .setAssetsImg("login_secret@3x.png", width: 24),
                          onTap: () => Routes.goPage("/ChangeOfBusService")),
                      ListTile(
                        trailing: const Icon(Icons.chevron_right),
                        contentPadding:
                            const EdgeInsets.only(right: 15, left: 15),
                        title: customWidget.setText("ログオンの終了",
                            fontWeight: FontWeight.bold),
                        leading: customWidget
                            .setAssetsImg("person_loginout@3x.png", width: 24),
                        onTap: () {
                          customWidget.showCustomDialog(context,
                              title: "", content: "ログアウトします", confirm: () {
                            Routes.pushNamedAndRemoveUntil('/LoginPage');
                          });
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
