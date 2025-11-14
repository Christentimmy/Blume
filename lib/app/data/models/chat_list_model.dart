

class ChatListModel {
  String? userId;
  String? fullName;
  String? avatar;
  String? lastMessage;
  int? unreadCount;
  bool? online;
  DateTime? timestamp;

  ChatListModel({
    this.userId,
    this.fullName,
    this.avatar,
    this.lastMessage,
    this.unreadCount,
    this.online,
    this.timestamp,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      userId: json["userId"] ?? "",
      fullName: json["fullName"] ?? "",
      avatar: json["avatar"] ?? "",
      lastMessage: json["lastMessage"] ?? "",
      unreadCount: json["unreadCount"] ?? 0,
      online: json["online"] ?? false,
      timestamp: json["timestamp"] != null
          ? DateTime.parse(json["timestamp"].toString())
          : null,
    );
  }
}
