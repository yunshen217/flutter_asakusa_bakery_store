import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/time_period_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 時間管理
class TimeManagement extends StatefulWidget {
  const TimeManagement({super.key});

  @override
  State<TimeManagement> createState() => _TimeManagementState();
}

class _TimeManagementState extends State<TimeManagement> {
  RxList<TimePeriodModelTimePeriodList?> timePeriodModel =
      <TimePeriodModelTimePeriodList>[].obs;
  RxList<RxBool> timeDataSelect = <RxBool>[].obs;
  RxList<RxBool> timeDataSelectCopy = <RxBool>[].obs;
  RxBool isShowBottomBtn = false.obs;
  RxString selectedTimePeriod = "".obs;
  @override
  void initState() {
    super.initState();
    gettimePeriods();
  }

  gettimePeriods() async {
    await backEndRepository.doGet(
      "${Constant.base_url}merchant/time-periods?merchantId=${Global.merchantId}",
      successRequest: (result) {
        TimePeriodModel timeList =
            TimePeriodModel.fromJson(result["data"] ?? "");
        timePeriodModel.value = timeList.timePeriodList!;
        if (timePeriodModel.isNotEmpty) {
          timeDataSelect.clear();
          timeDataSelect.assignAll(
              List.generate(timePeriodModel.length, (_) => false.obs));
          final selectedSet = timeList.selectedTimePeriod!
              .split(',')
              .map((e) => int.parse(e.trim()))
              .toSet();

          for (var i = 0; i < timePeriodModel.length; i++) {
            final idInt = int.parse(timePeriodModel[i]!.id!);
            timeDataSelect[i].value = selectedSet.contains(idInt);
          }
          timeDataSelectCopy.value = RxList.from(
              timeDataSelect.map((element) => RxBool(element.value)));
        }
      },
    );
  }

  savetimePeriods() async {
    await backEndRepository.doPost(
      "${Constant.base_url}merchant/time-periods",
      params: {
        "timePeriod": "$selectedTimePeriod",
        "merchantId": Global.merchantId,
      },
      successRequest: (result) {
        Get.back();
      },
    );
  }

  bool listsEqual(RxList<RxBool> listA, RxList<RxBool> listB) {
    if (listA.length != listB.length) return false;
    for (int i = 0; i < listA.length; i++) {
      if (listA[i].value != listB[i].value) return false;
    }
    return true;
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
                _row("シーケンス番号", "時間帯", true, false, () {}),
                Expanded(
                    child: Obx(() => ListView.builder(
                        itemCount: timePeriodModel.length,
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: (context, index) {
                          final item = timePeriodModel[index];
                          return Obx(() => _row("${index + 1}", item!.label!,
                                  false, timeDataSelect[index].value, () {
                                timeDataSelect[index].value =
                                    !timeDataSelect[index].value;
                                if (!listsEqual(
                                    timeDataSelect, timeDataSelectCopy)) {
                                  isShowBottomBtn.value = true;
                                } else {
                                  isShowBottomBtn.value = false;
                                }
                              }));
                        }))),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Obx(() => !isShowBottomBtn.value
                  ? Container()
                  : Container(
                      width: Get.width,
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                      decoration: const BoxDecoration(
                        color: CustomColor.white,
                      ),
                      child: customWidget.setOutLinedButton("更新",
                          circular: 5,
                          linewidth: 0.5,
                          minimumSize: Size(Get.width - 15, 34),
                          lineColor: CustomColor.blackD,
                          fontColor: CustomColor.black_3, onPressed: () {
                        selectedTimePeriod.value = "";
                        String timePeriod = "";
                        for (var i = 0; i < timeDataSelect.length; i++) {
                          if (timeDataSelect[i].value) {
                            timePeriod == ""
                                ? timePeriod += timePeriodModel[i]!.id!
                                : timePeriod += ",${timePeriodModel[i]!.id!}";
                          }
                        }
                        selectedTimePeriod.value = timePeriod;
                        savetimePeriods();
                      }))))
        ],
      ),
    );
  }
}
