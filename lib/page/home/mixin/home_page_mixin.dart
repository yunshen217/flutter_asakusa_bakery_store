import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/model/order_list_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

mixin HomePageMixin<T extends StatefulWidget> on State<T> {
  TextEditingController editcontroller = TextEditingController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxInt orderStateIndex = 0.obs;
  List orderState = [
    {
      "selected_icon": "order_state_make_select@3x.png",
      "un_selected_icon": "order_state_make@3x.png",
      "name": '製造中'
    },
    {
      "selected_icon": "order_state_receive_select@3x.png",
      "un_selected_icon": "order_state_receive@3x.png",
      "name": '出荷待'
    },
    {
      "selected_icon": "order_state_mail_select@3x.png",
      "un_selected_icon": "order_state_mail@3x.png",
      "name": '出荷済'
    },
    {
      "selected_icon": "order_state_finish_select@3x.png",
      "un_selected_icon": "order_state_finish@3x.png",
      "name": '完了'
    },
  ];
  // tab
  RxInt tabIndex = 0.obs;
  RxList<String> tabs = ["すべて", "配達", "引取"].obs;
  RxList<RxBool> orderDetailsSelected = <RxBool>[].obs;

  RxString time = "".obs;
  // 配達
  RxBool isAllSelectedMail = false.obs;
  // 引取
  RxBool isAllSelectedStorePickup = false.obs;

  bool notLogin = false;

  RxInt pageNum = 1.obs;
  int pageSize = 10;
  RxString isSend = "0".obs;
  RxList<OrderListModelRecords> records = <OrderListModelRecords>[].obs;

  Future<void> onRefresh() async {
    pageNum.value = 1;
    await getOrderList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    pageNum.value++;
    await getOrderList();
    refreshController.loadComplete();
  }

  getOrderList() {
    int num = orderStateIndex.value + 1;
    print("orderStateIndex ----------------- ${num}");
    Map<String, dynamic> param = {
      "pageNum": pageNum.value,
      "pageSize": pageSize,
      "type": '$num',
      "orderDate": time.value,
      "isSend": tabIndex.value == 0 ? null : isSend.value
    };
    print("map ------------------ $param");
    backEndRepository.doPost(Constant.orderList, params: param,
        successRequest: (res) {
      print("res ---------------- ${res["data"]}");
      OrderListModel orderList = OrderListModel.fromJson(res["data"]);
      if (orderList.records != null) {
        final newRecords =
            orderList.records!.whereType<OrderListModelRecords>().toList();
        if (pageNum.value == 1) {
          records.assignAll(newRecords);
        } else {
          records.addAll(newRecords);
        }
      }
    });
  }

  judgeTheValueOfIsSend() {
    switch (tabIndex.value) {
      case 0:
        break;
      case 1:
        isSend.value = "1";
        break;
      case 2:
        isSend.value = "0";
        break;
    }
  }

  allSelectedMail() {
    if (tabIndex.value == 0) {
      for (var i = 0; i < records.length; i++) {
        if (records[i].isSend == 1) {
          orderDetailsSelected[i].value = isAllSelectedMail.value;
        }else{
          orderDetailsSelected[i].value = false;
        }
      }
    } else {
      orderDetailsSelected
          .assignAll(records.map((e) => isAllSelectedMail.value.obs));
    }
  }

  allSelectedStorePickup(){
    if (tabIndex.value == 0) {
      for (var i = 0; i < records.length; i++) {
        if (records[i].isSend == 0) {
          orderDetailsSelected[i].value = isAllSelectedStorePickup.value;
        }else{
          orderDetailsSelected[i].value = false;
        }
      }
    } else {
      orderDetailsSelected
          .assignAll(records.map((e) => isAllSelectedStorePickup.value.obs));
    }
  }
}
