


class AllProducts {
  int? status;
  String? message;
  List<ProductsData>? data;

  AllProducts({this.status, this.message, this.data});

  AllProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductsData>[];
      json['data'].forEach((v) {
        data!.add(new ProductsData.fromJson(v));
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

class ProductsData {
  String? id;
  String? adId;
  String? poster;
  String? title;
  String? category;
  String? adCondition;
  String? gender;
  String? age;
  String? brand;
  String? materials;
  String? weight;
  String? length;
  String? width;
  String? height;
  String? quantity;
  String? colour;
  String? breed;
  String? breedType;
  String? size;
  String? upperMaterial;
  String? outsoleMaterial;
  String? fastening;
  String? closure;
  String? capacity;
  String? exchange;
  String? movement;
  String? display;
  String? caseMaterial;
  String? bandMaterial;
  String? features;
  String? style;
  String? companyName;
  String? jobType;
  String? careerLevel;
  String? minExperience;
  String? appDeadline;
  String? address;
  String? furnishing;
  String? propertyType;
  String? parkingSpace;
  String? securedParking;
  String? squareMeter;
  String? minRentTime;
  String? ageLevel;
  String? make;
  String? model;
  String? manufactureYear;
  String? trim;
  String? secondCondition;
  String? transmission;
  String? mileage;
  String? vinNumber;
  String? registered;
  String? body;
  String? fuel;
  String? numberOfCylinders;
  String? engineSize;
  String? horsePower;
  String? createdAt;
  String? status;
  List<String>? file;

  ProductsData(
      {this.id,
      this.adId,
      this.poster,
      this.title,
      this.category,
      this.adCondition,
      this.gender,
      this.age,
      this.brand,
      this.materials,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.quantity,
      this.colour,
      this.breed,
      this.breedType,
      this.size,
      this.upperMaterial,
      this.outsoleMaterial,
      this.fastening,
      this.closure,
      this.capacity,
      this.exchange,
      this.movement,
      this.display,
      this.caseMaterial,
      this.bandMaterial,
      this.features,
      this.style,
      this.companyName,
      this.jobType,
      this.careerLevel,
      this.minExperience,
      this.appDeadline,
      this.address,
      this.furnishing,
      this.propertyType,
      this.parkingSpace,
      this.securedParking,
      this.squareMeter,
      this.minRentTime,
      this.ageLevel,
      this.make,
      this.model,
      this.manufactureYear,
      this.trim,
      this.secondCondition,
      this.transmission,
      this.mileage,
      this.vinNumber,
      this.registered,
      this.body,
      this.fuel,
      this.numberOfCylinders,
      this.engineSize,
      this.horsePower,
      this.createdAt,
      this.status,
      this.file});

  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adId = json['ad_id'];
    poster = json['poster'];
    title = json['title'];
    category = json['category'];
    adCondition = json['ad_condition'];
    gender = json['gender'];
    age = json['age'];
    brand = json['brand'];
    materials = json['materials'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    quantity = json['quantity'];
    colour = json['colour'];
    breed = json['breed'];
    breedType = json['breed_type'];
    size = json['size'];
    upperMaterial = json['upper_material'];
    outsoleMaterial = json['outsole_material'];
    fastening = json['fastening'];
    closure = json['closure'];
    capacity = json['capacity'];
    exchange = json['exchange'];
    movement = json['movement'];
    display = json['display'];
    caseMaterial = json['case_material'];
    bandMaterial = json['band_material'];
    features = json['features'];
    style = json['style'];
    companyName = json['company_name'];
    jobType = json['job_type'];
    careerLevel = json['career_level'];
    minExperience = json['min_experience'];
    appDeadline = json['app_deadline'];
    address = json['address'];
    furnishing = json['furnishing'];
    propertyType = json['property_type'];
    parkingSpace = json['parking_space'];
    securedParking = json['secured_parking'];
    squareMeter = json['square_meter'];
    minRentTime = json['min_rent_time'];
    ageLevel = json['age_level'];
    make = json['make'];
    model = json['model'];
    manufactureYear = json['manufacture_year'];
    trim = json['trim'];
    secondCondition = json['second_condition'];
    transmission = json['transmission'];
    mileage = json['mileage'];
    vinNumber = json['vin_number'];
    registered = json['registered'];
    body = json['body'];
    fuel = json['fuel'];
    numberOfCylinders = json['number_of_cylinders'];
    engineSize = json['engine_size'];
    horsePower = json['horse_power'];
    createdAt = json['created_at'];
    status = json['status'];
    file = json['file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad_id'] = this.adId;
    data['poster'] = this.poster;
    data['title'] = this.title;
    data['category'] = this.category;
    data['ad_condition'] = this.adCondition;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['brand'] = this.brand;
    data['materials'] = this.materials;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['quantity'] = this.quantity;
    data['colour'] = this.colour;
    data['breed'] = this.breed;
    data['breed_type'] = this.breedType;
    data['size'] = this.size;
    data['upper_material'] = this.upperMaterial;
    data['outsole_material'] = this.outsoleMaterial;
    data['fastening'] = this.fastening;
    data['closure'] = this.closure;
    data['capacity'] = this.capacity;
    data['exchange'] = this.exchange;
    data['movement'] = this.movement;
    data['display'] = this.display;
    data['case_material'] = this.caseMaterial;
    data['band_material'] = this.bandMaterial;
    data['features'] = this.features;
    data['style'] = this.style;
    data['company_name'] = this.companyName;
    data['job_type'] = this.jobType;
    data['career_level'] = this.careerLevel;
    data['min_experience'] = this.minExperience;
    data['app_deadline'] = this.appDeadline;
    data['address'] = this.address;
    data['furnishing'] = this.furnishing;
    data['property_type'] = this.propertyType;
    data['parking_space'] = this.parkingSpace;
    data['secured_parking'] = this.securedParking;
    data['square_meter'] = this.squareMeter;
    data['min_rent_time'] = this.minRentTime;
    data['age_level'] = this.ageLevel;
    data['make'] = this.make;
    data['model'] = this.model;
    data['manufacture_year'] = this.manufactureYear;
    data['trim'] = this.trim;
    data['second_condition'] = this.secondCondition;
    data['transmission'] = this.transmission;
    data['mileage'] = this.mileage;
    data['vin_number'] = this.vinNumber;
    data['registered'] = this.registered;
    data['body'] = this.body;
    data['fuel'] = this.fuel;
    data['number_of_cylinders'] = this.numberOfCylinders;
    data['engine_size'] = this.engineSize;
    data['horse_power'] = this.horsePower;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['file'] = this.file;
    return data;
  }
}
