import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsNotifier extends ChangeNotifier {
  static ContactsNotifier? _instance;

  factory ContactsNotifier() {
    if (_instance == null) {
      _instance = ContactsNotifier._privateConstructor();
    }

    return _instance!;
  }

  ContactsNotifier._privateConstructor();

  bool loading = true;
  String? errorMsg;
  List<Contact>? contacts;

  Future<void> fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
      print("contactsLength: ${contacts!.length}\n");

      var contactsTemp = <Contact>[];

      contacts!.forEach((element) {
        if (element.phones.isEmpty) {
          // remove contact that have no any phone number
        } else if (element.phones.length > 1) {
          // split contact that have more than one phone number
          for (int i = 0; i < element.phones.length; i++) {
            contactsTemp.add(
              Contact(
                name: element.name,
                displayName: element.displayName,
                phones: [element.phones[i]],
              ),
            );
          }
        } else {
          contactsTemp.add(element);
        }
      });

      contacts = contactsTemp;

      loading = false;
      notifyListeners();
    }
  }
}
