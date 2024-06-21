import 'package:rich_chat_copilot/lib/src/core/utils/massage_type.dart';

class Massage {
  final String senderId;
  final String senderName;
  final String senderImage;
  final String receiverId;
  final String massage;
  final MassageType massageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MassageType repliedMessageType;

  const Massage({
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.receiverId,
    required this.massage,
    required this.massageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  factory Massage.fromJson(Map<String, dynamic> json) {
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj${json['massageType'].toString().massageTypeFromString}");
    return Massage(
      senderId: json['senderId'],
      senderName: json['senderName'],
      senderImage: json['senderImage'],
      receiverId: json['receiverId'],
      massage: json['massage'],
      massageType: json['massageType'].toString().massageTypeFromString,
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['timeSent']),
      messageId: json['messageId'],
      isSeen: json['isSeen'],
      repliedMessage: json['repliedMessage'],
      repliedTo: json['repliedTo'],
      repliedMessageType:
          json['repliedMessageType'].toString().massageTypeFromString,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'receiverId': receiverId,
      'massage': massage,
      'massageType': massageType.name,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.name,
    };
  }

  //copy with
  Massage copyWith({
    String? senderId,
    String? senderName,
    String? senderImage,
    String? receiverId,
    String? massage,
    MassageType? massageType,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? repliedMessage,
    String? repliedTo,
    MassageType? repliedMessageType,
  }) {
    return Massage(
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderImage: senderImage ?? this.senderImage,
      receiverId: receiverId ?? this.receiverId,
      massage: massage ?? this.massage,
      massageType: massageType ?? this.massageType,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  //deep copy with
  Massage deepCopyWith({
    required String receiverId,
  }) {
    return Massage(
      senderId: senderId,
      senderName: senderName,
      senderImage: senderImage,
      receiverId: receiverId,
      massage: massage,
      massageType: massageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: isSeen,
      repliedMessage: repliedMessage,
      repliedMessageType: repliedMessageType,
      repliedTo: repliedTo,
    );
  }
}
