class ChildServiceModel {
  bool? result;
  String? message;
  List<Childservices>? childservices;
  List<Document>? documents;
  List<Packages>? packages;

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
    if (json['documents'] != null) {
      documents = <Document>[];
      json['documents'].forEach((v) {
        documents!.add(Document.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (childservices != null) {
      data['childservices'] = childservices!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Childservices {
  int? id;
  String? serviceName;
  String? image;
  int? parentId;
  String? status;
  String? serviceImage;
  List<Childservices>? childServices;

  Childservices(
      {this.id,
      this.serviceName,
      this.image,
      this.parentId,
      this.status,
      this.serviceImage,
      this.childServices});

  Childservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    image = json['image'];
    parentId = json['parent_id'];
    status = json['status'];
    serviceImage = json['service_image'];
    // if (json['child_services'] != null) {
    //   childServices = <Null>[];
    //   json['child_services'].forEach((v) {
    //     childServices!.add(void.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_name'] = serviceName;
    data['image'] = image;
    data['parent_id'] = parentId;
    data['status'] = status;
    data['service_image'] = serviceImage;
    // if (childServices != null) {
    //   data['child_services'] =
    //       childServices!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Document {
  int? id;
  int? serviceId;
  String? document;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Document(
      {this.id,
      this.serviceId,
      this.document,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    document = json['document'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['document'] = document;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Packages {
  int? id;
  String? packageName;
  String? packageDescription;
  String? validity;
  int? amount;
  int? offerPrice;
  String? taxIds;
  List<TaxDetails>? taxDetails;

  Packages(
      {this.id,
      this.packageName,
      this.packageDescription,
      this.validity,
      this.amount,
      this.offerPrice,
      this.taxIds,
      this.taxDetails});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageName = json['package_name'];
    packageDescription = json['package_description'];
    validity = json['validity'];
    amount = json['amount'];
    offerPrice = json['offer_price'];
    taxIds = json['tax_ids'];
    if (json['tax_details'] != null) {
      taxDetails = <TaxDetails>[];
      json['tax_details'].forEach((v) {
        taxDetails!.add(TaxDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    data['package_description'] = packageDescription;
    data['validity'] = validity;
    data['amount'] = amount;
    data['offer_price'] = offerPrice;
    data['tax_ids'] = taxIds;
    if (taxDetails != null) {
      data['tax_details'] = taxDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxDetails {
  int? id;
  String? taxName;
  int? percentage;
  String? status;
  String? createdAt;
  String? updatedAt;

  TaxDetails(
      {this.id,
      this.taxName,
      this.percentage,
      this.status,
      this.createdAt,
      this.updatedAt});

  TaxDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxName = json['tax_name'];
    percentage = json['percentage'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tax_name'] = taxName;
    data['percentage'] = percentage;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
