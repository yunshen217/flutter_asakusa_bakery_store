import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/routes/routes.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 在庫管理
class InLibraryManagement extends StatefulWidget {
  const InLibraryManagement({super.key});

  @override
  State<InLibraryManagement> createState() => _InLibraryManagementState();
}

class _InLibraryManagementState extends State<InLibraryManagement> {
  RxList inLibraryManagementList = [
    {
      "name":"白生地",
      "num":"94.99",
      "stockArrivalAlert":"100",
    },
    {
      "name":"黑生地",
      "num":"94.99",
      "stockArrivalAlert":"100",
    },
    {
      "name":"白生地",
      "num":"94.99",
      "stockArrivalAlert":"100",
    }
  ].obs;
  Widget _row(String name, String num, String stockArrivalAlert, Function onTap,
      bool isBg) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
      decoration: BoxDecoration(
        color: isBg ? CustomColor.bg : Colors.transparent,
        border: const Border(bottom: BorderSide(color: CustomColor.bg)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  child: customWidget.setText(name,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      maxLines: 10,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: customWidget.setText(num,
                  maxLines: 10,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  alignment: Alignment.center,
                  child: customWidget.setText(stockArrivalAlert,
                  maxLines: 10,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: ()=>onTap(),
                child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 10),
                    alignment: Alignment.center,
                    child: customWidget.setText("详细",
                    maxLines: 10,
                        color: isBg ? CustomColor.gray_6 : CustomColor.redE8,
                        fontSize: 12)),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "在庫管理",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                _row("材料名", "在庫数", "入荷アラ一ト", () {}, true),
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(inLibraryManagementList.length, (index){
                      final item = inLibraryManagementList[index];
                      return _row(item["name"], '${item["num"]}kg', '${item["stockArrivalAlert"]}kg', ()=>Routes.goPage(context, "/InLibraryDetail"), false);
                    }),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
                  decoration: const BoxDecoration(
                    color: CustomColor.white,
                  ),
                  child: customWidget.setOutLinedButton("材料追加",
                  onPressed: ()=>Routes.goPage(context,"MaterialAddition"),
                      circular: 5,
                      linewidth: 0.5,
                      minimumSize: Size(Get.width - 15, 34),
                      isHaveLeftIcon: true,
                      imgPath: "组 239@3x.png",
                      lineColor: CustomColor.blackD,
                      fontColor: Colors.black)))
        ],
      ),
    );
  }
}
