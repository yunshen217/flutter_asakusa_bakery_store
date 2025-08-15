class DetailModel {
  final String id;
  final String merchantName;
  final String merchantDescription;
  final String postcode;
  final String streetAddress;
  final String building;
  final String phoneNumber;
  final String eatingArea;
  final int approvalDays;
  final int deadLineDays;
  final String deadLineTime;
  final String businessHoursBegin;
  final String businessHoursEnd;
  final String storeHomepageLink;
  final String pointRate;
  final List<String> fixedHoliday;
  final List<String> specialRestDayList;
  final String prefectures;
  final String prefecturesCodeName;
  final String municipalities;
  final String snsType1;
  final String snsType2;
  final String snsType3;
  final String snsType4;
  final String snsLink1;
  final String snsLink2;
  final String snsLink3;
  final String snsLink4;
  final int customerOrderLimit;
  final int customerDailyOrderLimit;
  final int revItemCountLimit;
  final int revAmountLimit;
  final String email;
  final List<FileModel> files;

  DetailModel({
    this.id = "",
    this.merchantName = '',
    this.merchantDescription = '',
    this.postcode = '',
    this.streetAddress = '',
    this.building = '',
    this.phoneNumber = '',
    this.eatingArea = '',
    this.approvalDays = 0,
    this.deadLineDays = 0,
    this.deadLineTime = '',
    this.businessHoursBegin = '',
    this.businessHoursEnd = '',
    this.storeHomepageLink = '',
    this.pointRate = "",
    this.fixedHoliday = const [],
    this.specialRestDayList = const [],
    this.prefectures = '',
    this.prefecturesCodeName = '',
    this.municipalities = '',
    this.snsType1 = '',
    this.snsType2 = '',
    this.snsType3 = '',
    this.snsType4 = '',
    this.snsLink1 = '',
    this.snsLink2 = '',
    this.snsLink3 = '',
    this.snsLink4 = '',
    this.customerOrderLimit = 0,
    this.customerDailyOrderLimit = 0,
    this.revItemCountLimit = 0,
    this.revAmountLimit = 0,
    this.email = '',
    this.files = const [],
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'] ?? "",
      merchantName: json['merchantName'] ?? '',
      merchantDescription: json['merchantDescription'] ?? '',
      postcode: json['postcode'] ?? '',
      streetAddress: json['streetAddress'] ?? '',
      building: json['building'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      eatingArea: json['eatingArea'] ?? '',
      approvalDays: int.tryParse(json['approvalDays'].toString()) ?? 0,
      deadLineDays: json['deadLineDays'] ?? 0,
deadLineTime: json['deadLineTime'] ??'',
      businessHoursBegin: json['businessHoursBegin'] ??'',
      businessHoursEnd: json['businessHoursEnd'] ??'',
      storeHomepageLink: json['storeHomepageLink'] ?? '',
      pointRate: json['pointRate'] ?? "",
      fixedHoliday: List<String>.from(json['fixedHoliday'] ?? []),
      specialRestDayList: List<String>.from(json['specialRestDayList'] ?? []),
      prefectures: json['prefectures'] ?? '',
      prefecturesCodeName: json['prefecturesCodeName'] ?? '',
      municipalities: json['municipalities'] ?? '',
      snsType1: json['snsType1'] ?? '',
      snsType2: json['snsType2'] ?? '',
      snsType3: json['snsType3'] ?? '',
      snsType4: json['snsType4'] ?? '',
      snsLink1: json['snsLink1'] ?? '',
      snsLink2: json['snsLink2'] ?? '',
      snsLink3: json['snsLink3'] ?? '',
      snsLink4: json['snsLink4'] ?? '',
      customerOrderLimit: json['customerOrderLimit'] ?? 0,
      customerDailyOrderLimit: json['customerDailyOrderLimit'] ?? 0,
      revItemCountLimit: json['revItemCountLimit'] ?? 0,
      revAmountLimit: json['revAmountLimit'] ?? 0,
      email: json['email'] ?? '',
      files: List<FileModel>.from(
        (json['files'] ?? []).map((file) => FileModel.fromJson(file)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'merchantName': merchantName,
        'merchantDescription': merchantDescription,
        'postcode': postcode,
        'streetAddress': streetAddress,
        'building': building,
        'phoneNumber': phoneNumber,
        'eatingArea': eatingArea,
        'approvalDays': approvalDays,
        'deadLineDays': deadLineDays,
        'deadLineTime': deadLineTime,
        'businessHoursBegin': businessHoursBegin,
        'businessHoursEnd': businessHoursEnd,
        'storeHomepageLink': storeHomepageLink,
        'pointRate': pointRate,
        'fixedHoliday': fixedHoliday,
        'specialRestDayList': specialRestDayList,
        'prefectures': prefectures,
        'prefecturesCodeName': prefecturesCodeName,
        'municipalities': municipalities,
        'snsType1': snsType1,
        'snsType2': snsType2,
        'snsType3': snsType3,
        'snsType4': snsType4,
        'snsLink1': snsLink1,
        'snsLink2': snsLink2,
        'snsLink3': snsLink3,
        'snsLink4': snsLink4,
        'customerOrderLimit': customerOrderLimit,
        'customerDailyOrderLimit': customerDailyOrderLimit,
        'revItemCountLimit': revItemCountLimit,
        'revAmountLimit': revAmountLimit,
        'email': email,
        'files': List<dynamic>.from(files.map((file) => file.toJson())),
      };
}

class FileModel {
  final String id;
  final String createBy;
  final String createTime;
  final String updateBy;
  final String updateTime;
  final String delFlag;
  final String fileName;
  final String filePath;
  final String fileKind;
  final String businessId;

  FileModel({
    this.id = '',
    this.createBy = '',
    this.createTime = '',
    this.updateBy = '',
    this.updateTime = '',
    this.delFlag = '',
    this.fileName = '',
    this.filePath = '',
    this.fileKind = '',
    this.businessId = '',
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] ?? '',
      createBy: json['createBy'] ?? '',
      createTime: json['createTime'] ?? '',
      updateBy: json['updateBy'] ?? '',
      updateTime: json['updateTime'] ?? '',
      delFlag: json['delFlag'] ?? '',
      fileName: json['fileName'] ?? '',
      filePath: json['filePath'] ?? '',
      fileKind: json['fileKind'] ?? '',
      businessId: json['businessId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createBy': createBy,
        'createTime': createTime,
        'updateBy': updateBy,
        'updateTime': updateTime,
        'delFlag': delFlag,
        'fileName': fileName,
        'filePath': filePath,
        'fileKind': fileKind,
        'businessId': businessId,
      };
}
