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
        withPhoto: true,
      );

      loading = false;
      notifyListeners();
    }
  }
}
