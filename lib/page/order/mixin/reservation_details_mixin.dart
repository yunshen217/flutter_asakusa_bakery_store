import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/loading_toast.dart';
import 'package:flutter_asakusa_bakery_store/model/common_search_param_model.dart';
import 'package:flutter_asakusa_bakery_store/model/plans_items_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

mixin ReservationDetailsMixin<T extends StatefulWidget> on State<T> {
  RxString time = "2024-03-21".obs;
  RxBool isPanelVisible = false.obs;
  RxString status = "".obs;
  TextEditingController searchController = TextEditingController();

  /// ボタンがクリックされたかどうか
  RxList<RxBool> siftBtnDataIsSelectes = <RxBool>[].obs;
  // RxString siftBtnDataIsSelectesId = "".obs;

  /// 詳細データリスト
  RxList<PlansItemsModel> detailsData = <PlansItemsModel>[].obs;
  RxList<PlansItemsModel> detailsDataCopy = <PlansItemsModel>[].obs;

  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodeList = <FocusNode>[].obs;
  FocusNode currentFocusNode = FocusNode();

  RxString itemName = "".obs;
  RxList kindIdList = [].obs;

  RxBool isFirstLogin = false.obs;

  RxList<CommonSearchParamModelItemKindList?> commonSearchList =
      <CommonSearchParamModelItemKindList?>[].obs;

  RxList plansCountList = [].obs;

  RxString btnText = "".obs;

  getPlansItems() async {
    Map<String, dynamic> params = {
      "merchantId":Global.merchantId,
      "orderDate": time.value,
      "itemName": itemName.value,
      "kindIdList": kindIdList
    };
    LoadingToast.show(context, "Loading...");
    await backEndRepository.doPost(
      Constant.plansItems,
      params: params,
      successRequest: (result) {
        detailsData.clear();
        detailsDataCopy.clear();
        controllerList.clear();
        focusNodeList.clear();
        LoadingToast.remove();
        if (result["data"] != null) {
          debugPrint("result['data']: ${result['data']}");
          detailsData.addAll(result["data"]
              .map((data) => PlansItemsModel.fromJson(data ?? {}))
              .cast<PlansItemsModel>());
          detailsDataCopy.addAll(result["data"]
              .map((data) => PlansItemsModel.fromJson(data ?? {}))
              .cast<PlansItemsModel>());
          controllerList.assignAll(
            List.generate(detailsData.length, (_) => TextEditingController()),
          );
          focusNodeList.assignAll(
            List.generate(detailsData.length, (_) => FocusNode()),
          );
        }
        
      },
    );
  }

  getPlansReserveStatus() async {
    Map<String, dynamic> params = {"merchantId":Global.merchantId,"rsvDate": time.value};
    await backEndRepository.doPost(
      Constant.plansReserveStatus,
      params: params,
      successRequest: (result) {
        customWidget.toastShowNotIcon("更新しました");
        btnText.value=btnText.value == "予約受付中止"?"予約再開":"予約受付中止";

      },
    );
  }

  getCommonSearchParam() async {
    await backEndRepository.doGet(
      Constant.commonSearchParam,
      successRequest: (result) {
        if (result["data"] != null) {
          commonSearchList.value =
              CommonSearchParamModel.fromJson(result["data"]).itemKindList!;
          siftBtnDataIsSelectes.value = List.generate(commonSearchList.length, (index) => false.obs);
        }
      },
    );
  }

  getPlansCount(BuildContext context) async {
    LoadingToast.show(context, "Loading...");
    await backEndRepository.doPut(
      Constant.plansCount,
      isMapData: false,
      paramList: plansCountList,
      successRequest: (result) {
        LoadingToast.remove();
        getPlansItems();
      },
    );
  }
}
