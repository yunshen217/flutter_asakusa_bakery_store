import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/page/person/mixin/store_setup_mixin.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/calendar/calendar_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/calendar/models/date_model.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// 店舗設定
class StoreSetup extends StatefulWidget {
  const StoreSetup({super.key});

  @override
  State<StoreSetup> createState() => _StoreSetupState();
}

class _StoreSetupState extends State<StoreSetup> with StoreSetupMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 天数に0〜30のデータを追加する
    days.assignAll(List.generate(31, (i) => "$i"));
    timeHour.assignAll(
      List.generate(24, (i) => i.toString().padLeft(2, '0')),
    );
    selected.value = RxList<RxBool>.generate(restDays.length, (index) => false.obs);
    final today = DateTime.now();
    date.value = DateFormat('yyyy-MM-dd').format(today);
    getDetailData();
  }

  @override
  void dispose() {
    storeNameController.dispose();
    storeDescriptionController.dispose();
    postalCodeController.dispose();
    provinceController.dispose();
    cityController.dispose();
    streetController.dispose();
    addressController.dispose();
    phoneController.dispose();
    orderAmountMaxController.dispose();
    dailyOrderAmountMaxController.dispose();
    productNumberMaxController.dispose();
    productAmountMaxController.dispose();
    pointsRatioController.dispose();
    linkController1.dispose();
    linkController2.dispose();
    linkController3.dispose();
    linkController4.dispose();
    homeController.dispose();
    super.dispose();
  }

  Widget mainPageShow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 1,
          color: CustomColor.bg,
        ),
        infoWidget.titleWidget("店舗画像(3枚)", false),
        infoWidget.selectImage(localAssets:image,context: context,maxLength: 3,fileIds:fileIdList,netUrls:assetsImg),
        infoWidget.titleWidget("店舗名", true),
        ClearableTextField(
            controller: storeNameController,
            hintText: '店舗名を入カしてください',
            readOnly: false),
        infoWidget.titleWidget("一言の店舗説明(20文字)", false),
        customWidget.setTextField(
            storeDescriptionController, storeDescriptionFocusNode,
            hintText: '店舗名を入カしてください',
            circular: 5,
            maxLines: 5,
            height: 100,
            maxLength: 20,
            top: 10,
            left: 10,
            right: 10,
            borderSide: const BorderSide(color: CustomColor.blackD, width: 0.5),
            margin: const EdgeInsets.symmetric(horizontal: 15)),
        infoWidget.titleWidget("郵便番号", true),
        ClearableTextField(
            controller: postalCodeController,
            hintText: '郵便番号を入カしてください',
            readOnly: false,
            onTab: ()=>getPostCode(),),
        infoWidget.titleWidget("店舗住所", true),
        ClearableTextField(
            controller: provinceController, hintText: '都道府県', readOnly: true),
        ClearableTextField(
            controller: cityController, hintText: '市区町材', readOnly: true),
        ClearableTextField(
            controller: streetController, hintText: '番地', readOnly: false),
        ClearableTextField(
            controller: addressController,
            hintText: '建物名·部屋番号',
            readOnly: false),
        infoWidget.titleWidget("電話番号", false),
        ClearableTextField(
            controller: phoneController, hintText: '電話番号', readOnly: false),
        infoWidget.titleWidget("イートインスペースあり", true),
        Obx(() => infoWidget.pickerSelected(isThereDiningSpace.value,
                isThereDiningSpace.value == "イートインスペースあり", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [isThereDiningSpaceData],
                initialIndex: [0],
                title: '飲食工リアがあるかどうか',
                confirm: (list) => isThereDiningSpace.value = list[0],
              );
            })),
        infoWidget.titleWidget("最大予約可能日数", true),
        Obx(() => infoWidget.pickerSelected(
                bookingDayMax.value, bookingDayMax.value == "最大予約可能日数", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [days.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: '日数を選択してください',
                confirm: (list) => bookingDayMax.value = list[0],
              );
            })),
        infoWidget.titleWidget("予約締切日数", true),
        Obx(() => infoWidget.pickerSelected(reservationsAreClosedDay.value,
                reservationsAreClosedDay.value == "予約締切日数", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [days.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: '日数を選択してください',
                confirm: (list) => reservationsAreClosedDay.value = list[0],
              );
            })),
        infoWidget.titleWidget("予約締切時間", true),
        Obx(() => infoWidget.pickerSelected(
                appointmentTime.value, appointmentTime.value == "予約締切時間", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [
                  timeHour.map((e) => e.toString()).toList(),
                  timeMinute
                ],
                initialIndex: [0, 0],
                title: '時間を選択してください',
                confirm: (list) =>
                    appointmentTime.value = '${list[0]}:${list[1]}',
              );
            })),
        infoWidget.titleWidget("営業時間", true),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => infoWidget.pickerSelected(
                    startTime.value, startTime.value == "開始時間", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      timeHour.map((e) => e.toString()).toList(),
                      timeMinute
                    ],
                    initialIndex: [0, 0],
                    title: '時間を選択してください',
                    confirm: (list) =>
                        startTime.value = '${list[0]}:${list[1]}',
                  );
                }, width: (Get.width - 75) / 2)),
            customWidget.setText("~"),
            Obx(() => infoWidget
                    .pickerSelected(endTime.value, endTime.value == "終了時間", () {
                  customWidget.showCustomizationPicker(
                    context,
                    columnsData: [
                      timeHour.map((e) => e.toString()).toList(),
                      timeMinute
                    ],
                    initialIndex: [0, 0],
                    title: '時間を選択してください',
                    confirm: (list) => endTime.value = '${list[0]}:${list[1]}',
                  );
                }, width: (Get.width - 75) / 2)),
          ],
        ),
        infoWidget.titleWidget("定休日", false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(()=>GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: List.generate(
              restDays.length,
              (index) => customWidget.setOutLinedButton(
                restDays[index],
                fontColor:
                    selected[index].value ? CustomColor.white : CustomColor.redE8,
                backgroundColor:
                    selected[index].value ? CustomColor.redE8 : CustomColor.white,
                onPressed: () =>selected[index].value = !selected[index].value,
              ),
            ),
          )),
        ),
        infoWidget.titleWidget("特别休日", false),
        Obx(() => infoWidget.pickerSelected(specialHolidays.value,
            specialHolidays.value == "", () => showCalendar())),
        infoWidget.titleWidget("顧客每回注文金額上限", false),
        ClearableTextField(
            controller: orderAmountMaxController,
            hintText: '顧客每回注文金額上限を入力してください',
            readOnly: false),
        infoWidget.titleWidget("顧客每日注文金額上限", false),
        ClearableTextField(
            controller: dailyOrderAmountMaxController,
            hintText: '顧客每日注文金額上限を入力してください',
            readOnly: false),
        infoWidget.titleWidget("店舗每日予約商品数上限", false),
        ClearableTextField(
            controller: productNumberMaxController,
            hintText: '店舗每日予約商品数上限を入カしてください',
            readOnly: false),
        infoWidget.titleWidget("店舗每日予約金額上限", false),
        ClearableTextField(
            controller: productAmountMaxController,
            hintText: '店舗每日予約金额上限を入カしてく尤さい',
            readOnly: false),
        infoWidget.titleWidget("ポイント比率", false),
        ClearableTextField(
            controller: pointsRatioController,
            hintText: 'ポイント比率を入カしてィださい',
            readOnly: false),
        infoWidget.titleWidget("SNS1", false),
        Obx(() =>
            infoWidget.pickerSelected(sns1.value, sns1.value == "SNS1", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [snsData.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: 'sns',
                confirm: (list) => sns1.value = list[0],
              );
            })),
        infoWidget.titleWidget("リンク1", false),
        ClearableTextField(
            controller: linkController1, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS2", false),
        Obx(() =>
            infoWidget.pickerSelected(sns2.value, sns2.value == "SNS2", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [snsData.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: 'sns',
                confirm: (list) => sns2.value = list[0],
              );
            })),
        infoWidget.titleWidget("リンク2", false),
        ClearableTextField(
            controller: linkController2, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS3", false),
        Obx(() =>
            infoWidget.pickerSelected(sns3.value, sns3.value == "SNS3", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [snsData.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: 'sns',
                confirm: (list) => sns3.value = list[0],
              );
            })),
        infoWidget.titleWidget("リンク3", false),
        ClearableTextField(
            controller: linkController3, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS4", false),
        Obx(() =>
            infoWidget.pickerSelected(sns4.value, sns4.value == "SNS4", () {
              customWidget.showCustomizationPicker(
                context,
                columnsData: [snsData.map((e) => e.toString()).toList()],
                initialIndex: [0],
                title: 'sns',
                confirm: (list) => sns4.value = list[0],
              );
            })),
        infoWidget.titleWidget("リンク4", false),
        ClearableTextField(
            controller: linkController4, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("ホームページ", false),
        ClearableTextField(
            controller: homeController, hintText: 'ホームページ', readOnly: false),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
          title: "ホ-ムペ-ジ",
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
            child: SingleChildScrollView(
              child: mainPageShow(),
            ),
          ),
          infoWidget.bottomBtn("キャン乜ル", "保存", true, () =>Get.back(), () =>updateDetailData())
        ],
      ),
    );
  }

  void showCalendar() {
    if (date.value.isEmpty) {
      date.value = '2025-01-01';
    }

    customWidget.showCustomNoTitleDialog(
      context,
      confirm: () {
        print(
            "选中的日期：${selectedDates.map((e) => e.toString().substring(0, 10)).join(', ')}");
        selectedDates.isNotEmpty
            ? specialHolidays.value = "選択済み"
            : specialHolidays.value = "選択してください";
      },
      child: StatefulBuilder(builder: (_, state) {
        return SizedBox(
          height: 460,
          width: Get.width,
          child: CustomCalendarViewer(
            initDate: date.value,
            calendarType: CustomCalendarType
                .multiDates, // 1️⃣ Key: Change to multiple choices
            calendarStyle: CustomCalendarStyle.normal,
            animateDirection: CustomCalendarAnimatedDirection.horizontal,
            movingArrowSize: 15,
            local: "jp",
            showCurrentDayBorder: true,
            dates: selectedDates
                .map((e) => Date(date: DateTime.parse(e.toString())))
                .toList(), // ✅ Set the default selected date
            mDates: [],
            mOrderDates: mOrderDates,
            spaceBetweenMovingArrow: 40,
            closedDatesColor: Colors.white.withOpacity(0.7),
            showHeader: true,
            daysMargin:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
            showBorderAfterDayHeader: false,
            headerAlignment: MainAxisAlignment.spaceEvenly,
            calendarStartDay: CustomCalendarStartDay.sunday,
            activeColor: CustomColor.redE8,
            currentDayBorder: Border.all(color: CustomColor.redE8),
            onDatesUpdated: (List<Date> dates) {
              // 3️⃣ 選択した日付を同期させる
              selectedDates.value = dates.map((d) => d.date).toList();
            },
            onChange: (year, month) =>
                print("year ----- $year   month ------ $month"),
            onDayTapped: (date) {
              // 複数選択モードでは別途処理する必要はなく、onDatesUpdatedが統一的にコールバックされます。
            },
          ),
        );
      }),
    );
  }
}
