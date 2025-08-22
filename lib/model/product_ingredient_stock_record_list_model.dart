
class ProductIngredientStockRecordListModel {
/*
{
  "id": "1958699933055356929",
  "ioTypeName": "仕入",
  "count": 22,
  "unitName": "kg",
  "createTime": "2025-08-22 01:17:09"
} 
*/

  String? id;
  String? ioTypeName;
  int? count;
  String? unitName;
  String? createTime;

  ProductIngredientStockRecordListModel({
    this.id,
    this.ioTypeName,
    this.count,
    this.unitName,
    this.createTime,
  });
  ProductIngredientStockRecordListModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString()??"";
    ioTypeName = json['ioTypeName']?.toString()??"";
    count = int.tryParse(json['count']?.toString() ?? '')??0;
    unitName = json['unitName']?.toString()??"";
    createTime = json['createTime']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ioTypeName'] = ioTypeName;
    data['count'] = count;
    data['unitName'] = unitName;
    data['createTime'] = createTime;
    return data;
  }
}
