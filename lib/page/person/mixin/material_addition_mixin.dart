import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/ingredients_stocks_model.dart';
import 'package:flutter_asakusa_bakery_store/model/units_min_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';

mixin MaterialAdditionMixin<T extends StatefulWidget> on State<T>{
  /// bool: isHaveDeletedBtn / String:id / IngredientsStocksModel
  final arguments = Get.arguments;
  // 材料名
  TextEditingController nameController = TextEditingController();
  // 入荷閩值
  TextEditingController inboundQuantityThresholdController =
      TextEditingController();
  // アレルゲン区分
  RxString allergenCategory = "数値を入力してください".obs;
  RxList allergenCategoryList = ["是", "否"].obs;

  /// 最小単位
  RxString minimumUnit = "数値を入力してください".obs;
  RxList<UnitsMinModel> unitsMinList = <UnitsMinModel>[].obs;
  RxList minimumUnitList = [].obs;

  /// 表示単位
  RxString displayUnit = "数値を入力してください".obs;
  RxList<UnitsMinModel> displayList = <UnitsMinModel>[].obs;
  RxList displayUnitList = [].obs;
  RxBool isHaveDeletedBtn = false.obs;
  RxString id = "".obs;
  final ingredientsStocksModel = Rxn<IngredientsStocksModel>();
  setIngredientsStocksData() {
    nameController.text = ingredientsStocksModel.value!.ingredientName!;
    allergenCategory.value =
        ingredientsStocksModel.value!.isAllergen == "1" ? "是" : "否";
    if (unitsMinList.isNotEmpty) {
      for (var data in unitsMinList) {
        if (ingredientsStocksModel.value!.minUnitId.toString() == data.id) {
          minimumUnit.value = data.unit!;
        }
      }
    }
    if (displayList.isNotEmpty) {
      for (var data in displayList) {
        if (ingredientsStocksModel.value!.displayUnitId.toString() == data.id) {
          displayUnit.value = data.unit!;
        }
      }
    }
    inboundQuantityThresholdController.text =
        ingredientsStocksModel.value!.purchaseThreshold.toString();
  }

  getUnitsMin() async {
    await backEndRepository.doGet(
      Constant.unitsMin,
      successRequest: (result) {
        if (result["data"] != null) {
          unitsMinList.assignAll(
            (result['data'] as List? ?? [])
                .map((e) => UnitsMinModel.fromJson(e ?? {}))
                .toList(),
          );
          if (unitsMinList.isNotEmpty) {
            for (var item in unitsMinList) {
              minimumUnitList.add(item.unit);
            }
          }
        }
      },
    );
  }

  getDisplayUnits() async {
    await backEndRepository.doGet(
      "${Constant.base_url}merchant/units/display/${id.value}",
      successRequest: (result) {
        if (result["data"] != null) {
          displayList.clear();
          displayUnitList.clear();
          displayList.assignAll(
            (result['data'] as List? ?? [])
                .map((e) => UnitsMinModel.fromJson(e ?? {}))
                .toList(),
          );
          if (displayList.isNotEmpty) {
            for (var item in displayList) {
              displayUnitList.add(item.unit);
            }
          }
        }
      },
    );
  }

  updateProductIngredient() async {
    String minUnitId = "";
    for (var data in unitsMinList) {
      if (minimumUnit.value == data.unit) {
        minUnitId = data.id!;
      }
    }
    String displayUnitId = "";
    for (var data in displayList) {
      if (displayUnit.value == data.unit) {
        displayUnitId = data.id!;
      }
    }

    Map<String, dynamic> params = {
      "id": ingredientsStocksModel.value!.id!,
      "merchantId": Global.merchantId,
      "ingredientName": nameController.text,
      "isAllergen": allergenCategory.value == "是" ? "1" : "0",
      "minUnitId": minUnitId,
      "displayUnitId": displayUnitId,
      "purchaseThreshold": inboundQuantityThresholdController.text
    };
    if (isHaveDeletedBtn.value) {
      await backEndRepository.doPut(
        Constant.ingredients,
        params: params,
        successRequest: (result) {
          Get.back();
        },
      );
    } else {
      await backEndRepository.doPost(
        Constant.ingredients,
        params: params,
        successRequest: (result) {
          Get.back();
        },
      );
    }
  }

  deleteProductIngredient() async {
    await backEndRepository.doDel(
      '${Constant.ingredients}/${ingredientsStocksModel.value!.id!}',
      successRequest: (result) {
        Get.back();
      },
    );
  }

}