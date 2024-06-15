import 'package:equatable/equatable.dart';

class User extends Equatable {
  String uId;
  String name;
  String phoneNumber;
  String image;
  String token;
  String aboutMe;
  String lastSeen;
  String createdAt;
  bool isOnline;
  List<String> friendsUIds;
  List<String> friendsRequestsUIds;
  List<String> sentFriendsRequestsUIds;

  User({
    this.uId = '',
    this.name = '',
    this.phoneNumber = '',
    this.image = '',
    this.token = '',
    this.aboutMe = '',
    this.lastSeen = '',
    this.createdAt = '',
    this.isOnline = false,
    this.friendsUIds = const [],
    this.friendsRequestsUIds = const [],
    this.sentFriendsRequestsUIds = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uId: json['uId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
      token: json['token'],
      aboutMe: json['aboutMe'],
      lastSeen: json['lastSeen'],
      createdAt: json['createdAt'],
      isOnline: json['isOnline'],
      friendsUIds: json['friendsUIds'],
      friendsRequestsUIds: json['friendsRequestsUIds'],
      sentFriendsRequestsUIds: json['sentFriendsRequestsUIds'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uId': uId,
        'name': name,
        'phoneNumber': phoneNumber,
        'image': image,
        'token': token,
        'aboutMe': aboutMe,
        'lastSeen': lastSeen,
        'createdAt': createdAt,
        'isOnline': isOnline,
        'friendsUIds': friendsUIds,
        'friendsRequestsUIds': friendsRequestsUIds,
        'sentFriendsRequestsUIds': sentFriendsRequestsUIds,
      };

  @override
  List<Object?> get props => [
        uId,
        name,
        phoneNumber,
        image,
        token,
        aboutMe,
        lastSeen,
        createdAt,
        isOnline,
        friendsUIds,
        friendsRequestsUIds,
        sentFriendsRequestsUIds,
      ];

//copy with
  User copyWith({
    String? uId,
    String? name,
    String? phoneNumber,
    String? image,
    String? token,
    String? aboutMe,
    String? lastSeen,
    String? createdAt,
    bool? isOnline,
    List<String>? friendsUIds,
    List<String>? friendsRequestsUIds,
    List<String>? sentFriendsRequestsUIds,
  }) {
    return User(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      token: token ?? this.token,
      aboutMe: aboutMe ?? this.aboutMe,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      isOnline: isOnline ?? this.isOnline,
      friendsUIds: friendsUIds ?? this.friendsUIds,
      friendsRequestsUIds: friendsRequestsUIds ?? this.friendsRequestsUIds,
      sentFriendsRequestsUIds:
          sentFriendsRequestsUIds ?? this.sentFriendsRequestsUIds,
    );
  }

  //deep copy equatable deep clone
  User deepClone() {
    return User(
      uId: uId,
      name: name,
      phoneNumber: phoneNumber,
      image: image,
      token: token,
      aboutMe: aboutMe,
      lastSeen: lastSeen,
      createdAt: createdAt,
      isOnline: isOnline,
      friendsUIds: friendsUIds,
      friendsRequestsUIds: friendsRequestsUIds,
      sentFriendsRequestsUIds: sentFriendsRequestsUIds,
    );
  }
}
