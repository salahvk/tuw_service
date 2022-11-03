class SubServicesModel {
  bool? result;
  String? message;
  String? type;
  List<Subservices>? subservices;

  SubServicesModel({this.result, this.message, this.type, this.subservices});

  SubServicesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    type = json['type'];
    if (json['subservices'] != null) {
      subservices = <Subservices>[];
      json['subservices'].forEach((v) {
        subservices!.add(Subservices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['type'] = type;
    if (subservices != null) {
      data['subservices'] = subservices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subservices {
  int? id;
  String? service;
  String? image;

  Subservices({this.id, this.service, this.image});

  Subservices.fromJson(Map<String, dynamic> json) {
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
