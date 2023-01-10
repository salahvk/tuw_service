class ShowUserAddress {
  bool? result;
  String? message;
  UserAddress? userAddress;

  ShowUserAddress({this.result, this.message, this.userAddress});

  ShowUserAddress.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    userAddress = json['user_address'] != null
        ? UserAddress.fromJson(json['user_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (userAddress != null) {
      data['user_address'] = userAddress!.toJson();
    }
    return data;
  }
}

class UserAddress {
  int? id;
  int? userId;
  String? addressName;
  String? address;
  int? countryId;
  String? region;
  String? image;
  String? state;
  String? homeNo;
  String? createdAt;
  String? updatedAt;
  String? country;
  String? latitude;
  String? longitude;

  UserAddress(
      {this.id,
      this.userId,
      this.addressName,
      this.address,
      this.countryId,
      this.region,
      this.image,
      this.state,
      this.homeNo,
      this.createdAt,
      this.updatedAt,
      this.country,
      this.latitude,
      this.longitude});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    address = json['address'];
    countryId = json['country_id'];
    region = json['region'];
    image = json['image'];
    state = json['state'];
    homeNo = json['home_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['address'] = address;
    data['country_id'] = countryId;
    data['region'] = region;
    data['image'] = image;
    data['state'] = state;
    data['home_no'] = homeNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
