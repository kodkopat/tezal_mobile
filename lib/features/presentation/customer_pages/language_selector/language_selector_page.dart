// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sailor/sailor.dart';

import '../../../../core/consts/consts.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/action_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/app_notifier.dart';
import 'widgets/language_selector_list.dart';

class LanguagesSelectorPage extends StatefulWidget {
  @override
  _LanguagesSelectorPageState createState() => _LanguagesSelectorPageState();
}

class _LanguagesSelectorPageState extends State<LanguagesSelectorPage> {
  int selectedIndex = 0;
  List<Locale> locales = [
    Locale("fa", "فارسی"),
    Locale("en", "Enlgish"),
    Locale("tr", "Turkish"),
  ];

  bool loading = true;

  void inintializeState() async {
    String currentLanguageCode = await FlutterSecureStorage().read(
      key: storageKeyLocalCode,
    );

    for (int i = 0; i < locales.length; i++) {
      if (locales[i].languageCode == currentLanguageCode) {
        selectedIndex = i;
        break;
      }
    }

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    inintializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "انتخاب زبان اپلیکیشن",
        showBackBtn: true,
      ),
      body: loading
          ? Center(child: AppLoading())
          : SingleChildScrollView(
              child: Column(
                children: [
                  LanguageSelectorList(
                    languageNames: locales.map((element) {
                      return "${element.countryCode}";
                    }).toList(),
                    selectedIndex: selectedIndex,
                    onIndexChanged: (index) {
                      setState(() => selectedIndex = index);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: ActionBtn(
                      text: "انتخاب",
                      onTap: () async {
                        String languageCode =
                            locales[selectedIndex].languageCode;
                        await FlutterSecureStorage().write(
                          key: storageKeyLocalCode,
                          value: languageCode,
                        );

                        Provider.of<AppNotifier>(context, listen: false)
                            .refresh();

                        Routes.sailor.pop();
                        Routes.sailor.pop();
                        Routes.sailor.navigate(
                          "/",
                          navigationType: NavigationType.pushReplace,
                        );
                        // Phoenix.rebirth(context);
                      },
                      background: AppTheme.customerPrimary,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
