// ignore: import_of_legacy_library_into_null_safe
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'contact_list_item.dart';

class ContactList extends StatelessWidget {
  ContactList({required this.contacts});

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        var contact = contacts[index];
        return ContactListItem(
          contact: contact,
          iconPath: "assets/images/ic_user.png",
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.black12,
          thickness: 0.5,
          height: 0,
        );
      },
    );
  }
}
