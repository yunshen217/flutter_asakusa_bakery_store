
class PlansItemsModel {
/*
{
  "id": 1899640286432792600,
  "status": 2,
  "itemName": "アイスパン",
  "planCount": 8,
  "orderCount": 0,
  "stockCount": 8,
  "kindName": "パン"
  "filePath":""
} 
*/

  int? id;
  String? filePath;
  int? status;
  String? itemName;
  int? planCount;
  int? orderCount;
  int? stockCount;
  String? kindName;

  PlansItemsModel({
    this.id,
    this.filePath,
    this.status,
    this.itemName,
    this.planCount,
    this.orderCount,
    this.stockCount,
    this.kindName,
  });
  PlansItemsModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    filePath = json['filePath']?.toString()??"";
    status = int.tryParse(json['status']?.toString() ?? '')??0;
    itemName = json['itemName']?.toString()??"";
    planCount = int.tryParse(json['planCount']?.toString() ?? '')??0;
    orderCount = int.tryParse(json['orderCount']?.toString() ?? '')??0;
    stockCount = int.tryParse(json['stockCount']?.toString() ?? '')??0;
    kindName = json['kindName']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['filePath'] = filePath;
    data['status'] = status;
    data['itemName'] = itemName;
    data['planCount'] = planCount;
    data['orderCount'] = orderCount;
    data['stockCount'] = stockCount;
    data['kindName'] = kindName;
    return data;
  }
}
