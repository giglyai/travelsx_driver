enum Flavor {
  kurinjidriver,
  goguldriver,
  uzhavandriver,
  travelsxdriver,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.kurinjidriver:
        return 'Kurinji Driver';
      case Flavor.goguldriver:
        return 'Gogul Cabs Driver';
      case Flavor.uzhavandriver:
        return 'Uzhavan Taxi Driver';
      case Flavor.travelsxdriver:
        return 'TravelsX Driver';
      default:
        return 'title';
    }
  }

}
