import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/detail_model.dart';
import 'package:flutter_asakusa_bakery_store/model/post_code_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
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
  RxString isThereDiningSpace = "イートインスペースあり".obs;

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
  RxList<RxBool> selected = <RxBool>[].obs;

  /// 特別休暇
  RxString specialHolidays = '選択してください'.obs;
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

  RxList<String> fileIdList = <String>[].obs;

  RxString prefecturesCode = "".obs;

  RxList<String> assetsImg = <String>[].obs;

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
              ? "イートインスペースあり"
              : detailModel.value!.eatingArea;
          bookingDayMax.value = detailModel.value!.approvalDays == 0
              ? "最大予約可能日数"
              : detailModel.value!.approvalDays.toString();
          reservationsAreClosedDay.value = detailModel.value!.deadLineDays == 0
              ? "予約締切日数"
              : detailModel.value!.deadLineDays.toString();
          appointmentTime.value = detailModel.value!.deadLineTime == ""
              ? "予約締切時間"
              : detailModel.value!.deadLineTime;
          startTime.value = detailModel.value!.businessHoursBegin == ""
              ? "開始時間"
              : detailModel.value!.businessHoursBegin;
          endTime.value = detailModel.value!.businessHoursEnd == ""
              ? "終了時間"
              : detailModel.value!.businessHoursEnd;
          orderAmountMaxController.text =
              detailModel.value!.customerOrderLimit == 0
                  ? ""
                  : detailModel.value!.customerOrderLimit.toString();
          dailyOrderAmountMaxController.text =
              detailModel.value!.customerDailyOrderLimit == 0
                  ? ""
                  : detailModel.value!.customerDailyOrderLimit.toString();
          productNumberMaxController.text =
              detailModel.value!.revItemCountLimit == 0
                  ? ""
                  : detailModel.value!.revItemCountLimit.toString();
          productAmountMaxController.text =
              detailModel.value!.revAmountLimit == 0
                  ? ""
                  : detailModel.value!.revAmountLimit.toString();
          pointsRatioController.text = detailModel.value!.pointRate == ""
              ? ""
              : detailModel.value!.pointRate.toString();
          sns1.value = detailModel.value!.snsType1 == ""
              ? "SNS1"
              : detailModel.value!.snsType1;
          sns2.value = detailModel.value!.snsType2 == ""
              ? "SNS2"
              : detailModel.value!.snsType2;
          sns3.value = detailModel.value!.snsType3 == ""
              ? "SNS3"
              : detailModel.value!.snsType3;
          sns4.value = detailModel.value!.snsType4 == ""
              ? "SNS4"
              : detailModel.value!.snsType4;
          linkController1.text = detailModel.value!.snsLink1;
          linkController2.text = detailModel.value!.snsLink2;
          linkController3.text = detailModel.value!.snsLink3;
          linkController4.text = detailModel.value!.snsLink4;
          homeController.text = detailModel.value!.storeHomepageLink;
          if (detailModel.value!.fixedHoliday.isNotEmpty) {
            for (var i = 0; i < detailModel.value!.fixedHoliday.length; i++) {
              String item = detailModel.value!.fixedHoliday[i];
              selected[int.parse(item) - 1].value = true;
            }
          }
          if (detailModel.value!.specialRestDayList.isNotEmpty) {
            selectedDates.clear();
            specialHolidays.value = "選択済み";
            for (var item in detailModel.value!.specialRestDayList) {
              selectedDates.add(DateTime.parse(item));
            }
          }
          assetsImg.clear();
          if(detailModel.value!.files.isNotEmpty){
            for (var data in detailModel.value!.files) {
              assetsImg.add('${Constant.picture_url}${data.filePath}''${data.fileName}');
              fileIdList.add(data.id);
            }
          }
        }
      },
    );
  }

  getPostCode() async {
    if (postalCodeController.text == "") return;
    await backEndRepository.doGet(
      "${Constant.base_url}common/postcode/${postalCodeController.text}",
      successRequest: (result) {
        if (result["data"] != null) {
          PostCodeModel postCodeModel = PostCodeModel.fromJson(result["data"]);
          provinceController.text = postCodeModel.prefectures!;
          cityController.text = postCodeModel.municipalities!;
          prefecturesCode.value = '${postCodeModel.prefecturesCode!}';
        }
      },
    );
  }

  updateDetailData() async {
    List fixedHoliday = [];
    if(selected.isNotEmpty){
      for (int i = 0;i<selected.length;i++) {
        if(selected[i].value){
          fixedHoliday.add("${i+1}");
        }
      }
    }

    List specialRestDayList = [];
    if(selectedDates.isNotEmpty){
      for (var data in selectedDates) {
        specialRestDayList.add(DateFormat('yyyy-MM-dd').format(data));
      }
    }
    Map<String, dynamic> params = {
      "createBy": "",
      "createTime": "",
      "updateBy": "",
      "updateTime": "",
      "params": {},
      "pageNum": 0,
      "pageSize": 0,
      "id": detailModel.value!.id,
      "merchantName": storeNameController.text,
      "merchantDescription": storeDescriptionController.text,
      "phoneNumber": phoneController.text,
      "status": "",
      "longitudeLatitude": "",
      "basicInformation": "",
      "remark": "",
      "loginIp": "",
      "loginDate": "",
      "businessHoursBegin": startTime.value == "開始時間"?"":startTime.value,
      "businessHoursEnd": endTime.value == "終了時間"?"":endTime.value,
      "fixedHoliday": fixedHoliday,
      "specialRestDay": "",
      "eatingArea": isThereDiningSpace.value == "イートインスペースあり"?"":isThereDiningSpace.value,
      "postcode": postalCodeController.text,
      "prefecturesCode": prefecturesCode.value,
      "municipalities": "",
      "streetAddress": streetController.text,
      "building": addressController.text,
      "snsType1": sns1.value == "SNS1"?"":sns1.value,
      "snsType2": sns2.value == "SNS2"?"":sns2.value,
      "snsType3": sns3.value == "SNS3"?"":sns3.value,
      "snsType4": sns4.value == "SNS4"?"":sns4.value,
      "snsLink1": linkController1.text,
      "snsLink2": linkController2.text,
      "snsLink3": linkController3.text,
      "snsLink4": linkController4.text,
      "businessStatus": "",
      "storeHomepageLink": homeController.text,
      "deliveryFlag": "",
      "deadLineDays": reservationsAreClosedDay.value == "予約締切日数"?"":reservationsAreClosedDay.value,
      "approvalDays": bookingDayMax.value == "最大予約可能日数"?"":bookingDayMax.value,
      "deadLineTime": appointmentTime.value == "予約締切時間"?"":appointmentTime.value,
      "email": "",
      "customerOrderLimit": orderAmountMaxController.text,
      "customerDailyOrderLimit": dailyOrderAmountMaxController.text,
      "revItemCountLimit": productNumberMaxController.text,
      "revAmountLimit": productAmountMaxController.text,
      "fileIdList": fileIdList,
      "specialRestDayList": specialRestDayList,
      "pointRate":pointsRatioController.text // 比率
    };
    print("params -------------- $params");
    await backEndRepository.doPut(
      Constant.detail,
      params: params,
      successRequest: (result) {
        customWidget.toastShowNotIcon("情報を補完してください");
      },
    );
  }
}
