class ChildServiceModel {
  bool? result;
  String? message;
  List<Childservices>? childservices;
  List<void>? documents;
  List<void>? packages;

  ChildServiceModel(
      {this.result,
      this.message,
      this.childservices,
      this.documents,
      this.packages});

  ChildServiceModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['childservices'] != null) {
      childservices = <Childservices>[];
      json['childservices'].forEach((v) {
        childservices!.add(Childservices.fromJson(v));
      });
    }
    // if (json['documents'] != null) {
    //   documents = <Null>[];
    //   json['documents'].forEach((v) {
    //     documents!.add(void.fromJson(v));
    //   });
    // }
    // if (json['packages'] != null) {
    //   packages = <Null>[];
    //   json['packages'].forEach((v) {
    //     packages!.add(void.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (childservices != null) {
      data['childservices'] = childservices!.map((v) => v.toJson()).toList();
    }
    // if (documents != null) {
    //   data['documents'] = documents!.map((v) => v.toJson()).toList();
    // }
    // if (packages != null) {
    //   data['packages'] = packages!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Childservices {
  int? id;
  String? service;
  String? image;
  String? countryIds;
  String? status;
  int? parentId;
  // void? serviceLanguageId;
  String? createdAt;
  String? updatedAt;
  List<Childservices>? childServices;

  Childservices(
      {this.id,
      this.service,
      this.image,
      this.countryIds,
      this.status,
      this.parentId,
      // this.serviceLanguageId,
      this.createdAt,
      this.updatedAt,
      this.childServices});

  Childservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    image = json['image'];
    countryIds = json['country_ids'];
    status = json['status'];
    parentId = json['parent_id'];
    // serviceLanguageId = json['service_language_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['child_services'] != null) {
      childServices = <Childservices>[];
      json['child_services'].forEach((v) {
        childServices!.add(Childservices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['image'] = image;
    data['country_ids'] = countryIds;
    data['status'] = status;
    data['parent_id'] = parentId;
    // data['service_language_id'] = serviceLanguageId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (childServices != null) {
      data['child_services'] = childServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
