class OtherUserAddress {
  bool? result;
  String? message;
  List<UserAddressData>? userAddress;

  OtherUserAddress({this.result, this.message, this.userAddress});

  OtherUserAddress.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['user_address'] != null) {
      userAddress = <UserAddressData>[];
      json['user_address'].forEach((v) {
        userAddress!.add(UserAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (userAddress != null) {
      data['user_address'] = userAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddressData {
  int? id;
  int? userId;
  String? addressName;
  String? address;
  int? countryId;
  var region;
  String? state;
  String? homeNo;
  String? createdAt;
  String? updatedAt;
  String? country;

  UserAddressData(
      {this.id,
      this.userId,
      this.addressName,
      this.address,
      this.countryId,
      this.region,
      this.state,
      this.homeNo,
      this.createdAt,
      this.updatedAt,
      this.country});

  UserAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressName = json['address_name'];
    address = json['address'];
    countryId = json['country_id'];
    region = json['region'];
    state = json['state'];
    homeNo = json['home_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address_name'] = addressName;
    data['address'] = address;
    data['country_id'] = countryId;
    data['region'] = region;
    data['state'] = state;
    data['home_no'] = homeNo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country'] = country;
    return data;
  }
}
