mixin GPSLocation {
  double latitud = 0.0;
  double longitud = 0.0;

  void actualitzarUbicacio(double lat, double lng) {
    latitud = lat;
    longitud = lng;
  }

  (double lat, double lng) obtenirCoordenades() {
    return (latitud, longitud);
  }
}
