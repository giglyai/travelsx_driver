import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.travelsxdriver;
  await runner.main(flavor: F.appFlavor);
}
