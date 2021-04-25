// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/contacts_notifier.dart';
import 'widgets/contact_list.dart';

class ContactsPage extends StatelessWidget {
  static const route = "/customer_contacts";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ContactsNotifier>(
      builder: (context, provider, child) {
        if (provider.contacts == null) {
          provider.fetchContacts();
        }

        return provider.contacts == null
            ? provider.errorMsg == null
                ? Txt("خطای بارگذاری اطلاعات",
                    style: AppTxtStyles().body..alignment.center())
                : Txt(provider.errorMsg,
                    style: AppTxtStyles().body..alignment.center())
            : ContactList(contacts: provider.contacts!);
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "مخاطبین",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
