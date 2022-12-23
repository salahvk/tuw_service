class ActiveServices {
  bool? result;
  String? message;
  List<Services>? services;

  ActiveServices({this.result, this.message, this.services});

  ActiveServices.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
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
    return data;
  }
}

class Services {
  int? id;
  String? serviceName;
  String? subscriptionDate;
  String? expiryDate;
  String? serviceImage;

  Services(
      {this.id,
      this.serviceName,
      this.subscriptionDate,
      this.expiryDate,
      this.serviceImage});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    subscriptionDate = json['subscription_date'];
    expiryDate = json['expiry_date'];
    serviceImage = json['service_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_name'] = serviceName;
    data['subscription_date'] = subscriptionDate;
    data['expiry_date'] = expiryDate;
    data['service_image'] = serviceImage;
    return data;
  }
}
