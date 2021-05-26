// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../base_providers/update_notifier.dart';

class UpdateDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<UpdateNotifier>(
      builder: (context, provider, child) {
        if (provider.hasNewVersionResult == null) {
          provider.fetchUpdateInfo();
        }

        return provider.hasNewVersionLoading
            ? Center(child: AppLoading())
            : provider.hasNewVersionResult == null
                ? provider.hasNewVersionErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.hasNewVersionErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : Txt(provider.hasNewVersionResult!.message,
                    style: AppTxtStyles().body..alignment.center());
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).settingsUpdate,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
