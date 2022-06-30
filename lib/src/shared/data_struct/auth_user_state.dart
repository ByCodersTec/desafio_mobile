class AuthUserForm {
  final bool isValid;
  final String? username;
  final String? password;

  AuthUserForm({
    required this.isValid,
    this.username,
    this.password,
  });

  AuthUserForm.fromFormFields(Map<String, dynamic> fields)
      : isValid = fields['isValid'],
        username = fields['email'],
        password = fields['password'];
}
