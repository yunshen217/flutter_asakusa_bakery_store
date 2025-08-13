class CommonSearchParamModelItemKindList {
/*
{
  "id": 1,
  "kindName": "パン"
} 
*/

  int? id;
  String? kindName;

  CommonSearchParamModelItemKindList({
    this.id,
    this.kindName,
  });
  CommonSearchParamModelItemKindList.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '') ?? 0;
    kindName = json['kindName']?.toString() ?? "";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['kindName'] = kindName;
    return data;
  }
}

class CommonSearchParamModel {
/*
{
  "itemKindList": [
    {
      "id": 1,
      "kindName": "パン"
    }
  ]
} 
*/

  List<CommonSearchParamModelItemKindList?>? itemKindList;

  CommonSearchParamModel({
    this.itemKindList,
  });
  CommonSearchParamModel.fromJson(Map<String, dynamic> json) {
    if (json['itemKindList'] != null && (json['itemKindList'] is List)) {
      final v = json['itemKindList'];
      final arr0 = <CommonSearchParamModelItemKindList>[];
      v.forEach((v) {
        arr0.add(CommonSearchParamModelItemKindList.fromJson(v));
      });
      itemKindList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (itemKindList != null) {
      final v = itemKindList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['itemKindList'] = arr0;
    }
    return data;
  }
}
