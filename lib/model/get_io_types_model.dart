
class GetIoTypesModel {
/*
{
  "id": 0,
  "createBy": "",
  "createTime": "",
  "updateBy": "",
  "updateTime": "",
  "delFlag": "",
  "category": "",
  "code": "",
  "value": "",
  "comm": ""
} 
*/

  String? id;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  String? delFlag;
  String? category;
  String? code;
  String? value;
  String? comm;

  GetIoTypesModel({
    this.id,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.delFlag,
    this.category,
    this.code,
    this.value,
    this.comm,
  });
  GetIoTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    createBy = json['createBy']?.toString()??"";
    createTime = json['createTime']?.toString()??"";
    updateBy = json['updateBy']?.toString()??"";
    updateTime = json['updateTime']?.toString()??"";
    delFlag = json['delFlag']?.toString()??"";
    category = json['category']?.toString()??"";
    code = json['code']?.toString()??"";
    value = json['value']?.toString()??"";
    comm = json['comm']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['createBy'] = createBy;
    data['createTime'] = createTime;
    data['updateBy'] = updateBy;
    data['updateTime'] = updateTime;
    data['delFlag'] = delFlag;
    data['category'] = category;
    data['code'] = code;
    data['value'] = value;
    data['comm'] = comm;
    return data;
  }
}
