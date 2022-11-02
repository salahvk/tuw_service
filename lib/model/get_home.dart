class HomeModel {
  bool? result;
  String? message;
  List<Services>? services;
  List<Homebanner>? homebanner;

  HomeModel({this.result, this.message, this.services, this.homebanner});

  HomeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['homebanner'] != null) {
      homebanner = <Homebanner>[];
      json['homebanner'].forEach((v) {
        homebanner!.add(Homebanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (homebanner != null) {
      data['homebanner'] = homebanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? service;
  String? image;

  Services({this.id, this.service, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['image'] = image;
    return data;
  }
}

class Homebanner {
  int? id;
  int? sliderId;
  String? image;
  String? title;
  String? description;
  String? target;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Homebanner(
      {this.id,
      this.sliderId,
      this.image,
      this.title,
      this.description,
      this.target,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Homebanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderId = json['slider_id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    target = json['target'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slider_id'] = sliderId;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['target'] = target;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
