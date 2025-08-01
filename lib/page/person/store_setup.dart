
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/calendar/calendar_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/calendar/models/date_model.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 店铺设置
class StoreSetup extends StatefulWidget {
  const StoreSetup({super.key});

  @override
  State<StoreSetup> createState() => _StoreSetupState();
}

class _StoreSetupState extends State<StoreSetup> {
  /// 店铺名
  TextEditingController storeNameController = TextEditingController();

  /// 店铺说明
  TextEditingController storeDescriptionController = TextEditingController();
  FocusNode storeDescriptionFocusNode = FocusNode();

  /// 邮编号码
  TextEditingController postalCodeController = TextEditingController();

  /// 省
  TextEditingController provinceController = TextEditingController();

  /// 市
  TextEditingController cityController = TextEditingController();

  /// 街道
  TextEditingController streetController = TextEditingController();

  /// 地址
  TextEditingController addressController = TextEditingController();

  /// 电话号码
  TextEditingController phoneController = TextEditingController();

  /// 顾客每次订单金额上限
  TextEditingController orderAmountMaxController = TextEditingController();

  /// 客户每日订单金额上限
  TextEditingController dailyOrderAmountMaxController = TextEditingController();

  /// 店铺每日预约商品数上限
  TextEditingController productNumberMaxController = TextEditingController();

  /// 店铺每日预约金额上限
  TextEditingController productAmountMaxController = TextEditingController();

  /// 积分比例
  TextEditingController pointsRatioController = TextEditingController();

  /// 链接
  TextEditingController linkController1 = TextEditingController();

  /// 链接
  TextEditingController linkController2 = TextEditingController();

  /// 链接
  TextEditingController linkController3 = TextEditingController();

  /// 链接
  TextEditingController linkController4 = TextEditingController();

  /// 主页
  TextEditingController homeController = TextEditingController();

  /// 是否有用餐空间
  RxString isThereDiningSpace = "なし".obs;

  /// 是否有用餐空间数据
  List<String> isThereDiningSpaceData = ["なし", "あります"];

  /// 最多预约天数
  RxString bookingDayMax = '0'.obs;

  /// 天数
  RxList days = [].obs;

  /// 预约截至天数
  RxString reservationsAreClosedDay = '0'.obs;

  /// 预约时间
  RxString appointmentTime = '19:00:00'.obs;

  /// 时间-时
  RxList timeHour = [].obs;

  /// 时间-分
  List<String> timeMinute = ["00", "30"];

  /// 开始时间
  RxString startTime = '10:00:00'.obs;

  /// 结束时间
  RxString endTime = '18:00:00'.obs;

  /// 休息日数据
  List restDays = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];

  /// 休息日数据选择数据
  List<bool> selected = [];

  /// 特别休日
  RxString specialHolidays = '選択済み'.obs;
  final RxString _date = ''.obs;

  /// SNS数据
  List snsData = ["Instagram", "X", "LINE", "Facebook"];
  RxString sns1 = "Instagram".obs;
  RxString sns2 = "Instagram".obs;
  RxString sns3 = "Instagram".obs;
  RxString sns4 = "Instagram".obs;

  /// 不可选日期
  List<String> mData = ["1", "2", "3"];
  List<String> mOrderDates = ["2025-07-04", "2025-07-05", "2025-07-06"];

  RxList<AssetEntity> image = <AssetEntity>[].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 为天数添加0~30的数据
    days.assignAll(List.generate(31, (i) => "$i"));
    timeHour.assignAll(
      List.generate(24, (i) => i.toString().padLeft(2, '0')),
    );
    selected = List<bool>.generate(restDays.length,
        (index) => (index >= restDays.length - 2 ? true : false));
    final today = DateTime.now();
    _date.value = DateFormat('yyyy-MM-dd').format(today);
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

  /// 主要页面展示
  Widget mainPageShow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 1,
          color: CustomColor.bg,
        ),
        infoWidget.titleWidget("店舗画像(3枚)", false),
        infoWidget.selectImage(image,context,3),
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
            readOnly: false),
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
        infoWidget.titleWidget("イ-トインスペ-スあり", true),
        Obx(
          () => infoWidget.pickerSelected(isThereDiningSpace.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [isThereDiningSpaceData],
              initialIndex: [0],
              title: '飲食工リアがあるかどうか',
              confirm: (list) => isThereDiningSpace.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("最大予約可能日数", true),
        Obx(
          () => infoWidget.pickerSelected(bookingDayMax.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => bookingDayMax.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("予約締切日数", true),
        Obx(
          () => infoWidget.pickerSelected(reservationsAreClosedDay.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => reservationsAreClosedDay.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("予約締切日数", true),
        Obx(
          () => infoWidget.pickerSelected(reservationsAreClosedDay.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => reservationsAreClosedDay.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("予約締切日数", true),
        Obx(
          () => infoWidget.pickerSelected(appointmentTime.value, () {
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
          }),
        ),
        infoWidget.titleWidget("営業時間", true),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => infoWidget.pickerSelected(startTime.value, () {
                customWidget.showCustomizationPicker(
                  context,
                  columnsData: [
                    timeHour.map((e) => e.toString()).toList(),
                    timeMinute
                  ],
                  initialIndex: [0, 0],
                  title: '時間を選択してください',
                  confirm: (list) => startTime.value = '${list[0]}:${list[1]}',
                );
              }, width: (Get.width - 75) / 2),
            ),
            customWidget.setText("~"),
            Obx(
              () => infoWidget.pickerSelected(endTime.value, () {
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
              }, width: (Get.width - 75) / 2),
            ),
          ],
        ),
        infoWidget.titleWidget("定休日", false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.count(
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
                    selected[index] ? CustomColor.white : CustomColor.redE8,
                backgroundColor:
                    selected[index] ? CustomColor.redE8 : CustomColor.white,
                onPressed: () {
                  setState(() {
                    selected[index] = !selected[index];
                  });
                },
              ),
            ),
          ),
        ),
        infoWidget.titleWidget("特别休日", false),
        Obx(
          () => infoWidget.pickerSelected(specialHolidays.value, () => showCalendar()),
        ),
        infoWidget.titleWidget("顧客每回注文金额上限", false),
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
        Obx(
          () => infoWidget.pickerSelected(sns1.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns1.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("リンク1", false),
        ClearableTextField(
            controller: linkController1, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS2", false),
        Obx(
          () => infoWidget.pickerSelected(sns1.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns1.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("リンク2", false),
        ClearableTextField(
            controller: linkController2, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS3", false),
        Obx(
          () => infoWidget.pickerSelected(sns3.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns3.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("リンク3", false),
        ClearableTextField(
            controller: linkController3, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("SNS4", false),
        Obx(
          () => infoWidget.pickerSelected(sns4.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns4.value = list[0],
            );
          }),
        ),
        infoWidget.titleWidget("リンク4", false),
        ClearableTextField(
            controller: linkController4, hintText: 'リンク', readOnly: false),
        infoWidget.titleWidget("ホ-ムペ-ジ", false),
        ClearableTextField(
            controller: homeController, hintText: 'ホ-ムペ-ジ', readOnly: false),
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
          infoWidget.bottomBtn("キャン乜ル", "保存",true, (){}, (){})
        ],
      ),
    );
  }

  showCalendar() {
    if (_date.value.isEmpty) {
      _date.value = '2025-01-01'; // 默认日期格式
    }
    customWidget.showCustomNoTitleDialog(context,
        confirm: () => {print("_data.value ----------------- ${_date.value}")},
        child: StatefulBuilder(builder: (_, state) {
          return SizedBox(
              height: 390,
              width: Get.width,
              child: CustomCalendarViewer(
                  initDate: _date.value,
                  calendarType: CustomCalendarType.date,
                  calendarStyle: CustomCalendarStyle.normal,
                  animateDirection: CustomCalendarAnimatedDirection.horizontal,
                  movingArrowSize: 15,
                  local: "jp",
                  showCurrentDayBorder: true,
                  mDates: mData,
                  mOrderDates: mOrderDates,
                  spaceBetweenMovingArrow: 40,
                  closedDatesColor: Colors.white.withOpacity(0.7),
                  showHeader: true,
                  daysMargin: const EdgeInsets.only(
                      left: 10, right: 10, top: 0, bottom: 0),
                  showBorderAfterDayHeader: false,
                  headerAlignment: MainAxisAlignment.spaceEvenly,
                  calendarStartDay: CustomCalendarStartDay.sunday,
                  activeColor: CustomColor.redE8,
                  currentDayBorder: Border.all(color: CustomColor.redE8),
                  onDatesUpdated: (date) =>
                      [Date(date: DateTime.parse(_date.value))],
                  onChange: (year, month) =>
                      {print("year ----- $year   month ------ $month")},
                  onDayTapped: (date) =>
                      _date.value = date.toString().substring(0, 10)));
        }));
  }
}
