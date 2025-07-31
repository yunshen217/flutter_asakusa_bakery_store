import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

/// 时间管理
class TimeManagement extends StatefulWidget {
  const TimeManagement({super.key});

  @override
  State<TimeManagement> createState() => _TimeManagementState();
}

class _TimeManagementState extends State<TimeManagement> {
  List timeData = [
    "08:00-09:00",
    "09:00~10:00",
    "10:00-11:00",
    "11:00~12:00",
    "12:00~13:00",
    "13:00~14:00",
    "14:00~15:00",
    "15:00~16:00",
    "16:00~17:00",
    "17:00~18:00",
    "18:00~19:00"
  ];
  RxList<RxBool> timeDataSelect = [false.obs].obs;
  RxBool isShowBottomBtn = false.obs;
  @override
  void initState() {
    super.initState();
    timeDataSelect.assignAll(List.generate(timeData.length, (_) => false.obs));
  }

  Widget _row(
      String num, String content, bool isBg, bool isSelect, Function onTab) {
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
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  child: customWidget.setText(num,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  alignment: Alignment.center,
                  child: customWidget.setText(content,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  child: isBg
                      ? Container()
                      : GestureDetector(
                          onTap: () => onTab(),
                          child: customWidget.setAssetsImg(
                              isSelect
                                  ? "order_circle_select@3x.png"
                                  : "order_circle@3x.png",
                              width: 20,
                              height: 20),
                        ))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
          title: "時間帯",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          )),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                _row("シ-ケンス番号", "時間带", true, false, () {}),
                Expanded(
                    child: ListView.builder(
                        itemCount: timeData.length,
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: (context, index) {
                          final item = timeData[index];
                          return Obx(() => _row("${index + 1}", item, false,
                                  timeDataSelect[index].value, () {
                                timeDataSelect[index].value =
                                    !timeDataSelect[index].value;
                                if (timeDataSelect[index].value) {
                                  isShowBottomBtn.value = true;
                                }else{
                                  isShowBottomBtn.value = false;
                                }
                              }));
                        })),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child:Obx(()=>!isShowBottomBtn.value?Container(): Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                  decoration: const BoxDecoration(
                    color: CustomColor.white,
                  ),
                  child: customWidget.setOutLinedButton("更新",
                      circular: 5,
                      linewidth: 0.5,
                      minimumSize: Size(Get.width-15, 34),
                      lineColor: CustomColor.blackD,
                      fontColor: CustomColor.black_3))))
        ],
      ),
    );
  }
}
