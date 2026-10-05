import 'package:pf1/models/user.dart';
import 'package:pf1/models/vehicle.dart';
import 'package:pf1/models/patinet.dart';
import 'package:pf1/models/cotxe.dart';
import 'package:pf1/exceptions/saldo_invalid_exception.dart';

void main() {
  print('ECORIDE - MOTOR DE LÒGICA');

  var usuariEstandard = User.nou(
    id: 'U001',
    nom: 'Pau Ferrer',
    correu: 'pau.ferrer@example.com',
  );

  var usuariVIP = User(
    id: 'U002',
    nomComplet: 'Marc Sanchez',
    saldo: 50.0,
    correu: 'marc.sanchez@example.com',
    esVIP: true,
  );

  List<Vehicle> flota = [
    Patinet(
      id: 'PAT-01',
      bateriaPercentatge: 95,
      preuPerMinut: 0.15,
      velocitatMaxima: 25,
    )..actualitzarUbicacio(39.5696, 2.6502),
    Patinet(
      id: 'PAT-02',
      bateriaPercentatge: 15,
      preuPerMinut: 0.15,
      velocitatMaxima: 20,
    )..actualitzarUbicacio(39.5700, 2.6510),
    Patinet(
      id: 'PAT-03',
      bateriaPercentatge: 60,
      preuPerMinut: 0.20,
      velocitatMaxima: 25,
      enUs: true,
    )..actualitzarUbicacio(39.5720, 2.6530),
    Cotxe(id: 'CTX-01', bateriaPercentatge: 85, preuPerMinut: 0.40, places: 5)
      ..actualitzarUbicacio(39.5680, 2.6480),
    Cotxe(id: 'CTX-02', bateriaPercentatge: 10, preuPerMinut: 0.45, places: 2)
      ..actualitzarUbicacio(39.5650, 2.6450),
  ];

  print('1. Flota Inicialitzada (${flota.length} vehicles)');
  for (var v in flota) {
    print(
      'ID: ${v.id} | Bateria: ${v.bateriaPercentatge}% (${v.estatBateria()}) | En ús: ${v.enUs}',
    );
  }
  print('');

  print('2. Cerca i Filtres');
  var vehicleMesBateria = flota.reduce(
    (a, b) => a.bateriaPercentatge > b.bateriaPercentatge ? a : b,
  );
  print(
    'Vehicle amb la bateria més alta: ${vehicleMesBateria.id} (${vehicleMesBateria.bateriaPercentatge}%)',
  );

  var vehiclesDisponibles =
      flota.where((v) => v.bateriaPercentatge > 20 && !v.enUs).toList();
  print('\nVehicles disponibles amb bateria > 20%:');
  for (var v in vehiclesDisponibles) {
    print(' - ${v.id} (Bateria: ${v.bateriaPercentatge}%)');
  }
  print('');

  print('3. Simulació d\'ús i Destructuració de Records');
  var patinet = flota.firstWhere((v) => v is Patinet && !v.enUs) as Patinet;
  int minutsReserva = 15;

  double costNormal = patinet.calcularCostReserva(
    minutsReserva,
    usuari: usuariEstandard,
  );
  double costVIP = patinet.calcularCostReserva(
    minutsReserva,
    usuari: usuariVIP,
  );

  print('Reserva del patinet ${patinet.id} durant $minutsReserva minuts:');
  print(
    ' - Cost usuari estàndard (${usuariEstandard.nomComplet}): ${costNormal.toStringAsFixed(2)}€',
  );
  print(
    ' - Cost usuari VIP (${usuariVIP.nomComplet}): ${costVIP.toStringAsFixed(2)}€',
  );

  patinet.actualitzarUbicacio(39.5755, 2.6589);

  var (lat, lng) = patinet.obtenirCoordenades();
  print('\nNova ubicació del patinet ${patinet.id}:');
  print(' -> Latitud: $lat, Longitud: $lng\n');

  print('4. Maneig d\'Errors');
  try {
    print(
      'Intentant recarregar -10.0€ al saldo de ${usuariEstandard.nomComplet}...',
    );
    usuariEstandard.recarregarSaldo(-10.0);
  } on SaldoInvalidException catch (e) {
    print('Exception capturada amb èxit: $e');
  } catch (e) {
    print('Error Inesperat: $e');
  }

  print(
    '\nSaldo final de ${usuariEstandard.nomComplet}: ${usuariEstandard.saldo}€',
  );
  print('      EXECUCIÓ FINALITZADA AMB ÈXIT (OK)          ');
}
