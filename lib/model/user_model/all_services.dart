class AllServices {
  int? status;
  String? message;
  List<AllServicesData>? data;

  AllServices({this.status, this.message, this.data});

  AllServices.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllServicesData>[];
      json['data'].forEach((v) {
        data!.add(new AllServicesData.fromJson(v));
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

class AllServicesData {
  String? id;
  String? name;
  String? serviceIcon;

  AllServicesData({this.id, this.name, this.serviceIcon});

  AllServicesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceIcon = json['service_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service_icon'] = this.serviceIcon;
    return data;
  }
}
