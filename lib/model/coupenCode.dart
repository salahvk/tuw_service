class CoupenCode {
  bool? result;
  List<Coupons>? coupons;

  CoupenCode({this.result, this.coupons});

  CoupenCode.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (coupons != null) {
      data['coupons'] = coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  int? id;
  String? code;
  String? description;
  int? offerPrice;
  String? validity;
  String? conditions;
  // void? rememberToken;
  String? createdAt;
  String? updatedAt;
  // void? deletedAt;

  Coupons({
    this.id,
    this.code,
    this.description,
    this.offerPrice,
    this.validity,
    this.conditions,
    // this.rememberToken,
    this.createdAt,
    this.updatedAt,
    // this.deletedAt
  });

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    offerPrice = json['offer_price'];
    validity = json['validity'];
    conditions = json['conditions'];
    // rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['offer_price'] = offerPrice;
    data['validity'] = validity;
    data['conditions'] = conditions;
    // data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['deleted_at'] = deletedAt;
    return data;
  }
}
