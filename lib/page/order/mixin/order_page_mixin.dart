import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/model/detail_model.dart';
import 'package:flutter_asakusa_bakery_store/model/order_plans_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

mixin OrderPageMixin<T extends StatefulWidget> on State<T> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<Tab> tabs = [const Tab(text: "リスト"), const Tab(text: "グラフ")];

  /// リスト ： 0、グラフ ： 1
  RxInt mainTabIndex = 0.obs;

  /// 初期時間
  RxString timeStart = "".obs;

  /// 終了時間
  RxString timeEnd = "".obs;

  /// グラフデータ
  RxMap chartsData = {
    "xAxis": ['7/1', '7/2', '7/2', '7/2', '7/2'],
    "yAxis": ["6", "10", "111", "45", "80"],
  }.obs;

  bool notLogin = false;

  RxList<OrderPlansModel> orderPlansData = [OrderPlansModel.fromJson({})].obs;
  RxString sendOrderCount = "".obs;
  RxString totalCount = "".obs;
  RxString allAmount = "".obs;

  Future<void> onRefresh() async {
    await getOrderList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await getOrderList();
    refreshController.loadComplete();
  }

  String formatDateSlash(DateTime date) {
    return '${date.month}/${date.day}';
  }

  getOrderList() async {
    await backEndRepository.doPost(Constant.ordersPlans,
        params: {"startDate": timeStart.value, "endDate": timeEnd.value},
        successRequest: (res) {
      orderPlansData.value = [];
      orderPlansData.value = (res['data'] as List)
          .map((e) => OrderPlansModel.fromJson(e ?? {}))
          .toList();
      if(orderPlansData.isNotEmpty){
        List<String> xAxis = [];
        List<String> yAxis = [];
        sendOrderCount.value = orderPlansData[0].sendOrderCount.toString();
        totalCount.value = orderPlansData[0].totalCount.toString();
        allAmount.value = orderPlansData[0].allAmount.toString();
        for (var data in orderPlansData) {
          xAxis.add(formatDateSlash(DateTime.parse(data.reserveDate!)));
          yAxis.add(data.totalCount.toString());
        }
        chartsData["xAxis"] = xAxis;
        chartsData["yAxis"] = yAxis;
        
      }
    });
  }

  getDetailData() async{
    await backEndRepository.doGet(Constant.detail,successRequest: (result) {
      DetailModel detailModel = DetailModel.fromJson(result["data"]??{});
      timeEnd.value =DateFormat('yyyy-MM-dd')
    .format(DateTime.now().add( Duration(days: detailModel.approvalDays!))); 
    getOrderList();
    },);
  }
}
