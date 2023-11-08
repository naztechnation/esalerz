class NotificationsInfo {
  int? status;
  String? message;
  List<NotificationsData>? data;

  NotificationsInfo({this.status, this.message, this.data});

  NotificationsInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationsData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationsData.fromJson(v));
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

class NotificationsData {
  String? id;
  String? title;
  String? message;
  String? isRead;
  String? createdAt;

  NotificationsData({this.id, this.title, this.message, this.isRead, this.createdAt});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}
