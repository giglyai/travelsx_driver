import 'flavors.dart';

import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.kurinjidriver;
  await runner.main(flavor: F.appFlavor);
}
