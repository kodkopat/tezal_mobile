import 'package:sailor/sailor.dart';

import '../../features/auth/presentation/pages/registration_page.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: RegistrationPage.route,
          builder: (ctx, args, map) => RegistrationPage(),
        ),
      ],
    );
  }

  static void createCustomerRoutes() {
    sailor.addRoutes(
      [],
    );
  }

  static void createMarketRoutes() {
    sailor.addRoutes(
      [],
    );
  }

  static void createDeliveryRoutes() {
    sailor.addRoutes(
      [],
    );
  }

  // SailorRoute(
  //   name: PatientPage.route,
  //   builder: (ctx, args, map) {
  //     final patient = map.param<Patient>("patient");
  //     if (patient != null) {
  //       return PatientPage(patient: patient);
  //     } else {
  //       return PatientPage();
  //     }
  //   },
  //   params: [
  //     SailorParam<Patient>(
  //       name: "patient",
  //       isRequired: false,
  //       defaultValue: null,
  //     ),
  //   ],
  // ),

  // SailorRoute(
  //   name: MedicalCenterPage.route,
  //   builder: (ctx, args, map) {
  //     final info = map.param<AccountInfo>("accountInfo");
  //     if (info != null) {
  //       return MedicalCenterPage(info: info);
  //     } else {
  //       return MedicalCenterPage();
  //     }
  //   },
  //   params: [
  //     SailorParam<AccountInfo>(
  //       name: "accountInfo",
  //       isRequired: false,
  //       defaultValue: null,
  //     ),
  //   ],
  // ),
}
