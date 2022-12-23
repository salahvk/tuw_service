class ActiveSubscription {
  bool? result;
  String? message;
  List<Subscriptions>? subscriptions;

  ActiveSubscription({this.result, this.message, this.subscriptions});

  ActiveSubscription.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  int? subscriptionId;
  String? packageName;
  int? amount;
  String? validity;
  String? subscriptionDate;
  String? expiryDate;
  String? serviceImage;

  Subscriptions(
      {this.subscriptionId,
      this.packageName,
      this.amount,
      this.validity,
      this.subscriptionDate,
      this.expiryDate,
      this.serviceImage});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    packageName = json['package_name'];
    amount = json['amount'];
    validity = json['validity'];
    subscriptionDate = json['subscription_date'];
    expiryDate = json['expiry_date'];
    serviceImage = json['service_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscription_id'] = subscriptionId;
    data['package_name'] = packageName;
    data['amount'] = amount;
    data['validity'] = validity;
    data['subscription_date'] = subscriptionDate;
    data['expiry_date'] = expiryDate;
    data['service_image'] = serviceImage;
    return data;
  }
}
