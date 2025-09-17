//prod
import 'package:travelx_driver/flavors.dart';

class AppConfig {
  // Replace 'YourClassName' with the actual name of your class
  static String getClientToken() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.travelsxdriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTA3ODY0LCJhZ2dyX2lkIjo5MDc4NjQsImlhdCI6MTc1MDEzNjE2N30.EifkoCxW-vSE6PZys2Y6QldEtVfNM9E1RrDmHxFWGIk";
    } else if (F.appFlavor == Flavor.sreedroptaxidriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJscF9pZCI6MTE2MDAwLCJ1c2VyX2lkIjoyMjAzMjMsImlhdCI6MTc1ODA4NTA2Nn0.FhspfHiy5Hq4I1X_BBxd0cT6ALE0UgjstUp_CKmWn4E";
    }
    // else if (F.appFlavor == Flavor.oorvandidriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4dXNlckBnaWdseS5haS5jb20iLCJuYW1lIjoidHJhdmVsc3gtdXNlciIsImxwX2lkIjo5MDY3NDYsImFnZ3JfaWQiOjkwNjc0NiwiZG9tYWluX25hbWUiOiJvb3J2YW5kaS5naWdseS50cmF2ZWwiLCJpYXQiOjE3NTIyMTY5NTh9.uGzwEKYok15o4UhGkP5AJGSzddWJsTENEPLcUyMa5hY";
    // } else if (F.appFlavor == Flavor.kurinjidriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imt1cmluamljYWxsdGF4aUBnbWFpbC5jb20iLCJuYW1lIjoia3VyaW5qaS1kcml2ZXIiLCJscF9pZCI6MjIwMzEzLCJhZ2dyX2lkIjoyMjAzMTMsImlhdCI6MTc0NzIyOTU0Nn0.QLxecGPl13d2CJuTLZvF4U-fAjbP1F1vZfj6UmWIalQ";
    // } else if (F.appFlavor == Flavor.goguldriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTkwNDE4LCJhZ2dyX2lkIjo5OTA0MTgsImlhdCI6MTc1MDMwOTU3N30.obM49rlBOb1aqZq1iJtP-C1E7KoZkiZV94wI89hjIqY";
    // } else if (F.appFlavor == Flavor.uzhavandriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6NjYzMTgyLCJhZ2dyX2lkIjo2NjMxODIsImlhdCI6MTc1MDMyODE3NH0.QHuqzT88z9EcdYDXJLnE70oWenvnA7uJvpEeYpFLDVM";
    // } else if (F.appFlavor == Flavor.mayiltrackdriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6NTA4Nzk1LCJhZ2dyX2lkIjo1MDg3OTUsImlhdCI6MTc1MDU4MjU2NH0.6paIEeD_C7CvTihTxKoCMBB2sgjZMpMgAJ9iAcxLmsk";
    // } else if (F.appFlavor == Flavor.googultaxidriver) {
    //   return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6MzYzMjMzLCJhZ2dyX2lkIjozNjMyMzMsImlhdCI6MTc1MTE5MDE5NX0.Q-jTv0RDr-4btfFm3JQNpPzYlyiQKbL_0u75VIBx27M";
    // }
    else {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTA3ODY0LCJhZ2dyX2lkIjo5MDc4NjQsImlhdCI6MTc1MDEzNjE2N30.EifkoCxW-vSE6PZys2Y6QldEtVfNM9E1RrDmHxFWGIk';
    }
  }
}

class AppName {
  // Replace 'YourClassName' with the actual name of your class
  static String getAppName() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.travelsxdriver) {
      return "travelx-driver";
    } else if (F.appFlavor == Flavor.sreedroptaxidriver) {
      return "sreedroptaxi-driver";
    }
    //  else if (F.appFlavor == Flavor.kurinjidriver) {
    //     return "kurinji-driver";
    //   } else if (F.appFlavor == Flavor.oorvandidriver) {
    //     return "oorvandi-driver";
    //   } else if (F.appFlavor == Flavor.goguldriver) {
    //     return "gogul-driver";
    //   }
    else {
      return 'travelsx-driver';
    }
  }
}

// String clientToken = F.appFlavor == Flavor.bmtravels
//     ? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6ImJtdHJhdmVscyIsImxwX2lkIjozMzQ5OTcsImlhdCI6MTcyNDkwNjc0Nn0.pDGBs5aY9vQH8GP-YXYqTqH1fG2wXXneX0pZjIL42FU"
//     : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0';

//dev
//const clientToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMjM0NTYsImlhdCI6MTcwMTk1Njg5Nn0.QyMGxCLaF7KeNPegj1PIV85HB9vtF5NCcNwF15mBSBk';
