enum GoogleMapErrorEnum { invalidData }

class GoogleMapError implements Exception {
  final String message;
  final int? errorCode;

  const GoogleMapError([
    this.message = 'An unknown exception occurred.',
    this.errorCode,
  ]);

  factory GoogleMapError.fromCode(GoogleMapErrorEnum enums) {
    switch (enums) {
      case GoogleMapErrorEnum.invalidData:
        return const GoogleMapError(
          'Badly formatted data.',
          1001,
        );
      default:
        return const GoogleMapError();
    }
  }
}
