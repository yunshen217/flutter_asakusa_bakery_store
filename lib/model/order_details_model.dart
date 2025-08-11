class OrderDetailsModelPsOrderDetails {
/*
{
  "itemId": "1823190326216065025",
  "itemName": "肉松（豚フレーク）ロール",
  "itemCount": 1,
  "itemPrice": 580,
  "filePath": "/images/81e5f285-d401-4985-b1c9-6f82fa4a93b6_20240813_114947.png"
} 
*/

  String? itemId;
  String? itemName;
  int? itemCount;
  int? itemPrice;
  String? filePath;

  OrderDetailsModelPsOrderDetails({
    this.itemId,
    this.itemName,
    this.itemCount,
    this.itemPrice,
    this.filePath,
  });
  OrderDetailsModelPsOrderDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId']?.toString() ?? "";
    itemName = json['itemName']?.toString() ?? "";
    itemCount = int.tryParse(json['itemCount']?.toString() ?? '') ?? 0;
    itemPrice = int.tryParse(json['itemPrice']?.toString() ?? '') ?? 0;
    filePath = json['filePath']?.toString() ?? "";
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

class OrderDetailsModel {
/*
{
  "orderStatus": 3,
  "isSend": 1,
  "paymentStatus": 1,
  "sendNo": null,
  "phoneNumber": "15885",
  "orderNo": "A1753405794986",
  "sendName": "liu",
  "pickupNo": null,
  "psOrderDetails": [
    {
      "itemId": "1823190326216065025",
      "itemName": "肉松（豚フレーク）ロール",
      "itemCount": 1,
      "itemPrice": 580,
      "filePath": "/images/81e5f285-d401-4985-b1c9-6f82fa4a93b6_20240813_114947.png"
    }
  ],
  "remark": "",
  "orderDate": "2025-07-25 01:09:54",
  "postcode": "1000001",
  "prefectures": "東京都",
  "municipalities": "千代田区千代田",
  "streetAddress": "t",
  "building": "t",
  "sendTime": "2025-07-28 16:00~18:00",
  "totalAmount": 870,
  "deliveryCharge": 700,
  "refrigerationFee": 200,
  "usedPoint": 0,
  "earnedPoint": 8,
  "paymentChannel": 4,
  "id": "1948551250041114626",
  "distributionMode": 1,
  "taxDeductionAmount": 64
} 
*/

  int? orderStatus;
  int? isSend;
  String? paymentStatus;
  String? sendNo;
  String? phoneNumber;
  String? orderNo;
  String? sendName;
  String? pickupNo;
  List<OrderDetailsModelPsOrderDetails?>? psOrderDetails;
  String? remark;
  String? orderDate;
  String? postcode;
  String? prefectures;
  String? municipalities;
  String? streetAddress;
  String? building;
  String? sendTime;
  int? totalAmount;
  int? deliveryCharge;
  int? refrigerationFee;
  int? usedPoint;
  int? earnedPoint;
  int? paymentChannel;
  String? id;
  int? distributionMode;
  int? taxDeductionAmount;

  OrderDetailsModel({
    this.orderStatus,
    this.isSend,
    this.paymentStatus,
    this.sendNo,
    this.phoneNumber,
    this.orderNo,
    this.sendName,
    this.pickupNo,
    this.psOrderDetails,
    this.remark,
    this.orderDate,
    this.postcode,
    this.prefectures,
    this.municipalities,
    this.streetAddress,
    this.building,
    this.sendTime,
    this.totalAmount,
    this.deliveryCharge,
    this.refrigerationFee,
    this.usedPoint,
    this.earnedPoint,
    this.paymentChannel,
    this.id,
    this.distributionMode,
    this.taxDeductionAmount,
  });
  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderStatus = int.tryParse(json['orderStatus']?.toString() ?? '') ?? 10;
    isSend = int.tryParse(json['isSend']?.toString() ?? '') ?? 0;
    paymentStatus = json['paymentStatus']?.toString() ?? '';
    sendNo = json['sendNo']?.toString() ?? "";
    phoneNumber = json['phoneNumber']?.toString() ?? "";
    orderNo = json['orderNo']?.toString() ?? "";
    sendName = json['sendName']?.toString() ?? "";
    pickupNo = json['pickupNo']?.toString() ?? "";
    if (json['psOrderDetails'] != null && (json['psOrderDetails'] is List)) {
      final v = json['psOrderDetails'];
      final arr0 = <OrderDetailsModelPsOrderDetails>[];
      v.forEach((v) {
        arr0.add(OrderDetailsModelPsOrderDetails.fromJson(v));
      });
      psOrderDetails = arr0;
    }
    remark = json['remark']?.toString() ?? "";
    orderDate = json['orderDate']?.toString() ?? "";
    postcode = json['postcode']?.toString() ?? "";
    prefectures = json['prefectures']?.toString() ?? "";
    municipalities = json['municipalities']?.toString() ?? "";
    streetAddress = json['streetAddress']?.toString() ?? "";
    building = json['building']?.toString() ?? "";
    sendTime = json['sendTime']?.toString() ?? "";
    totalAmount = int.tryParse(json['totalAmount']?.toString() ?? '') ?? 0;
    deliveryCharge =
        int.tryParse(json['deliveryCharge']?.toString() ?? '') ?? 0;
    refrigerationFee =
        int.tryParse(json['refrigerationFee']?.toString() ?? '') ?? 0;
    usedPoint = int.tryParse(json['usedPoint']?.toString() ?? '') ?? 0;
    earnedPoint = int.tryParse(json['earnedPoint']?.toString() ?? '') ?? 0;
    paymentChannel =
        int.tryParse(json['paymentChannel']?.toString() ?? '') ?? 0;
    id = json['id']?.toString() ?? "";
    distributionMode =
        int.tryParse(json['distributionMode']?.toString() ?? '') ?? 0;
    taxDeductionAmount =
        int.tryParse(json['taxDeductionAmount']?.toString() ?? '') ?? 0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['orderStatus'] = orderStatus;
    data['isSend'] = isSend;
    data['paymentStatus'] = paymentStatus;
    data['sendNo'] = sendNo;
    data['phoneNumber'] = phoneNumber;
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
    data['orderDate'] = orderDate;
    data['postcode'] = postcode;
    data['prefectures'] = prefectures;
    data['municipalities'] = municipalities;
    data['streetAddress'] = streetAddress;
    data['building'] = building;
    data['sendTime'] = sendTime;
    data['totalAmount'] = totalAmount;
    data['deliveryCharge'] = deliveryCharge;
    data['refrigerationFee'] = refrigerationFee;
    data['usedPoint'] = usedPoint;
    data['earnedPoint'] = earnedPoint;
    data['paymentChannel'] = paymentChannel;
    data['id'] = id;
    data['distributionMode'] = distributionMode;
    data['taxDeductionAmount'] = taxDeductionAmount;
    return data;
  }
}
