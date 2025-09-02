import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/common_sns_model.dart';
import 'package:flutter_asakusa_bakery_store/model/detail_model.dart';
import 'package:flutter_asakusa_bakery_store/model/post_code_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';

class LatLng {
  final double lat, lng;
  LatLng(this.lat, this.lng);
}

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

  /// 食事スペースはありか？
  RxString isThereDiningSpace = "イートインスペース".obs;

  /// 食事スペースのデータはありか？
  List<String> isThereDiningSpaceData = ["なし", "あり"];

  /// 本日から予約可能日数TO
  RxString bookingDayMax = '本日から予約可能日数TO'.obs;

  /// 日数
  RxList days = [].obs;
  RxList daysNotHave0 = [].obs;

  /// 本日から予約可能日数FROM
  RxString reservationsAreClosedDay = '本日から予約可能日数FROM'.obs;

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
  RxList<CommonSnsModel> commonSns = <CommonSnsModel>[].obs;

  /// SNS
  RxList snsData = [].obs;
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

  Future<LatLng?> getCode(String address) async {
    const apiKey = 'AIzaSyDnOhiEUGWv6nsa3LarOHS0NQcF66IHuzE';
    final dio = Dio();

    try {
      final res = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'address': address,
          'language': 'ja',
          'key': apiKey,
        },
      );
      if (res.data['status'] == 'OK' && res.data['results'].isNotEmpty) {
        final loc = res.data['results'][0]['geometry']['location'];
        return LatLng(loc['lat'], loc['lng']);
      }
    } on DioException catch (e) {
      print('Dio error: $e');
    }
    return null;
  }

  getCommonSns() async {
    await backEndRepository.doGet(
      Constant.sns,
      successRequest: (result) {
        commonSns.clear();
        snsData.clear();
        if (result["data"] != null) {
          for (var data in result["data"]) {
            commonSns.add(CommonSnsModel.fromJson(data));
          }
        }
        if (commonSns.isNotEmpty) {
          for (var data in commonSns) {
            snsData.add(data.value);
          }
        }
      },
    );
  }

  getDetailData() async {
    await backEndRepository.doGet(
      '${Constant.detail}?merchantId=${Global.merchantId}',
      successRequest: (result) {
        if (result["data"] != null) {
          detailModel.value = DetailModel.fromJson(result["data"] ?? {});
          storeNameController.text = detailModel.value!.merchantName;
          storeDescriptionController.text =
              detailModel.value!.merchantDescription;
          postalCodeController.text = detailModel.value!.postcode;
          provinceController.text = detailModel.value!.prefecturesCodeName;
          prefecturesCode.value = detailModel.value!.prefectures;
          cityController.text = detailModel.value!.municipalities;
          streetController.text = detailModel.value!.streetAddress;
          addressController.text = detailModel.value!.building;
          phoneController.text = detailModel.value!.phoneNumber;
          isThereDiningSpace.value = detailModel.value!.eatingArea == ""
              ? ""
              : detailModel.value!.eatingArea == "0"
                  ? isThereDiningSpaceData[0]
                  : isThereDiningSpaceData[1];
          bookingDayMax.value = detailModel.value!.approvalDays == 0
              ? "本日から予約可能日数TO"
              : detailModel.value!.approvalDays.toString();
          reservationsAreClosedDay.value = detailModel.value!.deadLineDays == 0
              ? "本日から予約可能日数FROM"
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
              : commonSns
                      .firstWhere(
                          (e) => '${e.code}' == detailModel.value?.snsType1)
                      .value ??
                  'SNS1';
          sns2.value = detailModel.value!.snsType2 == ""
              ? "SNS2"
              : commonSns
                      .firstWhere(
                          (e) => '${e.code}' == detailModel.value?.snsType2)
                      .value ??
                  'SNS2';
          sns3.value = detailModel.value!.snsType3 == ""
              ? "SNS3"
              : commonSns
                      .firstWhere(
                          (e) => '${e.code}' == detailModel.value?.snsType3)
                      .value ??
                  'SNS3';
          sns4.value = detailModel.value!.snsType4 == ""
              ? "SNS4"
              : commonSns
                      .firstWhere(
                          (e) => '${e.code}' == detailModel.value?.snsType4)
                      .value ??
                  'SNS4';
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
          if (detailModel.value!.files.isNotEmpty) {
            for (var data in detailModel.value!.files) {
              assetsImg.add(
                  '${Constant.picture_url}${data.filePath}' '${data.fileName}');
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

  updateDetailData(LatLng loc) async {
    List fixedHoliday = [];
    if (selected.isNotEmpty) {
      for (int i = 0; i < selected.length; i++) {
        if (selected[i].value) {
          fixedHoliday.add("${i + 1}");
        }
      }
    }

    List specialRestDayList = [];
    if (selectedDates.isNotEmpty) {
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
      "latitude": loc.lat,
      "longitude": loc.lng,
      "businessHoursBegin": startTime.value == "開始時間" ? "" : startTime.value,
      "businessHoursEnd": endTime.value == "終了時間" ? "" : endTime.value,
      "fixedHoliday": fixedHoliday,
      "specialRestDay": "",
      "eatingArea": isThereDiningSpace.value == "イートインスペース"
          ? ""
          : (isThereDiningSpace.value == "なし" ? "0" : "1"),
      "postcode": postalCodeController.text,
      "prefecturesCode": prefecturesCode.value,
      "municipalities": cityController.text,
      "streetAddress": streetController.text,
      "building": addressController.text,
      "snsType1": sns1.value == "SNS1"
          ? ""
          : commonSns.firstWhere((e) => '${e.value}' == sns1.value).code ?? '',
      "snsType2": sns2.value == "SNS2"
          ? ""
          : commonSns.firstWhere((e) => '${e.value}' == sns2.value).code ?? '',
      "snsType3": sns3.value == "SNS3"
          ? ""
          : commonSns.firstWhere((e) => '${e.value}' == sns3.value).code ?? '',
      "snsType4": sns4.value == "SNS4"
          ? ""
          : commonSns.firstWhere((e) => '${e.value}' == sns4.value).code ?? '',
      "snsLink1": linkController1.text,
      "snsLink2": linkController2.text,
      "snsLink3": linkController3.text,
      "snsLink4": linkController4.text,
      "businessStatus": "",
      "storeHomepageLink": homeController.text,
      "deliveryFlag": "",
      "deadLineDays": reservationsAreClosedDay.value == "本日から予約可能日数FROM"
          ? ""
          : reservationsAreClosedDay.value,
      "approvalDays":
          bookingDayMax.value == "本日から予約可能日数TO" ? "" : bookingDayMax.value,
      "deadLineTime":
          appointmentTime.value == "予約締切時間" ? "" : appointmentTime.value,
      "email": "",
      "customerOrderLimit": orderAmountMaxController.text,
      "customerDailyOrderLimit": dailyOrderAmountMaxController.text,
      "revItemCountLimit": productNumberMaxController.text,
      "revAmountLimit": productAmountMaxController.text,
      "fileIdList": fileIdList,
      "specialRestDayList": specialRestDayList,
      "pointRate": pointsRatioController.text
    };
    print("params ------------------------ $params");
    await backEndRepository.doPut(
      Constant.detail,
      params: params,
      successRequest: (result) {
        customWidget.toastShowNotIcon("正常に保存しました。");
      },
    );
  }
}
