

class NotificationsDetail {
  int? status;
  String? message;
  DetailsData? data;

  NotificationsDetail({this.status, this.message, this.data});

  NotificationsDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DetailsData {
  String? id;
  String? title;
  String? message;
  String? isRead;

  DetailsData({this.id, this.title, this.message, this.isRead});

  DetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    return data;
  }
}
