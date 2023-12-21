class AuthUser {
  int? status;
  String? message;
  String? bkey;
  Data? data;

  AuthUser({this.status, this.message, this.bkey, this.data});

  AuthUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bkey = json['bkey'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['bkey'] = this.bkey;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? id;
  String? fullName;
  String? phone;
  String? status;
  Null? photo;

  Data(
      {this.email,
      this.id,
      this.fullName,
      this.phone,
      this.status,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    status = json['status'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['photo'] = this.photo;
    return data;
  }
}
