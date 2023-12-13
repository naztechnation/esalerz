class MessageList {
  int? status;
  String? message;
  List<ChatData>? data;
  String? receiver;

  MessageList({this.status, this.message, this.data, this.receiver});

  MessageList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatData>[];
      json['data'].forEach((v) {
        data!.add(new ChatData.fromJson(v));
      });
    }
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['receiver'] = this.receiver;
    return data;
  }
}

class ChatData {
  String? id;
  String? receiver;
  String? sender;
  String? message;
  String? createdAt;

  ChatData({this.id, this.receiver, this.sender, this.message, this.createdAt});

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiver = json['receiver'];
    sender = json['sender'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiver'] = this.receiver;
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
