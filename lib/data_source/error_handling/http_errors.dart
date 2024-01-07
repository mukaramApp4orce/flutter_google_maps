enum HttpErrorsEnum { invalidData }

class HttpErrors implements Exception {
  final String message;

  const HttpErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory HttpErrors.fromCode(HttpErrorsEnum enums) {
    switch (enums) {
      case HttpErrorsEnum.invalidData:
        return const HttpErrors('Badly formatted data.');
      default:
        return const HttpErrors();
    }
  }
}
