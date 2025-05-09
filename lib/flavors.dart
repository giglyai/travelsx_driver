enum Flavor {
  kurinjidriver,
  bmdriver,
  oorugodriver,
  prithvidriver,
  jppdriver,
  giglyaidriver,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.kurinjidriver:
        return 'Kurinji Driver';
      case Flavor.bmdriver:
        return 'BM Driver';
      case Flavor.oorugodriver:
        return 'Oorugo Driver';
      case Flavor.prithvidriver:
        return 'Prithvi Driver';
      case Flavor.jppdriver:
        return 'JPP Driver';
      case Flavor.giglyaidriver:
        return 'Giglyai Driver';
      default:
        return 'title';
    }
  }

}
