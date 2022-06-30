abstract class SigninEvent {}

class SubmitAuthForm implements SigninEvent {
  final String username;
  final String password;

  SubmitAuthForm({required this.username, required this.password});
}
