class ConversationList {
  int? status;
  String? message;
  List<ConversationListData>? data;

  ConversationList({this.status, this.message, this.data});

  ConversationList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ConversationListData>[];
      json['data'].forEach((v) {
        data!.add(new ConversationListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationListData {
  String? id;
  String? receiverId;
  String? senderId;
  String? message;
  String? createdAt;
  String? partner;

  ConversationListData(
      {this.id,
      this.receiverId,
      this.senderId,
      this.message,
      this.createdAt,
      this.partner});

  ConversationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiverId = json['receiver_id'];
    senderId = json['sender_id'];
    message = json['message'];
    createdAt = json['created_at'];
    partner = json['partner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiver_id'] = this.receiverId;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['partner'] = this.partner;
    return data;
  }
}
