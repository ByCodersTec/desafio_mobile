abstract class IErrorsException {
  final String message;
  final StackTrace? stackTrace;

  const IErrorsException(this.message, [this.stackTrace]);
}

class FalireException extends IErrorsException {
  const FalireException(super.message, [super.stackTrace]);
}
