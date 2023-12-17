class ServicesSubCat {
  int? status;
  String? message;
  List<ServicesSubCatData>? data;

  ServicesSubCat({this.status, this.message, this.data});

  ServicesSubCat.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServicesSubCatData>[];
      json['data'].forEach((v) {
        data!.add(new ServicesSubCatData.fromJson(v));
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

class ServicesSubCatData {
  String? id;
  String? childName;
  String? childIcon;
  String? serviceParent;

  ServicesSubCatData({this.id, this.childName, this.childIcon, this.serviceParent});

  ServicesSubCatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childName = json['child_name'];
    childIcon = json['child_icon'];
    serviceParent = json['service_parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_name'] = this.childName;
    data['child_icon'] = this.childIcon;
    data['service_parent'] = this.serviceParent;
    return data;
  }
}
