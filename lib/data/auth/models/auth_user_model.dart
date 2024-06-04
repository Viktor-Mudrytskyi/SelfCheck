/// Data model for user registration and logging in
final class AuthUserModel {
  /// Creates instance of [AuthUserModel]
  const AuthUserModel({required this.email, required this.password});

  /// User email
  final String email;

  /// User password
  final String password;
}
