
class PostCodeModel {
/*
{
  "prefecturesCode": 11,
  "prefectures": "埼玉県",
  "municipalities": "草加市新里町"
} 
*/

  int? prefecturesCode;
  String? prefectures;
  String? municipalities;

  PostCodeModel({
    this.prefecturesCode,
    this.prefectures,
    this.municipalities,
  });
  PostCodeModel.fromJson(Map<String, dynamic> json) {
    prefecturesCode = int.tryParse(json['prefecturesCode']?.toString() ?? '')??0;
    prefectures = json['prefectures']?.toString()??"";
    municipalities = json['municipalities']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['prefecturesCode'] = prefecturesCode;
    data['prefectures'] = prefectures;
    data['municipalities'] = municipalities;
    return data;
  }
}
