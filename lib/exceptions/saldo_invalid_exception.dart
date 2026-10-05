class SaldoInvalidException implements Exception {
  final String message;
  SaldoInvalidException([
    this.message = 'La quantitat a recarregar ha de ser superior a 0.',
  ]);

  @override
  String toString() => 'SaldoInvalidException: $message';
}
