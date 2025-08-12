
class OrderPlansModel {
/*
{
  "reserveDate": "2025-08-12",
  "status": 1,
  "orderCount": null,
  "sendOrderCount": 0,
  "totalCount": 0,
  "allAmount": 0,
  "planCount": 933,
  "todayInStore": 933
} 
*/

  String? reserveDate;
  String? status;
  int? orderCount;
  int? sendOrderCount;
  int? totalCount;
  int? allAmount;
  int? planCount;
  int? todayInStore;

  OrderPlansModel({
    this.reserveDate,
    this.status,
    this.orderCount,
    this.sendOrderCount,
    this.totalCount,
    this.allAmount,
    this.planCount,
    this.todayInStore,
  });
  OrderPlansModel.fromJson(Map<String, dynamic> json) {
    reserveDate = json['reserveDate']?.toString()??"";
    status = json['status']?.toString() ?? '';
    orderCount = int.tryParse(json['orderCount']?.toString()??'')??0;
    sendOrderCount = int.tryParse(json['sendOrderCount']?.toString() ?? '')??0;
    totalCount = int.tryParse(json['totalCount']?.toString() ?? '')??0;
    allAmount = int.tryParse(json['allAmount']?.toString() ?? '')??0;
    planCount = int.tryParse(json['planCount']?.toString() ?? '')??0;
    todayInStore = int.tryParse(json['todayInStore']?.toString() ?? '')??0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reserveDate'] = reserveDate;
    data['status'] = status;
    data['orderCount'] = orderCount;
    data['sendOrderCount'] = sendOrderCount;
    data['totalCount'] = totalCount;
    data['allAmount'] = allAmount;
    data['planCount'] = planCount;
    data['todayInStore'] = todayInStore;
    return data;
  }
}
