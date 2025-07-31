import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/japanese_text_delegate.dart';
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

  // 2. 用来保存选中的图片
  File? imageFile;

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

  /// 选择图片
  Widget selectImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(image.length < 3)
          GestureDetector(
            onTap: () async {
              await customWidget.pickImageWithPermission(context, () async {
                // 2. 打开选择器（日语 UI）
                final List<AssetEntity>? result = await AssetPicker.pickAssets(
                  context,
                  pickerConfig: AssetPickerConfig(
                    maxAssets: 1, // 最多选 9 张
                    requestType: RequestType.image, // 只选图片
                    textDelegate: JapaneseTextDelegate(), // 日语界面
                  ),
                );

                // 3. 更新列表
                if (result != null) {
                  setState(() {
                    if(image.isEmpty){
                      image.assignAll(result);
                    }else {
                      if(image.length >= 3){
                        return;
                      }else{
                        image.addAll(result);
                      }
                    }
                    // image = <AssetEntity>[].obs;
                    
                  });
                }
              });
            },
            child: Container(
              width: 98,
              height: 98,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 7, right: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: CustomColor.blackD)),
              child: customWidget.setAssetsImg("icon_add.png",
                  width: 32, height: 32),
            ),
          ),
          SizedBox(
            width:image.length == 3?Get.width-30: Get.width- ((Get.width-315-30)/2)-105-30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(image.length, (index) {
                return Stack(
                  children: [
                    Container(
                        width: 105,
                        height: 105,
                        padding: const EdgeInsets.only(top: 7, right: 7),
                        child: Obx(() {
                          return image.isEmpty
                              ? const Icon(Icons.image,
                                  size: 100, color: Colors.grey)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: AssetEntityImage(
                                    image[index],
                                    width: 98,
                                    height: 98,
                                    fit: BoxFit.cover,
                                  ),
                                );
                        })),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              image.removeAt(index);
                            });
                          },
                          child: customWidget.setAssetsImg("icon_clear.png",
                              width: 20, height: 20),
                        ))
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  /// 标题文字(isRequired:是否为必填)
  Widget titleWidget(String text, bool isRequired) {
    return Row(
      children: [
        customWidget.setTextOverflow(text,
            margin: EdgeInsets.fromLTRB(15, 15, isRequired ? 10 : 15, 10),
            fontSize: 13,
            color: CustomColor.black_3),
        isRequired
            ? Container(
                width: 30,
                height: 16,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 2),
                margin: const EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColor.redE84F43),
                child: customWidget.setTextOverflow("必須",
                    fontSize: 10, color: CustomColor.white),
              )
            : Container()
      ],
    );
  }

  /// Picker选择
  Widget pickerSelected(String text, Function fun,
      {double width = double.infinity}) {
    return customWidget.setCardForHeight(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 41,
        radius: 5,
        borderWidth: 0.5,
        width: width,
        onTap: fun,
        color: CustomColor.bg,
        borderColor: CustomColor.blackD,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customWidget.setText(text),
            customWidget.setAssetsImg("cus_textfield_select@3x.png",
                width: 24, height: 24)
          ],
        ));
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
        titleWidget("店舗画像(3枚)", false),
        selectImage(),
        titleWidget("店舗名", true),
        ClearableTextField(
            controller: storeNameController,
            hintText: '店舗名を入カしてください',
            readOnly: false),
        titleWidget("一言の店舗説明(20文字)", false),
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
        titleWidget("郵便番号", true),
        ClearableTextField(
            controller: postalCodeController,
            hintText: '郵便番号を入カしてください',
            readOnly: false),
        titleWidget("店舗住所", true),
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
        titleWidget("電話番号", false),
        ClearableTextField(
            controller: phoneController, hintText: '電話番号', readOnly: false),
        titleWidget("イ-トインスペ-スあり", true),
        Obx(
          () => pickerSelected(isThereDiningSpace.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [isThereDiningSpaceData],
              initialIndex: [0],
              title: '飲食工リアがあるかどうか',
              confirm: (list) => isThereDiningSpace.value = list[0],
            );
          }),
        ),
        titleWidget("最大予約可能日数", true),
        Obx(
          () => pickerSelected(bookingDayMax.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => bookingDayMax.value = list[0],
            );
          }),
        ),
        titleWidget("予約締切日数", true),
        Obx(
          () => pickerSelected(reservationsAreClosedDay.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => reservationsAreClosedDay.value = list[0],
            );
          }),
        ),
        titleWidget("予約締切日数", true),
        Obx(
          () => pickerSelected(reservationsAreClosedDay.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [days.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '日数を選択してください',
              confirm: (list) => reservationsAreClosedDay.value = list[0],
            );
          }),
        ),
        titleWidget("予約締切日数", true),
        Obx(
          () => pickerSelected(appointmentTime.value, () {
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
        titleWidget("営業時間", true),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => pickerSelected(startTime.value, () {
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
              () => pickerSelected(endTime.value, () {
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
        titleWidget("定休日", false),
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
        titleWidget("特别休日", false),
        Obx(
          () => pickerSelected(specialHolidays.value, () => showCalendar()),
        ),
        titleWidget("顧客每回注文金额上限", false),
        ClearableTextField(
            controller: orderAmountMaxController,
            hintText: '顧客每回注文金額上限を入力してください',
            readOnly: false),
        titleWidget("顧客每日注文金額上限", false),
        ClearableTextField(
            controller: dailyOrderAmountMaxController,
            hintText: '顧客每日注文金額上限を入力してください',
            readOnly: false),
        titleWidget("店舗每日予約商品数上限", false),
        ClearableTextField(
            controller: productNumberMaxController,
            hintText: '店舗每日予約商品数上限を入カしてください',
            readOnly: false),
        titleWidget("店舗每日予約金額上限", false),
        ClearableTextField(
            controller: productAmountMaxController,
            hintText: '店舗每日予約金额上限を入カしてく尤さい',
            readOnly: false),
        titleWidget("ポイント比率", false),
        ClearableTextField(
            controller: pointsRatioController,
            hintText: 'ポイント比率を入カしてィださい',
            readOnly: false),
        titleWidget("SNS1", false),
        Obx(
          () => pickerSelected(sns1.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns1.value = list[0],
            );
          }),
        ),
        titleWidget("リンク1", false),
        ClearableTextField(
            controller: linkController1, hintText: 'リンク', readOnly: false),
        titleWidget("SNS2", false),
        Obx(
          () => pickerSelected(sns1.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns1.value = list[0],
            );
          }),
        ),
        titleWidget("リンク2", false),
        ClearableTextField(
            controller: linkController2, hintText: 'リンク', readOnly: false),
        titleWidget("SNS3", false),
        Obx(
          () => pickerSelected(sns3.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns3.value = list[0],
            );
          }),
        ),
        titleWidget("リンク3", false),
        ClearableTextField(
            controller: linkController3, hintText: 'リンク', readOnly: false),
        titleWidget("SNS4", false),
        Obx(
          () => pickerSelected(sns4.value, () {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [snsData.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: 'sns',
              confirm: (list) => sns4.value = list[0],
            );
          }),
        ),
        titleWidget("リンク4", false),
        ClearableTextField(
            controller: linkController4, hintText: 'リンク', readOnly: false),
        titleWidget("ホ-ムペ-ジ", false),
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
          Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                decoration: BoxDecoration(color: CustomColor.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // 阴影颜色
                    blurRadius: 8, // 模糊半径
                    spreadRadius: 0, // 扩散半径（0 表示不放大）
                    offset: const Offset(0, 4), //  正 Y 值：向下偏移
                  ),
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    customWidget.setCupertinoButton("キャン乜ル",
                        minimumSize: (Get.width - 50) / 2,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.black_9,
                        onPressed: () {}),
                    customWidget.setCupertinoButton("保存",
                        minimumSize: (Get.width - 50) / 2,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.redE8,
                        onPressed: () {})
                  ],
                ),
              ))
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
