
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
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
  RxList orderDetailsSelectedId = [].obs;

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

  getOrderList() async {
    int num = orderStateIndex.value + 1;
    Map<String, dynamic> param = {
      "pageNum": pageNum.value,
      "pageSize": pageSize,
      "type": '$num',
      "orderDate": time.value,
      "isSend": tabIndex.value == 0 ? null : isSend.value
    };
    await backEndRepository.doPost(Constant.orderList, params: param,
        successRequest: (res) {
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

  getOrderStatus(String id) async{
    Map<String, dynamic> param = {
      "id":id,
      "type":'${orderStateIndex.value + 1}'
    };
    await backEndRepository.doPut(Constant.orderStatus,params: param,successRequest: (result) {
      customWidget.toastShowNotIcon("更新完了");
      onRefresh();
    },);
  }

  cancelOrder(String id) async{
    Get.back();
    await backEndRepository.doGet('${Constant.base_url}merchant/orders/$id/refund',successRequest: (result) {
      onRefresh();
    },);
  }

  getOrderStatusBatch() async{
    Map<String, dynamic> param = {
      "idList":orderDetailsSelectedId,
      "type":'${orderStateIndex.value + 1}'
    };
    await backEndRepository.doPut(Constant.orderStatusBatch,params: param,successRequest: (result) {
      customWidget.toastShowNotIcon("更新完了");
      onRefresh();
    },);
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
    orderDetailsSelectedId.value = [];
    for (final data in records) {
      final id = data.id;

      if (tabIndex.value == 0 &&
          isAllSelectedMail.value &&
          int.parse(data.isSend.toString()) == 1) {
        orderDetailsSelectedId.add(id);
      } else if (tabIndex.value == 1 && isAllSelectedMail.value) {
        orderDetailsSelectedId.add(id);
      }
    }
  }

  allSelectedStorePickup() {
    orderDetailsSelectedId.value = [];
    for (final data in records) {
      final id = data.id;
      if (tabIndex.value == 0 &&
          isAllSelectedStorePickup.value &&
          int.parse(data.isSend.toString()) == 0) {
        orderDetailsSelectedId.add(id);
      } else if (tabIndex.value == 2 && isAllSelectedStorePickup.value) {
        orderDetailsSelectedId.add(id);
      }
    }
  }
}
