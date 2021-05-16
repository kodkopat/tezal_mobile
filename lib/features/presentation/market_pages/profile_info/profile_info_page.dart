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
import '../../providers/market_providers/profile_notifier.dart';
import '../profile_info_edit/edit_profile_page.dart';

class ProfileInfoPage extends StatefulWidget {
  static const route = "/market_info_profile";

  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  String errorTxt = "";
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProfileNotifier>(
      builder: (context, provider, child) {
        if (!provider.wasFetchInfoCalled) {
          provider.fetchInfo();
        }

        return provider.infoLoading
            ? Center(child: AppLoading())
            : provider.infoResult == null
                ? provider.infoErrorMsg == null
                    ? Txt(
                        "خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : Txt(
                        provider.infoErrorMsg,
                        style: AppTxtStyles().body..alignment.center(),
                      )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileName +
                              ": " +
                              "${provider.infoResult!.data!.name}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileMobile +
                              ": " +
                              "${provider.infoResult!.data!.phone}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileTelephone +
                              ": " +
                              "${provider.infoResult!.data!.telephone}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileEmail +
                              ": " +
                              "${provider.infoResult!.data!.email}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileAddress +
                              ": " +
                              "${provider.infoResult!.data!.address}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Txt(
                          Lang.of(context).marketProfileShabaNumber +
                              ": " +
                              "${provider.infoResult!.data!.shabaNumber}",
                          style: AppTxtStyles().body..textAlign.start(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Txt(
                              Lang.of(context).marketProfileStatus + ": ",
                              style: AppTxtStyles().body..textAlign.start(),
                            ),
                            Switch(
                              value: provider.infoResult!.data!.isOpen ?? false,
                              onChanged: (value) async {
                                await provider.openClose(context);

                                if (provider.openCloseErrorMsg != null) {
                                  setState(() {
                                    errorTxt = provider.openCloseErrorMsg!;
                                    errorVisibility = true;
                                  });
                                } else {
                                  setState(() {
                                    errorTxt = "";
                                    errorVisibility = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ActionBtn(
                          text: Lang.of(context).edit,
                          onTap: () {
                            Routes.sailor.navigate(
                              EditProfilePage.route,
                              params: {"marketProfile": provider.infoResult!},
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Visibility(
                          visible: errorVisibility,
                          child: Txt(
                            errorTxt,
                            style: AppTxtStyles().footNote.clone()
                              ..textColor(Theme.of(context).errorColor)
                              ..alignmentContent.center()
                              ..height(24)
                              ..borderRadius(all: 2)
                              ..padding(horizontal: 4)
                              ..ripple(true),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).profilePage,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
