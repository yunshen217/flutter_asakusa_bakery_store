
class DetailModelPsFiles {
/*
{
  "id": 1875771216833917000,
  "createBy": null,
  "createTime": null,
  "updateBy": null,
  "updateTime": null,
  "delFlag": 0,
  "fileName": "855aa3fd-360f-4073-8c1b-ee2f13bd773c_20250105_140802.png",
  "filePath": "/images/",
  "fileKind": 1,
  "businessId": 1816640958868603000
} 
*/

  int? id;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  int? delFlag;
  String? fileName;
  String? filePath;
  int? fileKind;
  int? businessId;

  DetailModelPsFiles({
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
  DetailModelPsFiles.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    createBy = json['createBy']?.toString()??"";
    createTime = json['createTime']?.toString()??"";
    updateBy = json['updateBy']?.toString()??"";
    updateTime = json['updateTime']?.toString()??"";
    delFlag = int.tryParse(json['delFlag']?.toString() ?? '')??0;
    fileName = json['fileName']?.toString()??'';
    filePath = json['filePath']?.toString()??'';
    fileKind = int.tryParse(json['fileKind']?.toString() ?? '')??0;
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

class DetailModel {
/*
{
  "id": 1816640958868603000,
  "merchantName": "テスト　ベーカリー",
  "merchantDescription": "浅草発祥の無添加パン屋です。 テスト234",
  "postcode": "3400032",
  "streetAddress": "509-1",
  "building": "",
  "phoneNumber": "070-8386-8886",
  "eatingArea": 0,
  "approvalDays": 22,
  "deadLineDays": 1,
  "deadLineTime": "19:00:00",
  "businessHoursBegin": "10:00:00",
  "businessHoursEnd": "18:00:00",
  "storeHomepageLink": "",
  "pointRate": 1,
  "fixedHoliday": [
    7
  ],
  "specialRestDayList": [
    "2024-08-15"
  ],
  "prefectures": 11,
  "prefecturesCodeName": "埼玉県",
  "municipalities": "草加市遊馬町",
  "snsType1": 4,
  "snsType2": 3,
  "snsType3": 3,
  "snsType4": 3,
  "snsLink1": "https://www.instagram.com/asakusabakery",
  "snsLink2": "https://www.google.com",
  "snsLink3": "t",
  "snsLink4": "test",
  "customerOrderLimit": 10000,
  "customerDailyOrderLimit": 15000,
  "revItemCountLimit": 300,
  "revAmountLimit": 50000,
  "email": "",
  "psFiles": [
    {
      "id": 1875771216833917000,
      "createBy": null,
      "createTime": null,
      "updateBy": null,
      "updateTime": null,
      "delFlag": 0,
      "fileName": "855aa3fd-360f-4073-8c1b-ee2f13bd773c_20250105_140802.png",
      "filePath": "/images/",
      "fileKind": 1,
      "businessId": 1816640958868603000
    }
  ]
} 
*/

  int? id;
  String? merchantName;
  String? merchantDescription;
  String? postcode;
  String? streetAddress;
  String? building;
  String? phoneNumber;
  int? eatingArea;
  int? approvalDays;
  int? deadLineDays;
  String? deadLineTime;
  String? businessHoursBegin;
  String? businessHoursEnd;
  String? storeHomepageLink;
  int? pointRate;
  List<int?>? fixedHoliday;
  List<String?>? specialRestDayList;
  int? prefectures;
  String? prefecturesCodeName;
  String? municipalities;
  int? snsType1;
  int? snsType2;
  int? snsType3;
  int? snsType4;
  String? snsLink1;
  String? snsLink2;
  String? snsLink3;
  String? snsLink4;
  int? customerOrderLimit;
  int? customerDailyOrderLimit;
  int? revItemCountLimit;
  int? revAmountLimit;
  String? email;
  List<DetailModelPsFiles?>? psFiles;

  DetailModel({
    this.id,
    this.merchantName,
    this.merchantDescription,
    this.postcode,
    this.streetAddress,
    this.building,
    this.phoneNumber,
    this.eatingArea,
    this.approvalDays,
    this.deadLineDays,
    this.deadLineTime,
    this.businessHoursBegin,
    this.businessHoursEnd,
    this.storeHomepageLink,
    this.pointRate,
    this.fixedHoliday,
    this.specialRestDayList,
    this.prefectures,
    this.prefecturesCodeName,
    this.municipalities,
    this.snsType1,
    this.snsType2,
    this.snsType3,
    this.snsType4,
    this.snsLink1,
    this.snsLink2,
    this.snsLink3,
    this.snsLink4,
    this.customerOrderLimit,
    this.customerDailyOrderLimit,
    this.revItemCountLimit,
    this.revAmountLimit,
    this.email,
    this.psFiles,
  });
  DetailModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '')??0;
    merchantName = json['merchantName']?.toString()??'';
    merchantDescription = json['merchantDescription']?.toString()??'';
    postcode = json['postcode']?.toString()??'';
    streetAddress = json['streetAddress']?.toString()??'';
    building = json['building']?.toString()??'';
    phoneNumber = json['phoneNumber']?.toString()??'';
    eatingArea = int.tryParse(json['eatingArea']?.toString() ?? '')??0;
    approvalDays = int.tryParse(json['approvalDays']?.toString() ?? '')??0;
    deadLineDays = int.tryParse(json['deadLineDays']?.toString() ?? '')??0;
    deadLineTime = json['deadLineTime']?.toString()??'';
    businessHoursBegin = json['businessHoursBegin']?.toString()??'';
    businessHoursEnd = json['businessHoursEnd']?.toString()??'';
    storeHomepageLink = json['storeHomepageLink']?.toString()??'';
    pointRate = int.tryParse(json['pointRate']?.toString() ?? '')??0;
  if (json['fixedHoliday'] != null && (json['fixedHoliday'] is List)) {
  final v = json['fixedHoliday'];
  final arr0 = <int>[];
  v.forEach((v) {
  arr0.add(int.tryParse(v.toString())??0);
  });
    fixedHoliday = arr0;
    }
  if (json['specialRestDayList'] != null && (json['specialRestDayList'] is List)) {
  final v = json['specialRestDayList'];
  final arr0 = <String>[];
  v.forEach((v) {
  arr0.add(v.toString());
  });
    specialRestDayList = arr0;
    }
    prefectures = int.tryParse(json['prefectures']?.toString() ?? '')??0;
    prefecturesCodeName = json['prefecturesCodeName']?.toString()??"";
    municipalities = json['municipalities']?.toString()??'';
    snsType1 = int.tryParse(json['snsType1']?.toString() ?? '')??0;
    snsType2 = int.tryParse(json['snsType2']?.toString() ?? '')??0;
    snsType3 = int.tryParse(json['snsType3']?.toString() ?? '')??0;
    snsType4 = int.tryParse(json['snsType4']?.toString() ?? '')??0;
    snsLink1 = json['snsLink1']?.toString()??"";
    snsLink2 = json['snsLink2']?.toString()??"";
    snsLink3 = json['snsLink3']?.toString()??"";
    snsLink4 = json['snsLink4']?.toString()??"";
    customerOrderLimit = int.tryParse(json['customerOrderLimit']?.toString() ?? '')??0;
    customerDailyOrderLimit = int.tryParse(json['customerDailyOrderLimit']?.toString() ?? '')??0;
    revItemCountLimit = int.tryParse(json['revItemCountLimit']?.toString() ?? '')??0;
    revAmountLimit = int.tryParse(json['revAmountLimit']?.toString() ?? '')??0;
    email = json['email']?.toString()??"";
  if (json['psFiles'] != null && (json['psFiles'] is List)) {
  final v = json['psFiles'];
  final arr0 = <DetailModelPsFiles>[];
  v.forEach((v) {
  arr0.add(DetailModelPsFiles.fromJson(v));
  });
    psFiles = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['merchantName'] = merchantName;
    data['merchantDescription'] = merchantDescription;
    data['postcode'] = postcode;
    data['streetAddress'] = streetAddress;
    data['building'] = building;
    data['phoneNumber'] = phoneNumber;
    data['eatingArea'] = eatingArea;
    data['approvalDays'] = approvalDays;
    data['deadLineDays'] = deadLineDays;
    data['deadLineTime'] = deadLineTime;
    data['businessHoursBegin'] = businessHoursBegin;
    data['businessHoursEnd'] = businessHoursEnd;
    data['storeHomepageLink'] = storeHomepageLink;
    data['pointRate'] = pointRate;
    if (fixedHoliday != null) {
      final v = fixedHoliday;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v);
  });
      data['fixedHoliday'] = arr0;
    }
    if (specialRestDayList != null) {
      final v = specialRestDayList;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v);
  });
      data['specialRestDayList'] = arr0;
    }
    data['prefectures'] = prefectures;
    data['prefecturesCodeName'] = prefecturesCodeName;
    data['municipalities'] = municipalities;
    data['snsType1'] = snsType1;
    data['snsType2'] = snsType2;
    data['snsType3'] = snsType3;
    data['snsType4'] = snsType4;
    data['snsLink1'] = snsLink1;
    data['snsLink2'] = snsLink2;
    data['snsLink3'] = snsLink3;
    data['snsLink4'] = snsLink4;
    data['customerOrderLimit'] = customerOrderLimit;
    data['customerDailyOrderLimit'] = customerDailyOrderLimit;
    data['revItemCountLimit'] = revItemCountLimit;
    data['revAmountLimit'] = revAmountLimit;
    data['email'] = email;
    if (psFiles != null) {
      final v = psFiles;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['psFiles'] = arr0;
    }
    return data;
  }
}
