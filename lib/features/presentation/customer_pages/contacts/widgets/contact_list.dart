// ignore: import_of_legacy_library_into_null_safe
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'contact_list_item.dart';

class ContactList extends StatelessWidget {
  ContactList({required this.contacts});

  final Iterable<String> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var contact = contacts.toList()[index];
        return ContactListItem(
          text: contact,
          iconPath: "assets/images/ic_user.png",
          onTap: () {},
        );
      },
    );
  }
}
