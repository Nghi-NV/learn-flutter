class LoginEntity {
  final String token;

  LoginEntity({required this.token});

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginParams.fromJson(Map<String, dynamic> json) => LoginParams(
        email: json['email'] as String,
        password: json['password'] as String,
      );
}
