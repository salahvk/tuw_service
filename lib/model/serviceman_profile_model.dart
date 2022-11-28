class ServiceManProfile {
  bool? result;
  String? message;
  UserData? userData;
  List<GalleryImages>? galleryImages;

  ServiceManProfile(
      {this.result, this.message, this.userData, this.galleryImages});

  ServiceManProfile.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    userData =
        json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    if (json['gallery_images'] != null) {
      galleryImages = <GalleryImages>[];
      json['gallery_images'].forEach((v) {
        galleryImages!.add(GalleryImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (galleryImages != null) {
      data['gallery_images'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? firstname;
  String? dob;
  String? gender;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  int? countryId;
  String? state;
  String? region;
  String? profilePic;
  String? deviceId;
  String? apiToken;
  String? apiTokenExpiry;
  int? otp;
  String? otpExpiry;
  String? about;
  String? status;
  int? languageId;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? civilCardNo;
  String? lastname;
  String? expiryDate;
  String? service;
  String? couponCode;
  String? coverPic;
  String? homeLocation;
  String? latitude;
  String? longitude;
  String? transport;
  String? profile;
  String? onlineStatus;
  String? countryName;

  UserData(
      {this.id,
      this.firstname,
      this.dob,
      this.gender,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.countryId,
      this.state,
      this.region,
      this.profilePic,
      this.deviceId,
      this.apiToken,
      this.apiTokenExpiry,
      this.otp,
      this.otpExpiry,
      this.about,
      this.status,
      this.languageId,
      this.createdAt,
      this.updatedAt,
      this.userType,
      this.civilCardNo,
      this.lastname,
      this.expiryDate,
      this.service,
      this.couponCode,
      this.coverPic,
      this.homeLocation,
      this.latitude,
      this.longitude,
      this.transport,
      this.profile,
      this.onlineStatus,
      this.countryName});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    countryId = json['country_id'];
    state = json['state'];
    region = json['region'];
    profilePic = json['profile_pic'];
    deviceId = json['device_id'];
    apiToken = json['api_token'];
    apiTokenExpiry = json['api_token_expiry'];
    otp = json['otp'];
    otpExpiry = json['otp_expiry'];
    about = json['about'];
    status = json['status'];
    languageId = json['language_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    civilCardNo = json['civil_card_no'];
    lastname = json['lastname'];
    expiryDate = json['expiry_date'];
    service = json['service'];
    couponCode = json['coupon_code'];
    coverPic = json['cover_pic'];
    homeLocation = json['home_location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    transport = json['transport'];
    profile = json['profile'];
    onlineStatus = json['online_status'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['dob'] = dob;
    data['gender'] = gender;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['state'] = state;
    data['region'] = region;
    data['profile_pic'] = profilePic;
    data['device_id'] = deviceId;
    data['api_token'] = apiToken;
    data['api_token_expiry'] = apiTokenExpiry;
    data['otp'] = otp;
    data['otp_expiry'] = otpExpiry;
    data['about'] = about;
    data['status'] = status;
    data['language_id'] = languageId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['civil_card_no'] = civilCardNo;
    data['lastname'] = lastname;
    data['expiry_date'] = expiryDate;
    data['service'] = service;
    data['coupon_code'] = couponCode;
    data['cover_pic'] = coverPic;
    data['home_location'] = homeLocation;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['transport'] = transport;
    data['profile'] = profile;
    data['online_status'] = onlineStatus;
    data['country_name'] = countryName;
    return data;
  }
}

class GalleryImages {
  int? id;
  int? userId;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? galleryImage;

  GalleryImages(
      {this.id,
      this.userId,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.galleryImage});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    galleryImage = json['gallery_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['gallery_image'] = galleryImage;
    return data;
  }
}
