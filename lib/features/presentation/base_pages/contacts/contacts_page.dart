// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/load_more_btn.dart';
import '../../../../core/widgets/loading.dart';
import '../../base_providers/contacts_provider.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/contact_list.dart';

class ContactsPage extends ConsumerWidget {
  static const route = "/customer_contacts";

  @override
  Widget build(BuildContext context, watch) {
    List<String> phoneNumbers = [];

    var provider = watch(contactsProvider);

    if (!provider.wasFetchContactsCalled) {
      provider.fetchContacts(context);
    }

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).contacts,
        showBackBtn: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: provider.contactsLoading
                ? Center(child: AppLoading())
                : provider.paginatedContacts == null
                    ? provider.contactsErrorMsg == null
                        ? Txt("خطای بارگذاری اطلاعات",
                            style: AppTxtStyles().body..alignment.center())
                        : Txt(provider.contactsErrorMsg,
                            style: AppTxtStyles().body..alignment.center())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ContactList(
                              contacts: provider.paginatedContacts!,
                              phoneNumbers: phoneNumbers,
                            ),
                            if (provider.contactsEnableLoadMoreData!)
                              LoadMoreBtn(onTap: () {
                                provider.fetchContacts(context);
                              })
                          ],
                        ),
                      ),
          ),
          Txt(
            Lang.of(context).send,
            gesture: Gestures()
              ..onTap(() async {
                print(phoneNumbers.toString());

                await watch(contactsProvider).shareApplication(
                  context,
                  contactsJson: phoneNumbers,
                );

                Routes.sailor.pop();
              }),
            style: AppTxtStyles().body
              ..bold()
              ..width(MediaQuery.of(context).size.width)
              ..height(48)
              ..textAlign.center()
              ..alignmentContent.center()
              ..background.color(Theme.of(context).primaryColor)
              ..textColor(Colors.white)
              ..ripple(true),
          ),
        ],
      ),
    );
  }
}
