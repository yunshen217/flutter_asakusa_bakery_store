
class TimePeriodModelTimePeriodList {
/*
{
  "id": 0,
  "label": ""
} 
*/

  String? id;
  String? label;

  TimePeriodModelTimePeriodList({
    this.id,
    this.label,
  });
  TimePeriodModelTimePeriodList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    label = json['label']?.toString()??"";
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    return data;
  }
}

class TimePeriodModel {
/*
{
  "timePeriodList": [
    {
      "id": 0,
      "label": ""
    }
  ],
  "selectedTimePeriod": ""
} 
*/

  List<TimePeriodModelTimePeriodList?>? timePeriodList;
  String? selectedTimePeriod;

  TimePeriodModel({
    this.timePeriodList,
    this.selectedTimePeriod,
  });
  TimePeriodModel.fromJson(Map<String, dynamic> json) {
  if (json['timePeriodList'] != null && (json['timePeriodList'] is List)) {
  final v = json['timePeriodList'];
  final arr0 = <TimePeriodModelTimePeriodList>[];
  v.forEach((v) {
  arr0.add(TimePeriodModelTimePeriodList.fromJson(v));
  });
    timePeriodList = arr0;
    }
    selectedTimePeriod = json['selectedTimePeriod']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (timePeriodList != null) {
      final v = timePeriodList;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['timePeriodList'] = arr0;
    }
    data['selectedTimePeriod'] = selectedTimePeriod;
    return data;
  }
}
