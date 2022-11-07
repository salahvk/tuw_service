class PlaceOrder {
  bool? result;
  String? message;
  int? orderId;

  PlaceOrder({this.result, this.message, this.orderId});

  PlaceOrder.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['order_id'] = orderId;
    return data;
  }
}
