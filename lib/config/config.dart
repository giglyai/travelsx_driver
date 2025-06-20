//prod
import 'package:travelx_driver/flavors.dart';

class AppConfig {
  // Replace 'YourClassName' with the actual name of your class
  static String getClientToken() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.kurinjidriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imt1cmluamljYWxsdGF4aUBnbWFpbC5jb20iLCJuYW1lIjoia3VyaW5qaS1kcml2ZXIiLCJscF9pZCI6MjIwMzEzLCJhZ2dyX2lkIjoyMjAzMTMsImlhdCI6MTc0NzIyOTU0Nn0.QLxecGPl13d2CJuTLZvF4U-fAjbP1F1vZfj6UmWIalQ";
    } else if (F.appFlavor == Flavor.goguldriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTkwNDE4LCJhZ2dyX2lkIjo5OTA0MTgsImlhdCI6MTc1MDMwOTU3N30.obM49rlBOb1aqZq1iJtP-C1E7KoZkiZV94wI89hjIqY";
    } else if (F.appFlavor == Flavor.uzhavandriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6NjYzMTgyLCJhZ2dyX2lkIjo2NjMxODIsImlhdCI6MTc1MDMyODE3NH0.QHuqzT88z9EcdYDXJLnE70oWenvnA7uJvpEeYpFLDVM";
    } else if (F.appFlavor == Flavor.travelsxdriver) {
      //travelsx-driver
      //return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6NTYxNzgyLCJhZ2dyX2lkIjo1NjE3ODIsImlhdCI6MTc0NzM3MTg3NH0.iBVDfOXN4QJ_kJj1ZkOoW9igExslZg6c1tO_EGPFuSw";
      //gigly
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTA3ODY0LCJhZ2dyX2lkIjo5MDc4NjQsImlhdCI6MTc1MDEzNjE2N30.EifkoCxW-vSE6PZys2Y6QldEtVfNM9E1RrDmHxFWGIk";
      //sreamarthnath travels
      //return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6ODE1MTMxLCJhZ2dyX2lkIjo4MTUxMzEsImlhdCI6MTc1MDIxOTczMH0.-FFF8THhE7WpqUEzeqLyj27PelDk-UuhNNT162JC5rQ";
      //gogulcabstaxi
      //return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTkwNDE4LCJhZ2dyX2lkIjo5OTA0MTgsImlhdCI6MTc1MDMwOTU3N30.obM49rlBOb1aqZq1iJtP-C1E7KoZkiZV94wI89hjIqY";
      //uzhavan
      //return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6NjYzMTgyLCJhZ2dyX2lkIjo2NjMxODIsImlhdCI6MTc1MDMyODE3NH0.QHuqzT88z9EcdYDXJLnE70oWenvnA7uJvpEeYpFLDVM";
    } else {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRyYXZlbHN4ZHJpdmVyQGdpZ2x5LmFpLmNvbSIsIm5hbWUiOiJ0cmF2ZWxzeC1kcml2ZXIiLCJscF9pZCI6OTA3ODY0LCJhZ2dyX2lkIjo5MDc4NjQsImlhdCI6MTc1MDEzNjE2N30.EifkoCxW-vSE6PZys2Y6QldEtVfNM9E1RrDmHxFWGIk';
    }
  }
}

class AppName {
  // Replace 'YourClassName' with the actual name of your class
  static String getAppName() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.kurinjidriver) {
      return "kurinji-driver";
    } else {
      return 'travelsx-driver';
    }
  }
}

// String clientToken = F.appFlavor == Flavor.bmtravels
//     ? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6ImJtdHJhdmVscyIsImxwX2lkIjozMzQ5OTcsImlhdCI6MTcyNDkwNjc0Nn0.pDGBs5aY9vQH8GP-YXYqTqH1fG2wXXneX0pZjIL42FU"
//     : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0';

//dev
//const clientToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMjM0NTYsImlhdCI6MTcwMTk1Njg5Nn0.QyMGxCLaF7KeNPegj1PIV85HB9vtF5NCcNwF15mBSBk';
