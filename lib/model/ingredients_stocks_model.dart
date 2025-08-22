
class IngredientsStocksModel {
/*
{
  "id": 0,
  "merchantId":"",
  "ingredientName": "",
  "countUnitName": "",
  "recordCountUnitName": "",
  "isAllergen": "",
  "minUnitId": 0,
  "displayUnitId": 0,
  "purchaseThreshold": 0
} 
*/

  int? id;
  String? merchantId;
  String? ingredientName;
  String? countUnitName;
  String? recordCountUnitName;
  String? isAllergen;
  int? minUnitId;
  int? displayUnitId;
  int? purchaseThreshold;

  IngredientsStocksModel({
    this.id,
    this.merchantId,
    this.ingredientName,
    this.countUnitName,
    this.recordCountUnitName,
    this.isAllergen,
    this.minUnitId,
    this.displayUnitId,
    this.purchaseThreshold,
  });
  IngredientsStocksModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    merchantId = json["merchantId"]?.toString()??"";
    ingredientName = json['ingredientName']?.toString()??"";
    countUnitName = json['countUnitName']?.toString()??"";
    recordCountUnitName = json['recordCountUnitName']?.toString()??"";
    isAllergen = json['isAllergen']?.toString()??'';
    minUnitId = int.tryParse(json['minUnitId']?.toString() ?? '')??0;
    displayUnitId = int.tryParse(json['displayUnitId']?.toString() ?? '')??0;
    purchaseThreshold = int.tryParse(json['purchaseThreshold']?.toString() ?? '')??0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data["merchantId"] = merchantId;
    data['ingredientName'] = ingredientName;
    data['countUnitName'] = countUnitName;
    data['recordCountUnitName'] = recordCountUnitName;
    data['isAllergen'] = isAllergen;
    data['minUnitId'] = minUnitId;
    data['displayUnitId'] = displayUnitId;
    data['purchaseThreshold'] = purchaseThreshold;
    return data;
  }
}
