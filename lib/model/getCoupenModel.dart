class GetCoupenModel {
  bool? result;
  List<Coupons>? coupons;

  GetCoupenModel({this.result, this.coupons});

  GetCoupenModel.fromJson(Map<String, dynamic> json) {
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
  String? discount;
  String? validity;
  String? conditions;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Coupons(
      {this.id,
      this.code,
      this.description,
      this.discount,
      this.validity,
      this.conditions,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    discount = json['discount'];
    validity = json['validity'];
    conditions = json['conditions'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['discount'] = discount;
    data['validity'] = validity;
    data['conditions'] = conditions;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
