enum Flavor {
  travelsxdriver,
  sreedroptaxidriver,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.travelsxdriver:
        return 'TravelsX Driver';
      case Flavor.sreedroptaxidriver:
        return 'Sree Drop Taxi';
      default:
        return 'title';
    }
  }

}
