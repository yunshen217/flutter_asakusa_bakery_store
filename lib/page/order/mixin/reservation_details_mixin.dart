import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';

mixin ReservationDetailsMixin<T extends StatefulWidget> on State<T>{
  RxString time = "2024-03-21".obs;

  /// 詳細データリスト
  RxList detailsData = [
    {
      "name": "test",
      "plannedQuantity": "12",
      "orderNumber": "0",
      "inventory": "12"
    }
  ].obs;

  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodeList = <FocusNode>[].obs;

  getPlansItems() async{
    Map<String, dynamic> params = {
      "orderDate": time.value
    };
    await backEndRepository.doPost(Constant.plansItems,params: params, successRequest:(result) {
      print("res --------------- $result");
    },);
  }
}