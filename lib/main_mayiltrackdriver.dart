import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.mayiltrackdriver;
  await runner.main(flavor: F.appFlavor);
}
