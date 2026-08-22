sealed class AppFailure implements Exception {
  const AppFailure();
}

class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

class TimeoutFailure extends AppFailure {
  const TimeoutFailure();
}

class ServerFailure extends AppFailure {
  const ServerFailure();
}

class RequestCancelledFailure extends AppFailure {
  const RequestCancelledFailure();
}

class BadCertificateFailure extends AppFailure {
  const BadCertificateFailure();
}

class UnknownFailure extends AppFailure {
  const UnknownFailure();
}

String failureMessage(AppFailure failure) {
  return switch (failure) {
  NetworkFailure() =>
      'Couldn’t connect right now. Please check your internet connection.',

    TimeoutFailure() =>
      'The server took too long to respond. Please try again.',

    ServerFailure() =>
      'The server returned an invalid response. Please try again.',

    RequestCancelledFailure() =>
      'The request was cancelled.',

    BadCertificateFailure() =>
      'A secure connection could not be established.',

    UnknownFailure() =>
      'Something went wrong. Please try again.',
  };
}