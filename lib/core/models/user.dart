class User {
  const User({
    required this.id,
    required this.username,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String username;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id']?.toString() ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    createdAt: json['created_at'] != null 
        ? DateTime.tryParse(json['created_at']) 
        : null,
    updatedAt: json['updated_at'] != null 
        ? DateTime.tryParse(json['updated_at']) 
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    token: json['token'] ?? '',
    user: User.fromJson(json['user'] ?? {}),
  );
}

