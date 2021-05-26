// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'contact_list_item.dart';

class ContactList extends StatelessWidget {
  ContactList({
    required this.contacts,
    required this.phoneNumbers,
  });

  final List<Contact> contacts;
  final List<String> phoneNumbers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: contacts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var contact = contacts[index];
        return ContactListItem(
          contact: contact,
          onValueChanged: (value) {
            if (value) {
              phoneNumbers.add(contact.phones.first.number);
            } else {
              phoneNumbers.remove(contact.phones.first.number);
            }
          },
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
