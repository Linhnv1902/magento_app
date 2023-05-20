class GetMessagesResponse {
  List<Message>? items;
 // Null searchCriteria;
  int? totalCount;

  GetMessagesResponse({this.items,
    //this.searchCriteria,
    this.totalCount});

  GetMessagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items =    <Message>[];
      json['items'].forEach((v) {
        items!.add(Message.fromJson(v));
      });
    }
 //   searchCriteria = json['search_criteria'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
 //   data['search_criteria'] = this.searchCriteria;
    data['total_count'] = totalCount;
    return data;
  }
}

class Message {
  String? messageId;
  String? chatId;
  String? customerId;
  String? customerEmail;
  String? customerName;
  String? isRead;
  String? userName;
  String? name;
  String? bodyMsg;
  String? createdAt;
  String? updatedAt;
  String? ip;
  String? currentUrl;
  String? userId;

  Message(
      {this.messageId,
        this.chatId,
        this.customerId,
        this.customerEmail,
        this.customerName,
        this.isRead,
        this.userName,
        this.name,
        this.bodyMsg,
        this.createdAt,
        this.updatedAt,
        this.ip,
        this.currentUrl,
        this.userId});

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    chatId = json['chat_id'];
    customerId = json['customer_id'];
    customerEmail = json['customer_email'];
    customerName = json['customer_name'];
    isRead = json['is_read'];
    userName = json['user_name'];
    name = json['name'];
    bodyMsg = json['body_msg'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ip = json['ip'];
    currentUrl = json['current_url'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['chat_id'] = chatId;
    data['customer_id'] = customerId;
    data['customer_email'] = customerEmail;
    data['customer_name'] = customerName;
    data['is_read'] = isRead;
    data['user_name'] = userName;
    data['name'] = name;
    data['body_msg'] = bodyMsg;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['ip'] = ip;
    data['current_url'] = currentUrl;
    data['user_id'] = userId;
    return data;
  }

  @override
  String toString() {
    return 'Message{messageId: $messageId}';
  }
}
