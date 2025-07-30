import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 店铺设置
class StoreSetup extends StatefulWidget {
  const StoreSetup({super.key});

  @override
  State<StoreSetup> createState() => _StoreSetupState();
}

class _StoreSetupState extends State<StoreSetup> {
  /// 店铺名
  TextEditingController? storeNameController = TextEditingController();

  /// 店铺说明
  TextEditingController? storeDescriptionController = TextEditingController();

  /// 邮编号码
  TextEditingController? postalCodeController = TextEditingController();

  /// 省
  TextEditingController? provinceController = TextEditingController();

  /// 市
  TextEditingController? cityController = TextEditingController();

  /// 街道
  TextEditingController? streetController = TextEditingController();

  /// 地址
  TextEditingController? addressController = TextEditingController();

  /// 电话号码
  TextEditingController? phoneController = TextEditingController();

  /// 顾客每次订单金额上限
  TextEditingController? orderAmountMaxController = TextEditingController();

  /// 客户每日订单金额上限
  TextEditingController? dailyOrderAmountMaxController =
      TextEditingController();

  /// 店铺每日预约商品数上限
  TextEditingController? productNumberMaxController = TextEditingController();

  /// 店铺每日预约金额上限
  TextEditingController? productAmountMaxController = TextEditingController();

  /// 积分比例
  TextEditingController? pointsRatioController = TextEditingController();

  /// 链接
  TextEditingController? linkController1 = TextEditingController();

  /// 链接
  TextEditingController? linkController2 = TextEditingController();

  /// 链接
  TextEditingController? linkController3 = TextEditingController();

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 为天数添加0~30的数据
    days.assignAll(List.generate(31, (i) => "$i"));
    timeHour.assignAll(
      List.generate(24, (i) => i.toString().padLeft(2, '0')),
    );
    selected = List<bool>.generate(
        restDays.length, (index) => (index >= restDays.length - 2 ? true : false));
  }

  @override
  void dispose() {
    storeNameController!.dispose();
    storeDescriptionController!.dispose();
    postalCodeController!.dispose();
    provinceController!.dispose();
    cityController!.dispose();
    streetController!.dispose();
    addressController!.dispose();
    phoneController!.dispose();
    orderAmountMaxController!.dispose();
    dailyOrderAmountMaxController!.dispose();
    productNumberMaxController!.dispose();
    productAmountMaxController!.dispose();
    pointsRatioController!.dispose();
    linkController1!.dispose();
    linkController2!.dispose();
    linkController3!.dispose();
    super.dispose();
  }

  /// 选择图片
  Widget selectImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 105,
            height: 105,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: CustomColor.blackD)),
            child: customWidget.setAssetsImg("icon_add.png",
                width: 32, height: 32),
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

  /// 输入框
  Widget textFieldWidget(
      TextEditingController controller, String hintText, bool readOnly) {
    return customWidget.setTextField(controller,
        hintText: hintText,
        circular: 5,
        readOnly: readOnly,
        borderSide: BorderSide(
            color: readOnly
                ? CustomColor.blackD.withOpacity(0.7)
                : CustomColor.blackD,
            width: 0.5),
        margin: const EdgeInsets.symmetric(horizontal: 15));
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 1,
              color: CustomColor.bg,
            ),
            titleWidget("店舗画像(3枚)", false),
            selectImage(),
            titleWidget("店舗名", true),
            textFieldWidget(storeNameController!, '店舗名を入カしてください', false),
            titleWidget("一言の店舗説明(20文字)", false),
            customWidget.setTextField(storeDescriptionController,
                hintText: '店舗名を入カしてください',
                circular: 5,
                maxLines: 5,
                height: 100,
                maxLength: 20,
                top: 10,
                left: 10,
                right: 10,
                borderSide:
                    const BorderSide(color: CustomColor.blackD, width: 0.5),
                margin: const EdgeInsets.symmetric(horizontal: 15)),
            titleWidget("郵便番号", true),
            textFieldWidget(postalCodeController!, '郵便番号を入カしてください', false),
            titleWidget("店舗住所", true),
            textFieldWidget(provinceController!, '都道府県', true),
            textFieldWidget(cityController!, '市区町材', true),
            textFieldWidget(streetController!, '番地', false),
            textFieldWidget(addressController!, '建物名·部屋番号', false),
            titleWidget("電話番号", false),
            textFieldWidget(phoneController!, '電話番号', false),
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
                      confirm: (list) =>
                          startTime.value = '${list[0]}:${list[1]}',
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
                      confirm: (list) =>
                          endTime.value = '${list[0]}:${list[1]}',
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
                    fontColor: selected[index]? CustomColor.white:CustomColor.redE8,
                    backgroundColor:selected[index]?  CustomColor.redE8:CustomColor.white,
                    onPressed: (){
                      setState(() {
                        selected[index] = !selected[index];
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
