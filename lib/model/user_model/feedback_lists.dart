

class FeedbackList {
  int? status;
  String? message;
  List<FeedbackData>? data;

  FeedbackList({this.status, this.message, this.data});

  FeedbackList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeedbackData>[];
      json['data'].forEach((v) {
        data!.add(new FeedbackData.fromJson(v));
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

class FeedbackData {
  String? user;
  String? adId;
  String? message;
  String? rating;
  String? fullName;

  FeedbackData({this.user, this.adId, this.message, this.rating, this.fullName});

  FeedbackData.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    adId = json['ad_id'];
    message = json['message'];
    rating = json['rating'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['ad_id'] = this.adId;
    data['message'] = this.message;
    data['rating'] = this.rating;
    data['full_name'] = this.fullName;
    return data;
  }
}
