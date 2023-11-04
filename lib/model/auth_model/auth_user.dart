class AuthUser {
  int? status;
  String? message;
  UserData? data;

  AuthUser({this.status, this.message, this.data});

  AuthUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  String? email;
  String? fullName;
  String? phone;
  String? status;
  String? photo;
  String? bkey;

  UserData(
      {this.email,
      this.fullName,
      this.phone,
      this.status,
      this.photo,
      this.bkey});

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    status = json['status'];
    photo = json['photo'];
    bkey = json['bkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['bkey'] = this.bkey;
    return data;
  }
}
