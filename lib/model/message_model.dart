
class MessageModel {
/*
{
  "id": "",
  "messageType": "",
  "businessId": 0,
  "title": "",
  "message": "",
  "readFlag": "",
  "receiverId": 0,
  "senderId": 0,
  "createTime":""
} 
*/

  String? id;
  String? messageType;
  int? businessId;
  String? title;
  String? message;
  String? readFlag;
  int? receiverId;
  int? senderId;
  String? createTime;

  MessageModel({
    this.id,
    this.messageType,
    this.businessId,
    this.title,
    this.message,
    this.readFlag,
    this.receiverId,
    this.senderId,
    this.createTime
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString()??"";
    messageType = json['messageType']?.toString()??"";
    businessId = int.tryParse(json['businessId']?.toString() ?? '')??0;
    title = json['title']?.toString()??"";
    message = json['message']?.toString()??"";
    readFlag = json['readFlag']?.toString()??"";
    receiverId = int.tryParse(json['receiverId']?.toString() ?? '')??0;
    senderId = int.tryParse(json['senderId']?.toString() ?? '')??0;
    createTime = json['createTime']?.toString()??"";

  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['messageType'] = messageType;
    data['businessId'] = businessId;
    data['title'] = title;
    data['message'] = message;
    data['readFlag'] = readFlag;
    data['receiverId'] = receiverId;
    data['senderId'] = senderId;
    data['createTime']=createTime;
    return data;
  }
}
