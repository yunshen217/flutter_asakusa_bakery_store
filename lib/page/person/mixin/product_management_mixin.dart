import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/common_search_param_model.dart';
import 'package:flutter_asakusa_bakery_store/model/items_list_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';

/// 商品管理
mixin ProductManagementMixin<T extends StatefulWidget> on State<T> {
  List tabs = ["贩壳中", "开発中", "服壳中止"];
  // 1 开発中 2 贩壳中 3 服壳中止
  RxInt tabIndex = 0.obs;

  /// 商品リストデータ
  RxList<ItemsListModel> productData = <ItemsListModel>[].obs;

  RxBool isPanelVisible = false.obs;

  RxList<CommonSearchParamModelItemKindList?> commonSearchList =
      <CommonSearchParamModelItemKindList?>[].obs;

  /// ボタンがクリックされたかどうか
  RxList<RxBool> siftBtnDataIsSelectes = [false.obs].obs;
  RxList kindIdList = [].obs;

  getCommonSearchParam() async {
    await backEndRepository.doGet(
      Constant.commonSearchParam,
      successRequest: (result) {
        if (result["data"] != null) {
          commonSearchList.value =
              CommonSearchParamModel.fromJson(result["data"]).itemKindList!;
          siftBtnDataIsSelectes.value =
              List.generate(commonSearchList.length, (index) => false.obs);
        }
      },
    );
  }

  getItemsList() async {
    String status = "";
    if (tabIndex.value == 0) {
      status = "2";
    } else if (tabIndex.value == 1) {
      status = "1";
    } else if (tabIndex.value == 2) {
      status = "3";
    } else {
      status = "";
    }
    Map<String, dynamic> param = {"kindIdList": kindIdList, "status": status,"merchantId":Global.merchantId};

    await backEndRepository.doPost(
      Constant.itemList,
      params: param,
      successRequest: (result) {
        if (result["data"] != null) {
          productData.assignAll(
            (result["data"] as List)
                .map((e) => ItemsListModel.fromJson(e))
                .toList(),
          );
        }
      },
    );
  }
}
