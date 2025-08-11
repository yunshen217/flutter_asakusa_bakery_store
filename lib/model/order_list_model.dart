class OrderListModelRecordsPsOrderDetails {
/*
{
  "itemId": 1823190326216065000,
  "itemName": "肉松（豚フレーク）ロール",
  "itemCount": 1,
  "itemPrice": 580,
  "filePath": null
} 
*/

  int? itemId;
  String? itemName;
  int? itemCount;
  int? itemPrice;
  String? filePath;

  OrderListModelRecordsPsOrderDetails({
    this.itemId,
    this.itemName,
    this.itemCount,
    this.itemPrice,
    this.filePath,
  });
  OrderListModelRecordsPsOrderDetails.fromJson(Map<String, dynamic> json) {
    itemId = int.tryParse(json['itemId']?.toString() ?? '')??0;
    itemName = json['itemName']?.toString()??"";
    itemCount = int.tryParse(json['itemCount']?.toString() ?? '')??0;
    itemPrice = int.tryParse(json['itemPrice']?.toString() ?? '')??0;
    filePath = json['filePath']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['itemName'] = itemName;
    data['itemCount'] = itemCount;
    data['itemPrice'] = itemPrice;
    data['filePath'] = filePath;
    return data;
  }
}

class OrderListModelRecords {
/*
{
  "id": 1948551605504184300,
  "orderStatus": 3,
  "isSend": 0,
  "updateTime": "2025-07-25 01:11:19",
  "sendNo": null,
  "orderNo": "A1753405879740",
  "sendName": "rrqqs",
  "pickupNo": "C298",
  "psOrderDetails": [
    {
      "itemId": 1823190326216065000,
      "itemName": "肉松（豚フレーク）ロール",
      "itemCount": 1,
      "itemPrice": 580,
      "filePath": null
    }
  ],
  "remark": "",
  "appointmentTime": "2025-07-28"
} 
*/

  int? id;
  // 0 キャンセル 1 支払待 2 注文確定 3 製作中 4 焼き上り 5 出荷済 6 受取済
  int? orderStatus;
  int? isSend;
  String? updateTime;
  String? sendNo;
  String? orderNo;
  String? sendName;
  String? pickupNo;
  List<OrderListModelRecordsPsOrderDetails?>? psOrderDetails;
  String? remark;
  String? appointmentTime;

  OrderListModelRecords({
    this.id,
    this.orderStatus,
    this.isSend,
    this.updateTime,
    this.sendNo,
    this.orderNo,
    this.sendName,
    this.pickupNo,
    this.psOrderDetails,
    this.remark,
    this.appointmentTime,
  });
  OrderListModelRecords.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    orderStatus = int.tryParse(json['orderStatus']?.toString() ?? '')??0;
    isSend = int.tryParse(json['isSend']?.toString() ?? '')??0;
    updateTime = json['updateTime']?.toString()??"";
    sendNo = json['sendNo']?.toString()??"";
    orderNo = json['orderNo']?.toString()??"";
    sendName = json['sendName']?.toString()??"";
    pickupNo = json['pickupNo']?.toString()??"";
  if (json['psOrderDetails'] != null && (json['psOrderDetails'] is List)) {
  final v = json['psOrderDetails'];
  final arr0 = <OrderListModelRecordsPsOrderDetails>[];
  v.forEach((v) {
  arr0.add(OrderListModelRecordsPsOrderDetails.fromJson(v));
  });
    psOrderDetails = arr0;
    }
    remark = json['remark']?.toString();
    appointmentTime = json['appointmentTime']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['orderStatus'] = orderStatus;
    data['isSend'] = isSend;
    data['updateTime'] = updateTime;
    data['sendNo'] = sendNo;
    data['orderNo'] = orderNo;
    data['sendName'] = sendName;
    data['pickupNo'] = pickupNo;
    if (psOrderDetails != null) {
      final v = psOrderDetails;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['psOrderDetails'] = arr0;
    }
    data['remark'] = remark;
    data['appointmentTime'] = appointmentTime;
    return data;
  }
}

class OrderListModel {
/*
{
  "records": [
    {
      "id": 1948551605504184300,
      "orderStatus": 3,
      "isSend": 0,
      "updateTime": "2025-07-25 01:11:19",
      "sendNo": null,
      "orderNo": "A1753405879740",
      "sendName": "rrqqs",
      "pickupNo": "C298",
      "psOrderDetails": [
        {
          "itemId": 1823190326216065000,
          "itemName": "肉松（豚フレーク）ロール",
          "itemCount": 1,
          "itemPrice": 580,
          "filePath": null
        }
      ],
      "remark": "",
      "appointmentTime": "2025-07-28"
    }
  ],
  "total": 1,
  "size": 1,
  "current": 1,
  "pages": 1
} 
*/

  List<OrderListModelRecords?>? records;
  int? total;
  int? size;
  int? current;
  int? pages;

  OrderListModel({
    this.records,
    this.total,
    this.size,
    this.current,
    this.pages,
  });
  OrderListModel.fromJson(Map<String, dynamic> json) {
  if (json['records'] != null && (json['records'] is List)) {
  final v = json['records'];
  final arr0 = <OrderListModelRecords>[];
  v.forEach((v) {
  arr0.add(OrderListModelRecords.fromJson(v));
  });
    records = arr0;
    }
    total = int.tryParse(json['total']?.toString() ?? '')??0;
    size = int.tryParse(json['size']?.toString() ?? '')??0;
    current = int.tryParse(json['current']?.toString() ?? '')??0;
    pages = int.tryParse(json['pages']?.toString() ?? '')??0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (records != null) {
      final v = records;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['records'] = arr0;
    }
    data['total'] = total;
    data['size'] = size;
    data['current'] = current;
    data['pages'] = pages;
    return data;
  }

}
