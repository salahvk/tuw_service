class ChatListModel {
  bool? result;
  ChatMessage? chatMessage;

  ChatListModel({this.result, this.chatMessage});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    chatMessage = json['chat_message'] != null
        ? ChatMessage.fromJson(json['chat_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (chatMessage != null) {
      data['chat_message'] = chatMessage!.toJson();
    }
    return data;
  }
}

class ChatMessage {
  int? currentPage;
  List<MessageData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ChatMessage(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MessageData>[];
      json['data'].forEach((v) {
        data!.add(MessageData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class MessageData {
  int? id;
  var senderId;
  var receiverId;
  var servicemanId;
  String? message;
  String? uploads;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? sendUserId;
  String? firstname;
  String? lastname;
  String? onlineStatus;
  String? serviceName;
  String? profilePic;
  int? unreadCount;

  MessageData(
      {this.id,
      this.senderId,
      this.receiverId,
      this.servicemanId,
      this.message,
      this.uploads,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.sendUserId,
      this.firstname,
      this.lastname,
      this.onlineStatus,
      this.serviceName,
      this.profilePic,
      this.unreadCount});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    servicemanId = json['serviceman_id'];
    message = json['message'];
    uploads = json['uploads'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sendUserId = json['send_user_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    onlineStatus = json['online_status'];
    serviceName = json['service_name'];
    profilePic = json['profile_pic'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['serviceman_id'] = servicemanId;
    data['message'] = message;
    data['uploads'] = uploads;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['send_user_id'] = sendUserId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['online_status'] = onlineStatus;
    data['service_name'] = serviceName;
    data['profile_pic'] = profilePic;
    data['unread_count'] = unreadCount;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
