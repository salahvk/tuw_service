class RegionInfo {
  bool? result;
  String? message;
  List<Regions>? regions;

  RegionInfo({this.result, this.message, this.regions});

  RegionInfo.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.regions != null) {
      data['regions'] = this.regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  int? id;
  int? countryId;
  String? cityName;
  String? createdAt;
  String? updatedAt;

  Regions(
      {this.id, this.countryId, this.cityName, this.createdAt, this.updatedAt});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    cityName = json['city_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['city_name'] = this.cityName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
