class UserModel{
  final String uid;
  final String username;
  final String email;
  final String? profileImageUrl;
  final int? score;
  final String? track;
  final String? level;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.profileImageUrl,
    this.score,
    this.track,
    this.level,
});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    username: json["username"],
    email: json["email"],
    profileImageUrl: json["profileImageUrl"] ?? "",
    score: json["score"] ?? 0,
    track: json["track"] ?? "",
    level: json["level"] ?? "",

  );
}