

class CategoriesList {
  int? status;
  String? message;
  List<CategoriesData>? data;

  CategoriesList({this.status, this.message, this.data});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data!.add(new CategoriesData.fromJson(v));
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

class CategoriesData {
  String? id;
  String? categName;
  String? categIcon;

  CategoriesData({this.id, this.categName, this.categIcon});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categName = json['categ_name'];
    categIcon = json['categ_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categ_name'] = this.categName;
    data['categ_icon'] = this.categIcon;
    return data;
  }
}
