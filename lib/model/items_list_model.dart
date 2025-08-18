
class ItemsListModel {
/*
{
  "id": 0,
  "filePath": "",
  "itemName": "",
  "totalSaleCount": 0,
  "status": ""
} 
*/

  int? id;
  String? filePath;
  String? itemName;
  int? totalSaleCount;
  String? status;

  ItemsListModel({
    this.id,
    this.filePath,
    this.itemName,
    this.totalSaleCount,
    this.status,
  });
  ItemsListModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    filePath = json['filePath']?.toString()??"";
    itemName = json['itemName']?.toString()??"";
    totalSaleCount = int.tryParse(json['totalSaleCount']?.toString() ?? '')??0;
    status = json['status']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['filePath'] = filePath;
    data['itemName'] = itemName;
    data['totalSaleCount'] = totalSaleCount;
    data['status'] = status;
    return data;
  }
}
