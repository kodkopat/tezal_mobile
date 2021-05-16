// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/market_providers/default_hours_notifier.dart';
import '../default_hours_edit/edit_default_hours_page.dart';
import 'widgets/default_hours_list.dart';

class DefaultHoursPage extends StatelessWidget {
  static const route = "/market_default_hours";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<DefaultHoursNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchDefaultHoursCalled) {
          provider.fetchDefaultHours();
        }

        return provider.defaultHoursLoading
            ? Center(child: AppLoading())
            : provider.defaultHoursResult == null
                ? provider.defaultHoursErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.defaultHoursErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarketDefaultHoursList(
                          marketDefaultHours:
                              provider.defaultHoursResult!.data!,
                        ),
                        const SizedBox(height: 16),
                        ActionBtn(
                          text: Lang.of(context).edit,
                          onTap: () {
                            Routes.sailor.navigate(
                              EditDefaultHoursPage.route,
                              params: {
                                "marketDefaultHours":
                                    provider.defaultHoursResult
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).workingTimesPage,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
