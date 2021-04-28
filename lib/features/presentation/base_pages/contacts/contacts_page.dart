// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/base_providers/contacts_notifier.dart';
import 'widgets/contact_list.dart';

class ContactsPage extends StatelessWidget {
  static const route = "/customer_contacts";

  @override
  Widget build(BuildContext context) {
    List<String> phoneNumbers = [];

    var consumer = Consumer<ContactsNotifier>(
      builder: (context, provider, child) {
        if (provider.contacts == null) {
          provider.fetchContacts();
        }

        return provider.contacts == null
            ? provider.errorMsg == null
                ? Txt("در حال بارگذاری...",
                    style: AppTxtStyles().body..alignment.center())
                : Txt(provider.errorMsg,
                    style: AppTxtStyles().body..alignment.center())
            : ContactList(
                contacts: provider.contacts!,
                phoneNumbers: phoneNumbers,
              );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "مخاطبین",
        showBackBtn: true,
      ),
      body: Column(
        children: [
          Expanded(child: consumer),
          Txt(
            "ارسال",
            gesture: Gestures()
              ..onTap(() {
                print(phoneNumbers.toString());
              }),
            style: AppTxtStyles().body
              ..bold()
              ..width(MediaQuery.of(context).size.width)
              ..height(48)
              ..textAlign.center()
              ..alignmentContent.center()
              ..background.color(Theme.of(context).accentColor)
              ..textColor(Colors.white)
              ..ripple(true),
          ),
        ],
      ),
    );
  }
}
