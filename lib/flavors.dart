enum Flavor {
  kurinjidriver,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.kurinjidriver:
        return 'Kurinji Driver';
      default:
        return 'title';
    }
  }

}
