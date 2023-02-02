class PaymentSuccessModel {
  String? message;
  Subscription? subscription;
  PackageInfo? packageInfo;
  OrderDetails? orderDetails;
  bool? result;

  PaymentSuccessModel(
      {this.message,
      this.subscription,
      this.packageInfo,
      this.orderDetails,
      this.result});

  PaymentSuccessModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    packageInfo = json['package_info'] != null
        ? PackageInfo.fromJson(json['package_info'])
        : null;
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    if (packageInfo != null) {
      data['package_info'] = packageInfo!.toJson();
    }
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.toJson();
    }
    data['result'] = result;
    return data;
  }
}

class Subscription {
  int? id;
  int? serviceId;
  int? userId;
  String? packageId;
  String? subscriptionDate;
  String? expiryDate;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? orderId;
  String? couponCode;
  String? transactionId;
  String? transactionStatus;
  String? packageName;
  String? serviceName;

  Subscription(
      {this.id,
      this.serviceId,
      this.userId,
      this.packageId,
      this.subscriptionDate,
      this.expiryDate,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.orderId,
      this.couponCode,
      this.transactionId,
      this.transactionStatus,
      this.packageName,
      this.serviceName});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    subscriptionDate = json['subscription_date'];
    expiryDate = json['expiry_date'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    orderId = json['order_id'];
    couponCode = json['coupon_code'];
    transactionId = json['transaction_id'];
    transactionStatus = json['transaction_status'];
    packageName = json['package_name'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['subscription_date'] = subscriptionDate;
    data['expiry_date'] = expiryDate;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['order_id'] = orderId;
    data['coupon_code'] = couponCode;
    data['transaction_id'] = transactionId;
    data['transaction_status'] = transactionStatus;
    data['package_name'] = packageName;
    data['service_name'] = serviceName;
    return data;
  }
}

class PackageInfo {
  int? id;
  int? serviceId;
  String? packages;
  String? description;
  String? validity;
  var amount;
  int? offerPrice;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? taxIds;
  String? packageName;
  String? serviceName;

  PackageInfo(
      {this.id,
      this.serviceId,
      this.packages,
      this.description,
      this.validity,
      this.amount,
      this.offerPrice,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.taxIds,
      this.packageName,
      this.serviceName});

  PackageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    packages = json['packages'];
    description = json['description'];
    validity = json['validity'];
    amount = json['amount'];
    offerPrice = json['offer_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    taxIds = json['tax_ids'];
    packageName = json['package_name'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['packages'] = packages;
    data['description'] = description;
    data['validity'] = validity;
    data['amount'] = amount;
    data['offer_price'] = offerPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['tax_ids'] = taxIds;
    data['package_name'] = packageName;
    data['service_name'] = serviceName;
    return data;
  }
}

class OrderDetails {
  int? id;
  int? serviceId;
  int? userId;
  int? packageId;
  String? firstname;
  String? lastname;
  String? civilCardNo;
  String? dob;
  String? gender;
  int? countryId;
  String? state;
  String? region;
  String? address;
  String? couponCode;
  String? totalAmount;
  String? totalTaxAmount;
  String? couponDiscount;
  String? grandTotal;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? fortId;

  OrderDetails(
      {this.id,
      this.serviceId,
      this.userId,
      this.packageId,
      this.firstname,
      this.lastname,
      this.civilCardNo,
      this.dob,
      this.gender,
      this.countryId,
      this.state,
      this.region,
      this.address,
      this.couponCode,
      this.totalAmount,
      this.totalTaxAmount,
      this.couponDiscount,
      this.grandTotal,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,this.fortId});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    civilCardNo = json['civil_card_no'];
    dob = json['dob'];
    gender = json['gender'];
    countryId = json['country_id'];
    state = json['state'];
    region = json['region'];
    address = json['address'];
    couponCode = json['coupon_code'];
    totalAmount = json['total_amount'];
    totalTaxAmount = json['total_tax_amount'];
    couponDiscount = json['coupon_discount'];
    grandTotal = json['grand_total'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fortId = json['fort_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['civil_card_no'] = civilCardNo;
    data['dob'] = dob;
    data['gender'] = gender;
    data['country_id'] = countryId;
    data['state'] = state;
    data['region'] = region;
    data['address'] = address;
    data['coupon_code'] = couponCode;
    data['total_amount'] = totalAmount;
    data['total_tax_amount'] = totalTaxAmount;
    data['coupon_discount'] = couponDiscount;
    data['grand_total'] = grandTotal;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fort_id'] = fortId;
    return data;
  }
}
