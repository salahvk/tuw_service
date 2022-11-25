class GetOtp {
  bool? result;
  String? message;
  int? oTP;
  String? phone;
  String? action;

  GetOtp({this.result, this.message, this.oTP, this.phone});

  GetOtp.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    oTP = json['OTP'];
    phone = json['Phone'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['OTP'] = oTP;
    data['Phone'] = phone;
    data['action'] = action;
    return data;
  }
}
