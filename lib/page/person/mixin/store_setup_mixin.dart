import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/model/detail_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:photo_manager/photo_manager.dart';

mixin StoreSetupMixin<T extends StatefulWidget> on State<T> {
  /// 店名
  TextEditingController storeNameController = TextEditingController();

  /// 店舗説明
  TextEditingController storeDescriptionController = TextEditingController();
  FocusNode storeDescriptionFocusNode = FocusNode();

  /// 郵便番号
  TextEditingController postalCodeController = TextEditingController();

  /// 省
  TextEditingController provinceController = TextEditingController();

  /// 市
  TextEditingController cityController = TextEditingController();

  /// 街道
  TextEditingController streetController = TextEditingController();

  /// 住所
  TextEditingController addressController = TextEditingController();

  /// 電話番号
  TextEditingController phoneController = TextEditingController();

  /// 顧客の注文金額上限
  TextEditingController orderAmountMaxController = TextEditingController();

  /// 顧客の日次注文金額上限
  TextEditingController dailyOrderAmountMaxController = TextEditingController();

  /// 店舗ごとの毎日の予約商品の上限
  TextEditingController productNumberMaxController = TextEditingController();

  /// 店舗ごとの毎日の予約金額上限
  TextEditingController productAmountMaxController = TextEditingController();

  /// 積分比率
  TextEditingController pointsRatioController = TextEditingController();
  TextEditingController linkController1 = TextEditingController();
  TextEditingController linkController2 = TextEditingController();
  TextEditingController linkController3 = TextEditingController();
  TextEditingController linkController4 = TextEditingController();

  /// ホームページ
  TextEditingController homeController = TextEditingController();

  /// 食事スペースはありますか？
  RxString isThereDiningSpace = "イ-トインスペ-スあり".obs;

  /// 食事スペースのデータはありますか？
  List<String> isThereDiningSpaceData = ["なし", "あります"];

  /// 最大予約可能日数
  RxString bookingDayMax = '最大予約可能日数'.obs;

  /// 日数
  RxList days = [].obs;

  /// 予約締切日数
  RxString reservationsAreClosedDay = '予約締切日数'.obs;

  /// 予約締切時間
  RxString appointmentTime = '予約締切時間'.obs;

  /// 時間-時
  RxList timeHour = [].obs;

  /// 時間-分
  List<String> timeMinute = ["00", "30"];

  /// 開始時間
  RxString startTime = '開始時間'.obs;

  /// 終了時間
  RxString endTime = '終了時間'.obs;

  /// 休息日のデータ
  List restDays = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", "日曜日"];

  /// 休息日データの選択データ
  List<bool> selected = [];

  /// 特別休暇
  RxString specialHolidays = '選択済み'.obs;
  final RxString date = ''.obs;

  /// SNS
  List snsData = ["Instagram", "X", "LINE", "Facebook"];
  RxString sns1 = "SNS1".obs;
  RxString sns2 = "SNS2".obs;
  RxString sns3 = "SNS3".obs;
  RxString sns4 = "SNS4".obs;

  List<String> mOrderDates = ["2025-07-08", "2025-07-09", "2025-07-10"];

  RxList<AssetEntity> image = <AssetEntity>[].obs;
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  final detailModel = Rxn<DetailModel>();

  getDetailData() async {
    await backEndRepository.doGet(
      Constant.detail,
      successRequest: (result) {
        if (result["data"] != null) {
          detailModel.value = DetailModel.fromJson(result["data"] ?? {});
          storeNameController.text = detailModel.value!.merchantName;
          storeDescriptionController.text =
              detailModel.value!.merchantDescription;
          postalCodeController.text = detailModel.value!.postcode;
          provinceController.text = detailModel.value!.prefecturesCodeName;
          cityController.text = detailModel.value!.municipalities;
          streetController.text = detailModel.value!.streetAddress;
          addressController.text = detailModel.value!.building;
          phoneController.text = detailModel.value!.phoneNumber;
          isThereDiningSpace.value = detailModel.value!.eatingArea == "0"
              ? ""
              : detailModel.value!.eatingArea;
          bookingDayMax.value = detailModel.value!.approvalDays == 0
              ? ""
              : detailModel.value!.approvalDays.toString();
          reservationsAreClosedDay.value = detailModel.value!.deadLineDays == 0
              ? ""
              : detailModel.value!.deadLineDays.toString();
          appointmentTime.value = detailModel.value!.deadLineTime.hour == 0 &&
                  detailModel.value!.deadLineTime.minute == 0 &&
                  detailModel.value!.deadLineTime.second == 0 &&
                  detailModel.value!.deadLineTime.nano == 0
              ? ""
              : '${detailModel.value!.deadLineTime.hour}：${detailModel.value!.deadLineTime.minute}';
          startTime.value = detailModel.value!.businessHoursBegin.hour == 0 &&
                  detailModel.value!.businessHoursBegin.minute == 0 &&
                  detailModel.value!.businessHoursBegin.second == 0 &&
                  detailModel.value!.businessHoursBegin.nano == 0
              ? ""
              : '${detailModel.value!.businessHoursBegin.hour}：${detailModel.value!.businessHoursBegin.minute}';
          endTime.value = detailModel.value!.businessHoursEnd.hour == 0 &&
                  detailModel.value!.businessHoursEnd.minute == 0 &&
                  detailModel.value!.businessHoursEnd.second == 0 &&
                  detailModel.value!.businessHoursEnd.nano == 0
              ? ""
              : '${detailModel.value!.businessHoursEnd.hour}：${detailModel.value!.businessHoursEnd.minute}';
          // orderAmountMaxController.text =
          //     detailModel.value!.customerDailyOrderLimit == 0
          //         ? ""
          //         : detailModel.value!.customerDailyOrderLimit.toString();
          // dailyOrderAmountMaxController.text = detailModel.value!.customerDailyOrderLimit == 0
          //         ? ""
          //         : detailModel.value!.customerDailyOrderLimit.toString();
          productNumberMaxController.text = detailModel.value!.revItemCountLimit==0?"":detailModel.value!.revItemCountLimit.toString();
          productAmountMaxController.text = detailModel.value!.revAmountLimit==0?"":detailModel.value!.revAmountLimit.toString();
          pointsRatioController.text = detailModel.value!.pointRate == 0?"":detailModel.value!.pointRate.toString();
          sns1.value = detailModel.value!.snsType1;
          sns2.value = detailModel.value!.snsType2;
          sns3.value = detailModel.value!.snsType3;
          sns4.value = detailModel.value!.snsType4;
          linkController1.text = detailModel.value!.snsLink1;
          linkController2.text = detailModel.value!.snsLink2;
          linkController3.text = detailModel.value!.snsLink3;
          linkController4.text = detailModel.value!.snsLink4;
        }
      },
    );
  }
}
