//prod
import 'package:travelx_driver/flavors.dart';

class AppConfig {
  // Replace 'YourClassName' with the actual name of your class
  static String getClientToken() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.bmdriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6ImJtdHJhdmVscyIsImxwX2lkIjozMzQ5OTcsImlhdCI6MTcyNDkwNjc0Nn0.pDGBs5aY9vQH8GP-YXYqTqH1fG2wXXneX0pZjIL42FU";
    } else if (F.appFlavor == Flavor.oorugodriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6Im9vcnVnby10cmF2ZWwiLCJscF9pZCI6Nzc3MzYyLCJpYXQiOjE3MjY5MTMwMzd9.wY2Ycb2PhLXPFfwC7rWUGhBVM5l199Y7kMH0bRnH0PY";
    } else if (F.appFlavor == Flavor.prithvidriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6InByaXRodmktdHJhdmVsIiwibHBfaWQiOjI5MzY1NiwiaWF0IjoxNzI3ODc5MTk2fQ.PRR8c2fLsN0_MplS9pL9sucyIm81xcWzve0DQSlwmds";
    } else if (F.appFlavor == Flavor.jppdriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6ImpwcHRvdXJzYW5kdHJhdmVscyIsImxwX2lkIjo3MTAwNjgsImlhdCI6MTcyNzkzNDg0NX0.OT5SXcVR3CRsAbGlFsA9Yz2TJ4fV0RTGoEoT92rQaVM";
    } else if (F.appFlavor == Flavor.giglyaidriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0";
    } else {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0';
    }
  }
}

class AppName {
  // Replace 'YourClassName' with the actual name of your class
  static String getAppName() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.bmdriver) {
      return "bmdriver";
    } else if (F.appFlavor == Flavor.oorugodriver) {
      return "oorugodriver";
    } else if (F.appFlavor == Flavor.prithvidriver) {
      return "prithvidriver";
    } else if (F.appFlavor == Flavor.jppdriver) {
      return "jppdriver";
    } else if (F.appFlavor == Flavor.giglyaidriver) {
      return "giglyaidriver";
    } else {
      return 'travelxdriver';
    }
  }
}



// String clientToken = F.appFlavor == Flavor.bmtravels
//     ? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6ImJtdHJhdmVscyIsImxwX2lkIjozMzQ5OTcsImlhdCI6MTcyNDkwNjc0Nn0.pDGBs5aY9vQH8GP-YXYqTqH1fG2wXXneX0pZjIL42FU"
//     : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0';

//dev
//const clientToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMjM0NTYsImlhdCI6MTcwMTk1Njg5Nn0.QyMGxCLaF7KeNPegj1PIV85HB9vtF5NCcNwF15mBSBk';
