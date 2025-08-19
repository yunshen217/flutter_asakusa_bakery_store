class TimePeriodModelTimePeriodList {
/*
{
  "id": 3,
  "label": "08:00~09:00"
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
      "id": 3,
      "label": "08:00~09:00"
    }
  ],
  "selectedTimePeriod": [
    10
  ]
} 
*/

  List<TimePeriodModelTimePeriodList?>? timePeriodList;
  List<int?>? selectedTimePeriod;

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
  if (json['selectedTimePeriod'] != null && (json['selectedTimePeriod'] is List)) {
    final v = json['selectedTimePeriod'];
    final arr0 = <int>[];
    v.forEach((v) {
      final parsedInt = int.tryParse(v.toString());
      if (parsedInt != null) {
        arr0.add(parsedInt);
      }
    });
    selectedTimePeriod = arr0;
  }
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
    if (selectedTimePeriod != null) {
      final v = selectedTimePeriod;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v);
  });
      data['selectedTimePeriod'] = arr0;
    }
    return data;
  }
}
