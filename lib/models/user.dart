import '../exceptions/saldo_invalid_exception.dart';

class User {
  final String _id;
  final String _nomComplet;
  double _saldo;

  String correu;
  bool esVIP;

  User.nou({required String id, required String nom, required this.correu})
    : _id = id,
      _nomComplet = nom,
      _saldo = 0.0,
      esVIP = false;

  User({
    required String id,
    required String nomComplet,
    required double saldo,
    required this.correu,
    this.esVIP = false,
  }) : _id = id,
       _nomComplet = nomComplet,
       _saldo = saldo;

  String get id => _id;
  String get nomComplet => _nomComplet;
  double get saldo => _saldo;

  void recarregarSaldo(double quantitat) {
    if (quantitat <= 0) {
      throw SaldoInvalidException(
        'No es permet recarregar quantitats negatives o zero ($quantitat€).',
      );
    }
    _saldo += quantitat;
  }
}
