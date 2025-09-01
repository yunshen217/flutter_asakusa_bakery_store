
class CommonSnsModel {
/*
{
  "code": "1",
  "value": "Instagram"
} 
*/

  String? code;
  String? value;

  CommonSnsModel({
    this.code,
    this.value,
  });
  CommonSnsModel.fromJson(Map<String, dynamic> json) {
    code = json['code']?.toString()??"";
    value = json['value']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['value'] = value;
    return data;
  }
}
