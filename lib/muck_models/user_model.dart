/// User model representing user profile information
class UserModel {
  final String id;
  final String name;
  final String email;
  final String mobileNumber;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    this.profileImageUrl,
  });

  /// Factory constructor to create a user from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  /// Convert user to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'profileImageUrl': profileImageUrl,
    };
  }

  /// Create a copy of the user with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobileNumber,
    String? profileImageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  /// Mock user data for demonstration
  static UserModel getMockUser() {
    return UserModel(
      id: '1',
      name: 'Mahdi Daneshfar',
      email: 'test@example.com',
      mobileNumber: '09122223344',
      profileImageUrl: null,
    );
  }
}

