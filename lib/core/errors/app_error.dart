abstract class AppError implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppError(this.message, [this.stackTrace]);

  @override
  String toString() => message;
}

class NetworkError extends AppError {
  NetworkError(super.message, [super.stackTrace]);
}

class DatabaseError extends AppError {
  DatabaseError(super.message, [super.stackTrace]);
}

class UnknownError extends AppError {
  UnknownError(super.message, [super.stackTrace]);
}