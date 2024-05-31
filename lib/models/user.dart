class User {
  String userId;
  String email;
  String password;
  String fullName;
  String nationality;
  String visaStatus;
  String durationOfStay;
  String prefecture;
  String ward;
  String japaneseProficiency;
  String preferredLanguage;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.userId,
    required this.email,
    required this.password,
    required this.fullName,
    required this.nationality,
    required this.visaStatus,
    required this.durationOfStay,
    required this.prefecture,
    required this.ward,
    required this.japaneseProficiency,
    required this.preferredLanguage,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a User from a map
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['user_id'],
      email: data['email'],
      password: data['password'],
      fullName: data['full_name'],
      nationality: data['nationality'],
      visaStatus: data['visa_status'],
      durationOfStay: data['duration_of_stay'],
      prefecture: data['prefecture'],
      ward: data['ward'],
      japaneseProficiency: data['japanese_proficiency'],
      preferredLanguage: data['preferred_language'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  // Method to convert a User to a map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'email': email,
      'password': password,
      'full_name': fullName,
      'nationality': nationality,
      'visa_status': visaStatus,
      'duration_of_stay': durationOfStay,
      'prefecture': prefecture,
      'ward': ward,
      'japanese_proficiency': japaneseProficiency,
      'preferred_language': preferredLanguage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
