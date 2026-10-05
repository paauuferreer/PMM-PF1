import 'vehicle.dart';
import 'user.dart';

class Cotxe extends Vehicle {
  int places;
  bool requereixLlicencia;

  Cotxe({
    required super.id,
    required super.bateriaPercentatge,
    super.enUs,
    required super.preuPerMinut,
    required this.places,
    this.requereixLlicencia = true,
  });

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    double suplementFiltreEcologic = 2.0;
    return (minuts * preuPerMinut) + suplementFiltreEcologic;
  }
}
