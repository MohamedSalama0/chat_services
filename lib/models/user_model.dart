class ChatUser {
  late String image;
  late String message;
  late String name;
  late String createdAt;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String email;
  late String pushToken;

  ChatUser({
    required this.image,
    required this.message,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
  });
  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    message = json['message'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? false;
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = message;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}