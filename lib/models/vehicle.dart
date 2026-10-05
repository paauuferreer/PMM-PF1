import '../mixins/gps_location.dart';
import 'user.dart';

abstract class Vehicle with GPSLocation {
  final String id;
  int bateriaPercentatge;
  bool enUs;
  double preuPerMinut;

  Vehicle({
    required this.id,
    required this.bateriaPercentatge,
    this.enUs = false,
    required this.preuPerMinut,
  });

  String estatBateria() {
    return switch (bateriaPercentatge) {
      >= 80 => 'Alta',
      >= 20 => 'Mitjana',
      _ => 'Crítica (Requereix càrrega)',
    };
  }

  double calcularCostReserva(int minuts, {User? usuari});
}
