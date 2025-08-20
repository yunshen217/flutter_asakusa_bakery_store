
class ProductDetailModelFiles {
/*
{
  "id": 0,
  "createBy": "",
  "createTime": "",
  "updateBy": "",
  "updateTime": "",
  "delFlag": "",
  "fileName": "",
  "filePath": "",
  "fileKind": "",
  "businessId": 0
} 
*/

  int? id;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  String? delFlag;
  String? fileName;
  String? filePath;
  String? fileKind;
  int? businessId;

  ProductDetailModelFiles({
    this.id,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.delFlag,
    this.fileName,
    this.filePath,
    this.fileKind,
    this.businessId,
  });
  ProductDetailModelFiles.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    createBy = json['createBy']?.toString()??"";
    createTime = json['createTime']?.toString()??"";
    updateBy = json['updateBy']?.toString()??"";
    updateTime = json['updateTime']?.toString()??"";
    delFlag = json['delFlag']?.toString()??"";
    fileName = json['fileName']?.toString()??"";
    filePath = json['filePath']?.toString()??"";
    fileKind = json['fileKind']?.toString()??"";
    businessId = int.tryParse(json['businessId']?.toString() ?? '')??0;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['createBy'] = createBy;
    data['createTime'] = createTime;
    data['updateBy'] = updateBy;
    data['updateTime'] = updateTime;
    data['delFlag'] = delFlag;
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    data['fileKind'] = fileKind;
    data['businessId'] = businessId;
    return data;
  }
}

class ProductDetailModelPsIngredientsList {
/*
{
  "id": 0,
  "ingredientName": "",
  "count": 0,
  "unit": ""
} 
*/

  int? id;
  String? ingredientName;
  int? count;
  String? unit;

  ProductDetailModelPsIngredientsList({
    this.id,
    this.ingredientName,
    this.count,
    this.unit,
  });
  ProductDetailModelPsIngredientsList.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    ingredientName = json['ingredientName']?.toString()??"";
    count = int.tryParse(json['count']?.toString() ?? '')??0;
    unit = json['unit']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ingredientName'] = ingredientName;
    data['count'] = count;
    data['unit'] = unit;
    return data;
  }
}

class ProductDetailModel {
/*
{
  "id": 0,
  "itemNo": "",
  "itemName": "",
  "itemShortName": "",
  "itemKindId": 0,
  "description": "",
  "ingredients": "",
  "status": "",
  "price": 0,
  "calorie": 0,
  "weight": 0,
  "vertical": 0,
  "horizontal": 0,
  "height": 0,
  "defaultPlan": 0,
  "timePeriodId": 0,
  "allergenIdList": [
    null
  ],
  "psIngredientsList": [
    {
      "id": 0,
      "ingredientName": "",
      "count": 0,
      "unit": ""
    }
  ],
  "files": [
    {
      "id": 0,
      "createBy": "",
      "createTime": "",
      "updateBy": "",
      "updateTime": "",
      "delFlag": "",
      "fileName": "",
      "filePath": "",
      "fileKind": "",
      "businessId": 0
    }
  ]
} 
*/

  String? id;
  String? itemNo;
  String? itemName;
  String? itemShortName;
  int? itemKindId;
  String? description;
  String? ingredients;
  String? status;
  int? price;
  int? calorie;
  int? weight;
  int? vertical;
  int? horizontal;
  int? height;
  int? defaultPlan;
  int? timePeriodId;
  List? allergenIdList;
  List<ProductDetailModelPsIngredientsList?>? psIngredientsList;
  List<ProductDetailModelFiles?>? files;

  ProductDetailModel({
    this.id,
    this.itemNo,
    this.itemName,
    this.itemShortName,
    this.itemKindId,
    this.description,
    this.ingredients,
    this.status,
    this.price,
    this.calorie,
    this.weight,
    this.vertical,
    this.horizontal,
    this.height,
    this.defaultPlan,
    this.timePeriodId,
    this.allergenIdList,
    this.psIngredientsList,
    this.files,
  });
  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    itemNo = json['itemNo']?.toString() ?? '';
    itemName = json['itemName']?.toString() ?? '';
    itemShortName = json['itemShortName']?.toString() ?? '';
    itemKindId = int.tryParse(json['itemKindId']?.toString() ?? '') ?? 0;
    description = json['description']?.toString() ?? '';
    ingredients = json['ingredients']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    price = int.tryParse(json['price']?.toString() ?? '')??0;
    calorie = int.tryParse(json['calorie']?.toString() ?? '')?? 0;
    weight = int.tryParse(json['weight']?.toString() ?? '')?? 0;
    vertical = int.tryParse(json['vertical']?.toString() ?? '')?? 0;
    horizontal = int.tryParse(json['horizontal']?.toString() ?? '')?? 0;
    height = int.tryParse(json['height']?.toString() ?? '')?? 0;
    defaultPlan = int.tryParse(json['defaultPlan']?.toString() ?? '')?? 0;
    timePeriodId = int.tryParse(json['timePeriodId']?.toString() ?? '')?? 0;
    allergenIdList = json['allergenIdList']??[];
  if (json['psIngredientsList'] != null && (json['psIngredientsList'] is List)) {
  final v = json['psIngredientsList'];
  final arr0 = <ProductDetailModelPsIngredientsList>[];
  v.forEach((v) {
  arr0.add(ProductDetailModelPsIngredientsList.fromJson(v));
  });
    psIngredientsList = arr0;
    }
  if (json['files'] != null && (json['files'] is List)) {
  final v = json['files'];
  final arr0 = <ProductDetailModelFiles>[];
  v.forEach((v) {
  arr0.add(ProductDetailModelFiles.fromJson(v));
  });
    files = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['itemNo'] = itemNo;
    data['itemName'] = itemName;
    data['itemShortName'] = itemShortName;
    data['itemKindId'] = itemKindId;
    data['description'] = description;
    data['ingredients'] = ingredients;
    data['status'] = status;
    data['price'] = price;
    data['calorie'] = calorie;
    data['weight'] = weight;
    data['vertical'] = vertical;
    data['horizontal'] = horizontal;
    data['height'] = height;
    data['defaultPlan'] = defaultPlan;
    data['timePeriodId'] = timePeriodId;
    data['allergenIdList']=allergenIdList;
    if (psIngredientsList != null) {
      final v = psIngredientsList;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['psIngredientsList'] = arr0;
    }
    if (files != null) {
      final v = files;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['files'] = arr0;
    }
    return data;
  }
}
