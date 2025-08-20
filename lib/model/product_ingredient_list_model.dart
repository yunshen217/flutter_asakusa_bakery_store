
class ProductIngredientListModel {
/*
{
  "id": 0,
  "ingredientName": "",
  "count": 0,
  "unit": "",
  "minUnitId":""
} 
*/

  String? id;
  String? ingredientName;
  String? count;
  String? unit;
  String? minUnitId;

  ProductIngredientListModel({
    this.id,
    this.ingredientName,
    this.count,
    this.unit,
    this.minUnitId
  });
  ProductIngredientListModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    ingredientName = json['ingredientName']?.toString()??"";
    count = json['count']?.toString() ?? '';
    unit = json['unit']?.toString()??"";
    minUnitId = json['minUnitId']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ingredientName'] = ingredientName;
    data['count'] = count;
    data['unit'] = unit;
    data["minUnitId"]=minUnitId;
    return data;
  }
}
