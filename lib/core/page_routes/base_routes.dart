// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../features/presentation/base_pages/about_us/about_us_page.dart';
import '../../features/presentation/base_pages/confirm_registration/confirm_registration.dart';
import '../../features/presentation/base_pages/confirm_reset_password/confirm_reset_password.dart';
import '../../features/presentation/base_pages/contacts/contacts_page.dart';
import '../../features/presentation/base_pages/encourage_login/encourage_login_page.dart';
import '../../features/presentation/base_pages/login/login_page.dart';
import '../../features/presentation/base_pages/registration/registration_page.dart';
import '../../features/presentation/base_pages/reset_password/reset_password_page.dart';
import '../../features/presentation/base_pages/settings/settings_page.dart';
import '../../features/presentation/base_pages/splash/splash_page.dart';

class Routes {
  static final sailor = Sailor();
}

void createBaseRoutes(Sailor sailor) {
  sailor.addRoutes(
    [
      SailorRoute(
        name: SplashPage.route,
        builder: (ctx, args, map) => SplashPage(),
      ),
      SailorRoute(
        name: EncourageLoginPage.route,
        builder: (ctx, args, map) => EncourageLoginPage(),
      ),
      SailorRoute(
        name: LoginPage.route,
        builder: (ctx, args, map) => LoginPage(),
      ),
      SailorRoute(
        name: RegistrationPage.route,
        builder: (ctx, args, map) => RegistrationPage(),
      ),
      SailorRoute(
        name: ConfirmRegistrationPage.route,
        builder: (ctx, args, map) => ConfirmRegistrationPage(),
      ),
      SailorRoute(
        name: ResetPasswordPage.route,
        builder: (ctx, args, map) => ResetPasswordPage(),
      ),
      SailorRoute(
        name: ConfirmResetPasswordPage.route,
        builder: (ctx, args, map) {
          final phone = map.param<String>("phone");
          return ConfirmResetPasswordPage(phone: phone);
        },
        params: [
          SailorParam<String>(
            name: "phone",
            isRequired: true,
            defaultValue: "",
          ),
        ],
      ),
      SailorRoute(
        name: SettingsPage.route,
        builder: (ctx, args, map) => SettingsPage(),
      ),
      SailorRoute(
        name: ContactsPage.route,
        builder: (ctx, args, map) => ContactsPage(),
      ),
      SailorRoute(
        name: AboutUsPage.route,
        builder: (ctx, args, map) => AboutUsPage(),
      ),
    ],
  );
}
