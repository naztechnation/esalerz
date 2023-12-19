

class AdsOptions {
  int? status;
  String? message;
  List<AdsOptionsData>? data;

  AdsOptions({this.status, this.message, this.data});

  AdsOptions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AdsOptionsData>[];
      json['data'].forEach((v) {
        data!.add(new AdsOptionsData.fromJson(v));
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

class AdsOptionsData {
  String? id;
  String? categId;
  String? paramName;
  String? paramValues;
  String? paramType;

  AdsOptionsData(
      {this.id,
      this.categId,
      this.paramName,
      this.paramValues,
      this.paramType});

  AdsOptionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categId = json['categ_id'];
    paramName = json['param_name'];
    paramValues = json['param_values'];
    paramType = json['param_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categ_id'] = this.categId;
    data['param_name'] = this.paramName;
    data['param_values'] = this.paramValues;
    data['param_type'] = this.paramType;
    return data;
  }
}
