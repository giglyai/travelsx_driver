//prod
import 'package:travelx_driver/flavors.dart';

class AppConfig {
  // Replace 'YourClassName' with the actual name of your class
  static String getClientToken() {
    // Make it a static method for easy access
    if (F.appFlavor == Flavor.kurinjidriver) {
      return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN1cHBvcnRAZ2lnbHkuY29tIiwibmFtZSI6InRyYXZlbHN4LWRyaXZlciIsImxwX2lkIjo3OTA0NjYsImFnZ3JfaWQiOjc5MDQ2NiwiaWF0IjoxNzQ3MTAxNjQ1fQ.r_iHceVX-MhbNJ_PMZPK6cU4-cWokJuq7rkEjV47b5M";
    } else {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGdpZ2x5LmNvbSIsImxwX2lkIjoxMTYwMDAsImlhdCI6MTcwMDkxMzk5M30.V3KojO1yE7CN-jTm1Go3fU-TxmzEvgy8-MPMjvyNvK0';
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
