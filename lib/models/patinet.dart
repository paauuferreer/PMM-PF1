import 'vehicle.dart';
import 'user.dart';

class Patinet extends Vehicle {
  int velocitatMaxima;

  Patinet({
    required super.id,
    required super.bateriaPercentatge,
    super.enUs,
    required super.preuPerMinut,
    required this.velocitatMaxima,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    double costBase = minuts * preuPerMinut;
    if (usuari != null && usuari.esVIP) {
      costBase *= 0.90;
    }
    return costBase;
  }
}
