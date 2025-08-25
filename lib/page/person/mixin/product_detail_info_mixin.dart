import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/model/product_detail_model.dart';
import 'package:flutter_asakusa_bakery_store/model/product_ingredient_list_model.dart';
import 'package:flutter_asakusa_bakery_store/model/time_period_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

mixin ProductDetailInfoMixin<T extends StatefulWidget> on State<T> {
  // isHavePurge : クリアボタンが含まれていますか？
  // id
  final arguments = Get.arguments;
  String id = "";

  final productDetailModel = Rxn<ProductDetailModel>();
  List topTitle = ["商品番号", "商品名", "商品名略称"];

  late final RxList<TextEditingController> topTitleController;

  List bottomTitle = [
    "望価(税込)",
    "重量(g)",
    "カロリ一",
    "幅(mm)",
    "奥行き(mm)",
    "高さ(mm)",
    "デフオルト計画数"
  ];

  late final RxList<TextEditingController> bottomTitleController;

  RxList<AssetEntity> image = <AssetEntity>[].obs;

  RxString productCategorySelected = "商品カテゴリ".obs;
  RxList productCategory = [
    "八ン",
    "食バン",
    "アイスバン",
    "プレッツエル",
    "ベ-グル",
    "ク一キ",
    "クッキ-",
    "スコ-ン",
    "スウ(酥)",
    "月餅",
    "その他",
    "新商品",
    "季限定"
  ].obs;
  final timePeriodModel = Rxn<TimePeriodModel>();
  RxString freshlyBakedTimeZoneSelected = "商品焼きたて時間带を選択してください".obs;
  RxList freshlyBakedTimeZone = ["12:00~13:00", "13:00~14:00"].obs;

  RxString statusSelected = "ステ一タス".obs;
  RxList status = ["贩壳中", "开発中", "服壳中止"].obs;

  TextEditingController productDescriptionController = TextEditingController();
  FocusNode productDescriptionFocusNode = FocusNode();

  TextEditingController rawMaterialsController = TextEditingController();
  FocusNode rawMaterialsFocusNode = FocusNode();

  List allergyInfo = [
    {
      "name": "小麦",
      "selected": "icon_yellow8.png",
      "notSelected": "icon_black8.png"
    },
    {
      "name": "卵",
      "selected": "icon_yellow6.png",
      "notSelected": "icon_black6.png"
    },
    {
      "name": "乳",
      "selected": "icon_yellow7.png",
      "notSelected": "icon_black7.png"
    },
    {
      "name": "工ビ匹",
      "selected": "icon_yellow1.png",
      "notSelected": "icon_black1.png"
    },
    {
      "name": "カニ匹",
      "selected": "icon_yellow2.png",
      "notSelected": "icon_black2.png"
    },
    {
      "name": "そば",
      "selected": "icon_yellow5.png",
      "notSelected": "icon_black5.png"
    },
    {
      "name": "落花生",
      "selected": "icon_yellow4.png",
      "notSelected": "icon_black4.png"
    },
    {
      "name": "くるみ",
      "selected": "icon_yellow3.png",
      "notSelected": "icon_black3.png"
    }
  ];

  RxList<RxBool> allergyInfoIsSelected = <RxBool>[].obs;
  RxList<String> fileIdList = <String>[].obs;
  RxList<String> assetsImg = <String>[].obs;

  /// 材料データを選択する
  List selectTheMaterial = [];

  /// 現在選択された材料
  RxList currentlyselectTheMaterial = [].obs;

  RxList<ProductIngredientListModel> productIngredientListModel =
      <ProductIngredientListModel>[].obs;
  RxList<ProductDetailModelPsIngredientsList?> psIngredientsList =
      <ProductDetailModelPsIngredientsList>[].obs;

  /// 入力ボックスコントローラー一覧
  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodeList = <FocusNode>[].obs;
  gettimePeriods() async {
    await backEndRepository.doGet(
      "${Constant.base_url}merchant/time-periods?merchantId=${Global.merchantId}",
      successRequest: (result) {
        timePeriodModel.value = TimePeriodModel.fromJson(result["data"] ?? "");
        if (timePeriodModel.value!.timePeriodList!.isNotEmpty) {
          freshlyBakedTimeZone.clear();
          for (var data in timePeriodModel.value!.timePeriodList!) {
            freshlyBakedTimeZone.add(data!.label!);
          }
        }
      },
    );
  }

  getProductDetail() async {
    await backEndRepository.doGet(
      "${Constant.base_url}merchant/items/$id",
      successRequest: (result) {
        if (result["data"] != null) {
          productDetailModel.value =
              ProductDetailModel.fromJson(result["data"] ?? {});
          topTitleController[0].text = productDetailModel.value!.itemNo!;
          topTitleController[1].text = productDetailModel.value!.itemName!;
          topTitleController[2].text = productDetailModel.value!.itemShortName!;
          assetsImg.clear();
          if (productDetailModel.value!.files!.isNotEmpty) {
            for (var data in productDetailModel.value!.files!) {
              assetsImg.add('${Constant.picture_url}${data!.filePath}'
                  '${data.fileName}');
              fileIdList.add(data.id.toString());
            }
          }
          productDescriptionController.text =
              productDetailModel.value!.description!;
          rawMaterialsController.text = productDetailModel.value!.ingredients!;
          statusSelected.value = productDetailModel.value!.status == "1"
              ? "开発中"
              : (productDetailModel.value!.status == "2" ? "贩壳中" : "贩卖停止");
          bottomTitleController[0].text =
              productDetailModel.value!.price.toString();
          bottomTitleController[1].text =
              productDetailModel.value!.weight.toString();
          bottomTitleController[2].text =
              productDetailModel.value!.calorie.toString();
          bottomTitleController[3].text =
              productDetailModel.value!.horizontal.toString();
          bottomTitleController[4].text =
              productDetailModel.value!.vertical.toString();
          bottomTitleController[5].text =
              productDetailModel.value!.height.toString();
          bottomTitleController[6].text =
              productDetailModel.value!.defaultPlan.toString();
          if (productDetailModel.value!.allergenIdList!.isNotEmpty) {
            for (var i = 0;
                i < productDetailModel.value!.allergenIdList!.length;
                i++) {
              String item = productDetailModel.value!.allergenIdList![i];
              allergyInfoIsSelected[int.parse(item) - 1].value = true;
            }
          }
          if (productDetailModel.value!.itemKindId! != 0) {
            productCategorySelected.value =
                productCategory[productDetailModel.value!.itemKindId! - 1];
          }
          if (productDetailModel.value!.timePeriodId! != 0) {
            for (var data in timePeriodModel.value!.timePeriodList!) {
              if (data!.id ==
                  productDetailModel.value!.timePeriodId!.toString()) {
                freshlyBakedTimeZoneSelected.value = data.label!;
              }
            }
          }
          currentlyselectTheMaterial.clear();
          if (productDetailModel.value!.psIngredientsList!.isNotEmpty) {
            psIngredientsList.value =
                productDetailModel.value!.psIngredientsList!;
            for (int i = 0;
                i < productDetailModel.value!.psIngredientsList!.length;
                i++) {
              final item = productDetailModel.value!.psIngredientsList![i]!;
              controllerList.add(TextEditingController());
              focusNodeList.add(FocusNode());
              String minUnitId = "";
              for (var data in productIngredientListModel) {
                if(data.id == item.id.toString()){
                  minUnitId = data.minUnitId!;
                }
              }
              currentlyselectTheMaterial.add({
                "id": item.id,
                "count": item.count,
                "minUnitId": minUnitId
              });
            }
          }
        }
      },
    );
  }

  getProductIngredientList() async {
    await backEndRepository.doGet(
      '${Constant.base_url}merchant/items/ingredients?merchantId=${Global.merchantId}',
      successRequest: (result) {
        productIngredientListModel.clear();
        controllerList.clear();
        focusNodeList.clear();
        selectTheMaterial.clear();
        if (result["data"] != null) {
          for (var data in result["data"]) {
            productIngredientListModel
                .add(ProductIngredientListModel.fromJson(data));
            selectTheMaterial.add(data["ingredientName"] ?? "");
          }
        }
      },
    );
  }

  updateProduct() async {
    String allergen = "";
    if (allergyInfoIsSelected.isNotEmpty) {
      for (int i = 0; i < allergyInfoIsSelected.length; i++) {
        if (allergyInfoIsSelected[i].value) {
          allergen == "" ? allergen += "${i + 1}" : allergen += ",${i + 1}";
        }
      }
    }
    String timePeriodId = "";
    if (timePeriodModel.value!.timePeriodList!.isNotEmpty) {
      for (var data in timePeriodModel.value!.timePeriodList!) {
        if (data!.label == freshlyBakedTimeZoneSelected.value) {
          timePeriodId = data.id!;
        }
      }
    }
    List ingredientList = [];
    if (currentlyselectTheMaterial.isNotEmpty) {
      // 確保 controllerList 的長度與 currentlyselectTheMaterial 的長度一致
      if (controllerList.length != currentlyselectTheMaterial.length) {
        return;
      }
      for (var i = 0; i < currentlyselectTheMaterial.length; i++) {
        ingredientList.add({
          "id": currentlyselectTheMaterial[i]["id"] ?? "",
          "count": controllerList[i].text,
          "minUnitId": currentlyselectTheMaterial[i]["minUnitId"] ?? ""
        });
      }
    }

    Map<String, dynamic> params = {
      "id": id == "" ? "" : productDetailModel.value!.id,
      "merchantId": Global.merchantId,
      "itemNo": topTitleController[0].text,
      "itemName": topTitleController[1].text,
      "itemShortName": topTitleController[2].text,
      "itemKindId": productCategorySelected.value == "商品カテゴリ"
          ? ""
          : productCategory.indexOf(productCategorySelected.value) + 1,
      "description": productDescriptionController.text,
      "ingredients": rawMaterialsController.text,
      "allergen": allergen,
      "status": statusSelected.value == "开発中"
          ? "1"
          : (statusSelected.value == "贩壳中" ? "2" : "3"),
      "price": bottomTitleController[0].text,
      "vertical": bottomTitleController[4].text,
      "horizontal": bottomTitleController[3].text,
      "height": bottomTitleController[5].text,
      "calorie": bottomTitleController[2].text,
      "weight": bottomTitleController[1].text,
      "weightUnitId": 0,
      "defaultPlan": bottomTitleController[6].text,
      "timePeriodId": timePeriodId,
      "fileIdList": fileIdList,
      "ingredientList": ingredientList
    };
    if (id == "") {
      await backEndRepository.doPost(
        "${Constant.base_url}merchant/items/save",
        params: params,
        successRequest: (result) {
          Get.back();
        },
      );
    } else {
      await backEndRepository.doPut(
        "${Constant.base_url}merchant/items/save",
        params: params,
        successRequest: (result) {
          Get.back();
        },
      );
    }
  }
}
