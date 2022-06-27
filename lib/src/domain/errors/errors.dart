abstract class IErrorsException {
  final String message;
  final StackTrace? stackTrace;

  const IErrorsException(this.message, [this.stackTrace]);
}

class AuthException extends IErrorsException {
  const AuthException(super.message, [super.stackTrace]);
}

class DatasourcePostException extends IErrorsException {
  const DatasourcePostException(super.message, [super.stackTrace]);
}
