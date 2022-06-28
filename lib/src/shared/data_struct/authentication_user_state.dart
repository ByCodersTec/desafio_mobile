class AuthenticationUserForm {
  final bool isValid;
  final String? username;
  final String? password;

  AuthenticationUserForm({
    required this.isValid,
    this.username,
    this.password,
  });

  AuthenticationUserForm.fromFormFields(Map<String, dynamic> fields)
      : isValid = fields['isValid'],
        username = fields['email'],
        password = fields['password'];
}
